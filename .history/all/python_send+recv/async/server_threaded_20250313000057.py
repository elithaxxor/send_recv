import json
import socket
import threading
import os
import logging
import time
import struct
import signal

BUFFER_SIZE = 16384
CLIENT_PORT = 22223
MAX_CONNECTIONS = 50
TIMEOUT = 30

# Single logging configuration
logging.basicConfig(
    filename='server.log',
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filemode='a'
)

# Connection limiter
CONNECTION_POOL = threading.BoundedSemaphore(MAX_CONNECTIONS)

def send_directory_listing(client_socket):
    """Send list of available files to client"""
    try:
        # Get list of files (excluding directories)
        files = [f for f in os.listdir('.') if os.path.isfile(f)]
        # Create formatted listing
        listing = "\n".join([
            f"{file} - {os.path.getsize(file)} bytes"
            for file in files
        ]) or "No files available"
        logging.info(f"[+] {client_socket} requested Listings available")
        # Send listing with header
        header = struct.pack('Q', len(listing))
        client_socket.sendall(header)
        client_socket.sendall(listing.encode())
        logging.info("Sent directory listing to client")
    except Exception as e:
        logging.error(f"Directory listing error: {str(e)}")
        client_socket.sendall(struct.pack('Q', 0))  # Send empty listing

def handle_clients1(client_socket, addr):
    try:
        client_socket.settimeout(TIMEOUT)
        logging.info(f"Connection from {addr}")
        print(f"[+] Connected to {addr}")
        
        # Read command with length prefix
        command_len_bytes = client_socket.recv(4)
        if not command_len_bytes:
            return
        command_len = struct.unpack('!I', command_len_bytes)[0]
        command = client_socket.recv(command_len).decode().strip()
        logging.info(f"[!] Command {command} called by: {addr}")
        
        if command == "EXIT":
            client_socket.close()
            return

        if command == "LIST":
            send_directory_listing(client_socket)
            return
        
        elif command == "CHAT":
            # Placeholder for chat implementation
            logging.info("CHAT command received but not implemented")
            client_socket.sendall(b"Chat feature not implemented")
            return
       
        elif command == 'FILE':
            # Receive file name length first (fixed size header)
            name_len_header = client_socket.recv(8)
            name_len = struct.unpack('Q', name_len_header)[0]
            # Now receive the filename
            file_name_bytes = client_socket.recv(name_len)
            file_name = file_name_bytes.decode('utf-8')
            # Security: sanitize filename
            safe_file_name = os.path.basename(file_name)
            safe_file_path = os.path.join(os.getcwd(), safe_file_name)
            if not os.path.exists(safe_file_path):
                error_msg = f"File {safe_file_name} not found"
                logging.info(f"[-] {error_msg}")
                client_socket.sendall(b"<ERROR>" + error_msg.encode())
                return
            file_size = os.path.getsize(safe_file_path)
            logging.info(f"Sending {safe_file_name}, {file_size} bytes")
            # Send file size to client
            client_socket.sendall(struct.pack('Q', file_size))
            bytes_sent = 0
            start_time = time.time()
            with open(safe_file_path, "rb") as f:
                while True:
                    data = f.read(BUFFER_SIZE)
                    if not data:
                        break
                    try:
                        client_socket.sendall(data)
                        bytes_sent += len(data)
                    except (ConnectionAbortedError, BrokenPipeError):
                        logging.error("Client disconnected during file transfer")
                        break
            duration = time.time() - start_time
            logging.info(f"[+] Transfer complete in {duration:.2f}s")
            print(f"[+] Transfer completed in {duration:.2f} seconds")
            
        else:
            logging.error(f"Invalid command: {command}")
            client_socket.sendall(b"<ERROR>Invalid command")
                
    except Exception as e:
        logging.error(f"Error with {addr}: {str(e)}")
        try:
            client_socket.sendall(f"<ERROR>{str(e)}".encode())
        except:
            pass  # Client likely disconnected
    finally:
        client_socket.close()
        CONNECTION_POOL.release()
        logging.info(f"[+] Closed connection with {addr}")

def main():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(('', CLIENT_PORT))  # Bind to all interfaces
    server_socket.listen(MAX_CONNECTIONS)

    # Graceful shutdown handling
    shutdown_flag = False
    
    def signal_handler(sig, frame):
        nonlocal shutdown_flag
        shutdown_flag = True
        server_socket.close()
        logging.info("Server shutting down")
        print("[!] Server shutting down...")

    # Register signal handlers
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    print(f"[+] Server running on port {CLIENT_PORT}")
    
    while not shutdown_flag:
        try:
            client_socket, addr = server_socket.accept()
            CONNECTION_POOL.acquire()
            client_thread = threading.Thread(
                target=handle_clients1,
                args=(client_socket, addr),
                daemon=True
            )
            client_thread.start()
            print(f"[+] Active connections: {threading.active_count() - 1}")
        except OSError:
            if shutdown_flag:
                break
            else:
                logging.error("Socket error occurred", exc_info=True)

if __name__ == "__main__": 
    main()

