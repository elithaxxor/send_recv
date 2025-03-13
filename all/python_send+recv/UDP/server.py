import socket
import os
import time
from colorama import Fore, Style, init
from dataclasses import dataclass
import struct

# Initialize colorama for colored output
init(autoreset=True)

# Define a dataclass for server configuration
@dataclass
class ServerConfig:
    local_ip: str
    port: int
    client_name: str
    ip: str
    server_socket: socket.socket

def get_local_ip():
    """Fetch the local IP address dynamically."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception as e:
        return f"Error: {e}"

def print_styled(prefix, message, prefix_color=Fore.CYAN, message_color=Fore.WHITE):
    """Helper function for styled printing."""
    print(f"{prefix_color}{prefix}{Style.RESET_ALL} {message_color}{message}{Style.RESET_ALL}")

# Initialize server configuration
local_ip = get_local_ip()
PORT = 5555
client_name = socket.gethostname()
IP = socket.gethostbyname(client_name)
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_config = ServerConfig(
    local_ip=local_ip,
    port=PORT,
    client_name=client_name,
    ip=IP,
    server_socket=server_socket
)

# Display server configuration
print_styled("[SYS]", f"Connected to {Fore.GREEN}{server_config.client_name}{Style.RESET_ALL} with IP {Fore.YELLOW}{server_config.ip}{Style.RESET_ALL} at port: {Fore.MAGENTA}{server_config.port}")
print(f"Your local IP address is: {server_config.local_ip}")
print_styled("[SYS]", f"Initiating connection.. {Fore.BLUE}{server_config.server_socket}")

# Bind and listen
server_config.server_socket.bind((server_config.local_ip, server_config.port))
server_config.server_socket.listen(5)
print_styled("[SYSTEM]", f"Server is listening on {Fore.YELLOW}{server_config.server_socket.getsockname()}")

def send_directory(client_socket, dir_path, base_path):
    """Send a directory recursively to the client."""
    for root, dirs, files in os.walk(dir_path):
        relative_root = os.path.relpath(root, base_path)
        
        # Send directory metadata
        dir_header = f"D|{relative_root}"
        client_socket.sendall(dir_header.encode())
        
        # Send files in the current directory
        for file in files:
            file_path = os.path.join(root, file)
            relative_file_path = os.path.join(relative_root, file)
            file_size = os.path.getsize(file_path)
            
            # Send file metadata
            file_header = f"F|{relative_file_path}|{file_size}"
            client_socket.sendall(file_header.encode())
            
            # Send file content
            with open(file_path, "rb") as f:
                while True:
                    data = f.read(8192)
                    if not data:
                        break
                    client_socket.sendall(data)

def handle_client(client_socket, addr):
    """Handle incoming client connections."""
    path = input(f"{Fore.GREEN}[SYSTEM]{Style.RESET_ALL} Enter File or Directory Name: ")
    if not os.path.exists(path):
        print_styled("[SYSTEM]", f"Path {path} not found", Fore.RED)
        client_socket.close()
        return
    
    if os.path.isdir(path):
        # Indicate directory transfer
        client_socket.sendall(b"D")
        send_directory(client_socket, path, path)
        
    else:
        
        # Indicate file transfer
        client_socket.sendall(b"F")
        file_name = os.path.basename(path)
        file_size = os.path.getsize(path)
        
        # Send file name and size
        client_socket.sendall(file_name.encode())
        client_socket.sendall(struct.pack('!Q', file_size))
        
        # Send file content
        with open(path, "rb") as file:
            while True:
                data = file.read(8192)
                if not data:
                    break
                client_socket.sendall(data)
    
    client_socket.close()

# Main server loop
start_time = time.time()
try:
    while True:
        elapsed_minutes = (time.time() - start_time) / 60
        print_styled("[SYSTEM]", f"Waiting for client connection... (Elapsed time: {Fore.YELLOW}{elapsed_minutes:.1f}{Style.RESET_ALL} minutes)")
        client_socket, addr = server_config.server_socket.accept()
        print_styled("[SYSTEM]", f"Accepted connection from {Fore.YELLOW}{addr}")
        handle_client(client_socket, addr)
except KeyboardInterrupt:
    print_styled("[SYSTEM]", "Server is shutting down...", Fore.RED)
finally:
    server_config.server_socket.close()
