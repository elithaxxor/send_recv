import socket
import threading
import os
import logging
import time
from concurrent.futures import ThreadPoolExecutor
import struct
import signal
import sys

# Configuration
BUFFER_SIZE = 65536  # 64KB for faster transfers
CLIENT_PORT = 22223
MAX_WORKERS = 20  # Max concurrent threads
TIMEOUT = 30

# Logging setup
logging.basicConfig(
    filename='server.log',
    level=logging.INFO,  # Reduced from DEBUG
    format='%(asctime)s - %(levelname)s - %(message)s',
    filemode='a'
)

# Connection limiter
CONNECTION_POOL = threading.BoundedSemaphore(MAX_WORKERS)

# Check for sendfile (Linux only)
if sys.platform in ("linux", "linux2"):
    import sendfile

def send_directory_listing(client_socket):
    """Send list of available files to client."""
    try:
        files = [f for f in os.listdir('.') if os.path.isfile(f)]
        listing = "\n".join([f"{file} - {os.path.getsize(file)} bytes" for file in files]) or "No files available"
        header = struct.pack('Q', len(listing))
        client_socket.sendall(header)
        client_socket.sendall(listing.encode())
        logging.info("Sent directory listing to client")
    except Exception as e:
        logging.error(f"Directory listing error: {str(e)}")
        client_socket.sendall(struct.pack('Q', 0))  # Empty listing

def handle_client(client_socket, addr):
    """Handle a single client connection."""
    try:
        client_socket.settimeout(TIMEOUT)
        logging.info(f"Connection from {addr}")

        # Receive 4-byte command
        command = client_socket.recv(4).decode("utf-8")
        if len(command) != 4:
            raise ValueError("Incomplete command received")
        logging.info(f"Command {command} from {addr}")

        if command == "EXIT":
            return

        elif command == "LIST":
            send_directory_listing(client_socket)
            return

        elif command == "CHAT":
            client_socket.sendall(b"Chat feature not implemented")
            return

        elif command == "FILE":
            # Receive file name length (8 bytes)
            name_len_header = client_socket.recv(8)
            if len(name_len_header) < 8:
                raise ValueError("Incomplete file name length header")
            name_len = struct.unpack('Q', name_len_header)[0]

            # Receive file name
            file_name_bytes = client_socket.recv(name_len)
            if len(file_name_bytes) < name_len:
                raise ValueError("Incomplete file name")
            file_name = file_name_bytes.decode('utf-8')

            # Sanitize file name
            safe_file_name = os.path.basename(file_name)
            safe_file_path = os.path.join(os.getcwd(), safe_file_name)

            if not os.path.exists(safe_file_path):
                error_msg = f"File {safe_file_name} not found"
                logging.info(error_msg)
                client_socket.sendall(b"<ERROR>" + error_msg.encode())
                return

            file_size = os.path.getsize(safe_file_path)
            logging.info(f"Sending {safe_file_name}, {file_size} bytes")

            # Send file size to client
            client_socket.sendall(struct.pack('Q', file_size))

            # Send file
            with open(safe_file_path, "rb") as f:
                if sys.platform in ("linux", "linux2") and 'sendfile' in globals():
                    # Zero-copy transfer on Linux
                    offset = 0
                    bytes_sent = 0
                    while bytes_sent < file_size:
                        sent = sendfile.sendfile(client_socket.fileno(), f.fileno(), offset, BUFFER_SIZE)
                        if sent == 0:
                            break
                        offset += sent
                        bytes_sent += sent
                else:
                    # Fallback for other platforms
                    bytes_sent = 0
                    while bytes_sent < file_size:
                        data = f.read(BUFFER_SIZE)
                        if not data:
                            break
                        client_socket.sendall(data)
                        bytes_sent += len(data)

            logging.info("Transfer complete")
            print(f"[+] Transfer completed for {safe_file_name}")

        else:
            logging.error(f"Invalid command: {command}")
            client_socket.sendall(b"<ERROR>Invalid command")

    except (socket.timeout, ConnectionResetError, BrokenPipeError) as e:
        logging.error(f"Connection error with {addr}: {str(e)}")
    except ValueError as e:
        logging.error(f"Protocol error with {addr}: {str(e)}")
        client_socket.sendall(b"<ERROR>" + str(e).encode())
    except Exception as e:
        logging.error(f"Error with {addr}: {str(e)}")
    finally:
        client_socket.close()
        CONNECTION_POOL.release()
        logging.info(f"Closed connection with {addr}")

def main():
    """Set up and run the server."""
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(('', CLIENT_PORT))
    server_socket.listen(MAX_WORKERS)

    # Graceful shutdown
    shutdown_flag = False

    def signal_handler(sig, frame):
        nonlocal shutdown_flag
        shutdown_flag = True
        server_socket.close()
        logging.info("Server shutting down")
        print("[!] Server shutting down...")

    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    print(f"[+] Server running on port {CLIENT_PORT}")

    # Thread pool for concurrency
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        while not shutdown_flag:
            try:
                client_socket, addr = server_socket.accept()
                if not CONNECTION_POOL.acquire(blocking=False):
                    logging.warning("Max connections reached, rejecting client")
                    client_socket.close()
                    continue
                executor.submit(handle_client, client_socket, addr)
                print(f"[+] Active connections: {threading.active_count() - 1}")
            except OSError:
                if shutdown_flag:
                    break
                else:
                    logging.error("Socket error occurred", exc_info=True)

if __name__ == "__main__":
    main()
