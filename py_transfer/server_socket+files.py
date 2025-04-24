import socket
import threading
import os
import logging
import time
from concurrent.futures import ThreadPoolExecutor
import sys
import signal
from utils import recv_exact, is_safe_filename, PROTOCOL_VERSION
import struct

# Try to import sendfile if available (Linux only)
try:
    if sys.platform in ("linux", "linux2"):
        import os as _os_sendfile
        HAS_SENDFILE = hasattr(_os_sendfile, 'sendfile')
    else:
        HAS_SENDFILE = False
except ImportError:
    HAS_SENDFILE = False

# Directory to serve files from (security)
SHARED_DIR = os.path.abspath(os.environ.get('SHARED_DIR', './shared_files'))
os.makedirs(SHARED_DIR, exist_ok=True)

# --- Protocol Constants ---
FILE_NAME_SIZE = 100
FILE_SIZE_SIZE = 8  # 8 bytes for file size (unsigned long long)
BUFFER_SIZE = 65536  # 64KB buffer for faster transfers
DEFAULT_PORT = 22223
MAX_WORKERS = 20  # Maximum number of concurrent threads

# Set up logging to both file and console
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('server.log'),
        logging.StreamHandler(sys.stdout)
    ])

def protocol_version_handshake(client_socket):
    """
    Perform protocol version negotiation with the client.
    Returns True if compatible, False otherwise.
    """
    client_socket.sendall(PROTOCOL_VERSION.encode('utf-8').ljust(16, b'\0'))
    client_version = client_socket.recv(16).decode('utf-8').strip('\0')
    if client_version != PROTOCOL_VERSION:
        client_socket.sendall(b'INCOMPATIBLE_VERSION')
        logging.warning(f"Protocol version mismatch: client {client_version}, server {PROTOCOL_VERSION}")
        return False
    return True


def send_file_zerocopy(client_socket, file_path):
    """
    Send a file to the client using zero-copy transfer if available (os.sendfile),
    otherwise fall back to manual buffer send.
    """
    file_size = os.path.getsize(file_path)
    client_socket.sendall(struct.pack('Q', file_size))
    with open(file_path, "rb") as f:
        if HAS_SENDFILE:
            offset = 0
            while offset < file_size:
                sent = os.sendfile(client_socket.fileno(), f.fileno(), offset, file_size - offset)
                if sent == 0:
                    break
                offset += sent
        else:
            while True:
                data = f.read(BUFFER_SIZE)
                if not data:
                    break
                client_socket.sendall(data)
    logging.info(f"Sent file {file_path} ({file_size} bytes)")


def handle_client(client_socket, addr):
    """
    Handle a single client connection. Supports file transfer and chat.
    Uses binary headers for protocol efficiency.
    """
    try:
        logging.info(f"Connected to {addr}")
        print(f"[+] Connected to {addr}")
        # Protocol version handshake
        if not protocol_version_handshake(client_socket):
            client_socket.close()
            logging.info(f"Disconnected {addr} due to protocol mismatch.")
            return
        # Authenticate (if enabled)
        if 'AUTH_REQUIRED' in globals() and AUTH_REQUIRED:
            if not authenticate_client(client_socket):
                logging.info(f"Authentication failed for {addr}")
                client_socket.close()
                return
            logging.info(f"Authentication succeeded for {addr}")
        while True:
            try:
                # Receive command header (4 bytes)
                cmd = client_socket.recv(4)
                if not cmd:
                    logging.info(f"Connection closed by {addr}")
                    break
                cmd = cmd.decode('utf-8').strip().upper()
                if cmd == 'FILE':
                    # Receive file name length (2 bytes) and file name
                    name_len = struct.unpack('H', client_socket.recv(2))[0]
                    file_name = client_socket.recv(name_len).decode('utf-8')
                    # Security: restrict to SHARED_DIR and validate
                    abs_path = os.path.abspath(os.path.join(SHARED_DIR, file_name))
                    if not abs_path.startswith(SHARED_DIR) or not is_safe_filename(file_name) or not os.path.exists(abs_path):
                        client_socket.sendall(struct.pack('Q', 0))
                        logging.warning(f"Unsafe or missing file request from {addr}: {file_name}")
                        continue
                    send_file_zerocopy(client_socket, abs_path)
                elif cmd == 'CHAT':
                    # Receive message length (2 bytes) and message
                    msg_len = struct.unpack('H', client_socket.recv(2))[0]
                    msg = client_socket.recv(msg_len).decode('utf-8')
                    logging.info(f"[CHAT] {addr}: {msg}")
                    client_socket.sendall(b'CHAT_RECEIVED')
                else:
                    logging.warning(f"Unknown protocol from {addr}: {cmd}")
                    client_socket.sendall(b'UNKNOWN_PROTOCOL')
            except Exception as e:
                logging.error(f"Error handling client {addr}: {e}")
                break
        client_socket.close()
        logging.info(f"Connection with {addr} closed.")
    except Exception as e:
        logging.error(f"Error handling client {addr}: {e}")
        print(f"Error handling client {addr}: {e}")
    finally:
        try:
            client_socket.close()
        except Exception:
            pass
        logging.info(f"Connection to {addr} closed")
        print(f"[-] Connection to {addr} closed")


def main():
    import argparse
    parser = argparse.ArgumentParser(description='File Transfer Server')
    parser.add_argument('--port', type=int, default=int(os.environ.get('FT_PORT', DEFAULT_PORT)), help='Port to listen on')
    parser.add_argument('--shared-dir', type=str, default=SHARED_DIR, help='Directory to serve files from')
    args = parser.parse_args()
    port = args.port
    shared_dir = os.path.abspath(args.shared_dir)
    global SHARED_DIR
    SHARED_DIR = shared_dir
    os.makedirs(SHARED_DIR, exist_ok=True)

    # Setup server socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        try:
            server_socket.bind(("0.0.0.0", port))
        except OSError as e:
            logging.error(f"Failed to bind to port {port}: {e}")
            print(f"[ERROR] Failed to bind to port {port}: {e}")
            sys.exit(1)
        server_socket.listen(5)
        logging.info(f"Server listening on port {port}, sharing dir: {SHARED_DIR}")
        print(f"[!] Server listening on port {port}, sharing dir: {SHARED_DIR}")

        # Graceful shutdown
        stop_event = threading.Event()
        def shutdown_handler(signum, frame):
            logging.info("Shutting down server...")
            print("[!] Shutting down server...")
            stop_event.set()
            server_socket.close()
        signal.signal(signal.SIGINT, shutdown_handler)
        signal.signal(signal.SIGTERM, shutdown_handler)

        with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
            try:
                while not stop_event.is_set():
                    try:
                        client_sock, addr = server_socket.accept()
                        executor.submit(handle_client, client_sock, addr)
                    except OSError:
                        # Socket closed, likely due to shutdown
                        break
            except Exception as e:
                logging.error(f"Server error: {e}")
                print(f"[ERROR] Server error: {e}")


if __name__ == "__main__":
    logging.info("Starting server...")
    print("[!] Starting server with threading and optimizations...")
    main()