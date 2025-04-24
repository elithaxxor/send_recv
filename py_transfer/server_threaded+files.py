import socket
import threading
import os
import logging
import time
from concurrent.futures import ThreadPoolExecutor
import struct
import signal
import sys
import re
from utils import recv_exact, is_safe_filename, PROTOCOL_VERSION

# --- Protocol Constants ---
CMD_SIZE = 4
SIZE_HEADER = 8
BUFFER_SIZE = int(os.environ.get('FT_BUFFER', 65536))  # Configurable buffer size
DEFAULT_PORT = 22223
MAX_WORKERS = 20  # Max concurrent threads
TIMEOUT = 30
SAFE_COMMANDS = {"EXIT", "LIST", "CHAT", "FILE", "BATCH", "UPLOAD"}

# --- Authentication ---
AUTH_REQUIRED = True
AUTH_USER = os.environ.get('FT_USER', "user")
AUTH_PASS = os.environ.get('FT_PASS', "pass123")

# Logging setup
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('server_threaded.log'),
        logging.StreamHandler(sys.stdout)
    ]
)

CONNECTION_POOL = threading.BoundedSemaphore(MAX_WORKERS)

# Try to import sendfile if available (Linux only)
try:
    if sys.platform in ("linux", "linux2"):
        import sendfile
        HAS_SENDFILE = True
    else:
        HAS_SENDFILE = False
except ImportError:
    HAS_SENDFILE = False

def send_directory_listing(client_socket):
    """Send list of available files to client."""
    try:
        files = [f for f in os.listdir('.') if os.path.isfile(f) and is_safe_filename(f)]
        listing = "\n".join([f"{file} - {os.path.getsize(file)} bytes" for file in files]) or "No files available"
        header = struct.pack('Q', len(listing))
        client_socket.sendall(header)
        client_socket.sendall(listing.encode())
        logging.info("Sent directory listing to client")
    except Exception as e:
        logging.error(f"Directory listing error: {str(e)}")
        client_socket.sendall(struct.pack('Q', 0))  # Empty listing

def authenticate_client(client_socket):
    """Authenticate client before proceeding."""
    try:
        user_len_bytes = recv_exact(client_socket, SIZE_HEADER)
        user_len = struct.unpack('Q', user_len_bytes)[0]
        username = recv_exact(client_socket, user_len).decode('utf-8')
        pass_len_bytes = recv_exact(client_socket, SIZE_HEADER)
        pass_len = struct.unpack('Q', pass_len_bytes)[0]
        password = recv_exact(client_socket, pass_len).decode('utf-8')
        if username == AUTH_USER and password == AUTH_PASS:
            client_socket.sendall(b"AUTH_OK")
            return True
        else:
            client_socket.sendall(b"AUTH_FAIL")
            return False
    except Exception as e:
        logging.error(f"Authentication error: {str(e)}")
        client_socket.sendall(b"AUTH_FAIL")
        return False

def send_file(client_socket, file_name):
    """Send a file to the client with progress bar support."""
    if not is_safe_filename(file_name) or not os.path.exists(file_name):
        client_socket.sendall(struct.pack('Q', 0))
        return
    file_size = os.path.getsize(file_name)
    client_socket.sendall(struct.pack('Q', file_size))
    with open(file_name, "rb") as f:
        try:
            from tqdm import tqdm
            use_tqdm = True
        except ImportError:
            use_tqdm = False
        progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=file_name) if use_tqdm else None
        sent = 0
        while sent < file_size:
            data = f.read(BUFFER_SIZE)
            if not data:
                break
            client_socket.sendall(data)
            sent += len(data)
            if use_tqdm:
                progress.update(len(data))
        if use_tqdm:
            progress.close()
    logging.info(f"Sent file {file_name} ({file_size} bytes)")

def receive_file(client_socket, dest_file):
    """Receive a file from the client and save it as dest_file."""
    size_bytes = recv_exact(client_socket, SIZE_HEADER)
    file_size = struct.unpack('Q', size_bytes)[0]
    if file_size == 0:
        return False
    with open(dest_file, "wb") as f:
        received = 0
        try:
            from tqdm import tqdm
            use_tqdm = True
        except ImportError:
            use_tqdm = False
        progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=dest_file) if use_tqdm else None
        while received < file_size:
            chunk = client_socket.recv(min(BUFFER_SIZE, file_size - received))
            if not chunk:
                break
            f.write(chunk)
            received += len(chunk)
            if use_tqdm:
                progress.update(len(chunk))
        if use_tqdm:
            progress.close()
    return received == file_size

