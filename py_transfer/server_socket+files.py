import socket
import threading
import os
import logging
import time
from concurrent.futures import ThreadPoolExecutor
import sys

# Check if sendfile is available (Linux only)
if sys.platform in ("linux", "linux2"):
    import sendfile

# Configuration
BUFFER_SIZE = 65536  # 64KB buffer for faster transfers
CLIENT_PORT = 22223
MAX_WORKERS = 20  # Maximum number of concurrent threads

# Set up logging
logging.basicConfig(
    filename='server.log',
    level=logging.INFO,  # Reduced from DEBUG to INFO
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def handle_client(client_socket, addr):
    """Handle a single client connection."""
    try:
        logging.info(f"Connected to {addr}")
        print(f"[+] Connected to {addr}")

        # Receive file name and size from client
        file_name = client_socket.recv(100).decode('utf-8').strip('\0')
        file_size = int(client_socket.recv(100).decode('utf-8').strip('\0'))
        
        logging.info(f"Sending file: {file_name} of size: {file_size} bytes")
        print(f"[!] Sending file: {file_name} of size: {file_size} bytes")

        # Open the file and send it
        with open(file_name, "rb") as file:
            send_start = time.time()
            
            if sys.platform in ("linux", "linux2") and 'sendfile' in globals():
                # Use sendfile for zero-copy transfer on Linux
                offset = 0
                bytes_sent = 0
                while bytes_sent < file_size:
                    sent = sendfile.sendfile(client_socket.fileno(), file.fileno(), offset, BUFFER_SIZE)
                    if sent == 0:
                        break
                    offset += sent
                    bytes_sent += sent
            else:
                # Fallback to standard sendall for other platforms
                bytes_sent = 0
                while bytes_sent < file_size:
                    data = file.read(BUFFER_SIZE)
                    if not data:
                        break
                    client_socket.sendall(data)
                    bytes_sent += len(data)
            
            send_end = time.time()
            logging.info(f"Transfer complete in {send_end - send_start:.2f} seconds")
            print(f"[+] Transfer complete in {send_end - send_start:.2f} seconds")

    except FileNotFoundError:
        logging.error(f"File {file_name} not found")
        print(f"Error: File {file_name} not found")
    except Exception as e:
        logging.error(f"Error: {e}")
        print(f"Error: {e}")
    finally:
        client_socket.close()
        logging.info(f"Client socket closed for {addr}")
        print(f"[-] Client socket closed for {addr}")

def main():
    """Set up and run the server."""
    # Create and configure server socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((socket.gethostname(), CLIENT_PORT))
    server_socket.listen(5)
    logging.info(f"Server listening on port {CLIENT_PORT}")
    print(f"[!] Server is running on port {CLIENT_PORT}. Waiting for connections...")

    # Use ThreadPoolExecutor to manage client connections
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        try:
            while True:
                client_socket, addr = server_socket.accept()
                executor.submit(handle_client, client_socket, addr)
        except KeyboardInterrupt:
            logging.info("Server shutting down")
            print("[!] Server shutting down")
        finally:
            server_socket.close()

if __name__ == "__main__":
    logging.info("Starting server...")
    print("[!] Starting server with threading and optimizations...")
    main()