def handle_client(client_socket, addr):
    try:
        client_socket.settimeout(TIMEOUT)
        logging.info(f"Connection from {addr}")
        # Protocol version
        client_socket.sendall(PROTOCOL_VERSION.encode('utf-8').ljust(16, b'\0'))
        # Authenticate
        if AUTH_REQUIRED:
            if not authenticate_client(client_socket):
                logging.info(f"Authentication failed for {addr}")
                client_socket.close()
                CONNECTION_POOL.release()
                return
            logging.info(f"Authentication succeeded for {addr}")
        while True:
            # Receive 4-byte command
            command_bytes = recv_exact(client_socket, CMD_SIZE)
            command = command_bytes.decode("utf-8").strip().upper()
            if len(command) == 0 or command not in SAFE_COMMANDS:
                client_socket.sendall(b'ERRC')
                continue
            logging.info(f"Command {command} from {addr}")
            if command == "EXIT":
                break
            elif command == "LIST":
                send_directory_listing(client_socket)
            elif command == "FILE":
                # Receive file name
                name_len_bytes = recv_exact(client_socket, SIZE_HEADER)
                name_len = struct.unpack('Q', name_len_bytes)[0]
                file_name = recv_exact(client_socket, name_len).decode('utf-8')
                send_file(client_socket, file_name)
            elif command == "BATCH":
                # Receive number of files
                count_bytes = recv_exact(client_socket, SIZE_HEADER)
                count = struct.unpack('Q', count_bytes)[0]
                for _ in range(count):
                    name_len_bytes = recv_exact(client_socket, SIZE_HEADER)
                    name_len = struct.unpack('Q', name_len_bytes)[0]
                    file_name = recv_exact(client_socket, name_len).decode('utf-8')
                    send_file(client_socket, file_name)
            elif command == "UPLOAD":
                # Receive file name
                name_len_bytes = recv_exact(client_socket, SIZE_HEADER)
                name_len = struct.unpack('Q', name_len_bytes)[0]
                file_name = recv_exact(client_socket, name_len).decode('utf-8')
                # Save as uploads/<filename>
                os.makedirs('uploads', exist_ok=True)
                dest_file = os.path.join('uploads', file_name)
                receive_file(client_socket, dest_file)
                logging.info(f"Received uploaded file: {file_name}")
            elif command == "CHAT":
                # Receive chat message
                msg_len_bytes = recv_exact(client_socket, SIZE_HEADER)
                msg_len = struct.unpack('Q', msg_len_bytes)[0]
                msg = recv_exact(client_socket, msg_len).decode('utf-8')
                logging.info(f"Chat from {addr}: {msg}")
                # Echo back
                client_socket.sendall(struct.pack('Q', len(msg)))
                client_socket.sendall(msg.encode('utf-8'))
    except Exception as e:
        logging.error(f"Error handling client {addr}: {e}")
    finally:
        client_socket.close()
        CONNECTION_POOL.release()
        logging.info(f"Connection to {addr} closed")

def main():
    import argparse
    parser = argparse.ArgumentParser(description='Threaded File Transfer Server')
    parser.add_argument('--port', type=int, default=int(os.environ.get('FT_PORT', DEFAULT_PORT)), help='Port to listen on')
    args = parser.parse_args()
    port = args.port
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try:
        server_socket.bind(("0.0.0.0", port))
    except OSError as e:
        logging.error(f"Failed to bind to port {port}: {e}")
        print(f"[ERROR] Failed to bind to port {port}: {e}")
        sys.exit(1)
    server_socket.listen(5)
    logging.info(f"Server listening on port {port}")
    print(f"[!] Server listening on port {port}")
    def shutdown_handler(signum, frame):
        logging.info("Shutting down server...")
        print("[!] Shutting down server...")
        server_socket.close()
        sys.exit(0)
    signal.signal(signal.SIGINT, shutdown_handler)
    signal.signal(signal.SIGTERM, shutdown_handler)
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        try:
            while True:
                CONNECTION_POOL.acquire()
                client_sock, addr = server_socket.accept()
                executor.submit(handle_client, client_sock, addr)
        except Exception as e:
            logging.error(f"Server error: {e}")
            print(f"[ERROR] Server error: {e}")
        finally:
            server_socket.close()

if __name__ == "__main__":
    logging.info("Starting threaded server...")
    print("[!] Starting threaded server...")
    main()
