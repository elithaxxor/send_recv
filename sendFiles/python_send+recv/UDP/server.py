import socket
import os
import time
from tqdm import tqdm
from colorama import Fore, Style, init
from dataclasses import dataclass
import struct

# Initialize colorama for colored output
init(autoreset=True)

# Define a dataclass to store server configuration
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

# Helper function for styled printing
def print_styled(prefix, message, prefix_color=Fore.CYAN, message_color=Fore.WHITE):
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
print_styled("[SYS]", f"Socket type: {Fore.BLUE}{type(server_config.server_socket)}")

# Bind and listen on the socket
server_config.server_socket.bind((server_config.local_ip, server_config.port))
server_config.server_socket.listen(5)  # Max queue of 5 connections
print_styled("[SYSTEM]", f"Server is listening on {Fore.YELLOW}{server_config.server_socket.getsockname()}")

# Function to handle client connections
def handle_client(client_socket, addr):
    file_name = input(f"{Fore.GREEN}[SYSTEM]{Style.RESET_ALL} Enter File Name: ")
    if not os.path.exists(file_name):
        print_styled("[SYSTEM]", f"File {file_name} not found", Fore.RED)
        client_socket.close()
        return
    file_size = os.path.getsize(file_name)

    print_styled("[SYSTEM]", f"Connected to {Fore.BLUE}{client_socket}{Style.RESET_ALL}, {Fore.YELLOW}{addr}")
    print_styled("[SYSTEM]", f"{Fore.CYAN}{file_name}{Style.RESET_ALL} is {Fore.YELLOW}{file_size}{Style.RESET_ALL} bytes large")

    # Send file name and size to client
    client_socket.send(file_name.encode())
    client_socket.send(struct.pack('!Q', file_size))

    # Open and send file in binary mode
    with open(file_name, "rb", buffering=30000) as file:
        send_count = 0
        send_start = time.time()

        # Progress bar for sending
        progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=f"{Fore.CYAN}Sending {file_name}{Style.RESET_ALL}", bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.CYAN, Style.RESET_ALL))

        while send_count < file_size:
            data = file.read(8192)
            if not data:
                break  # End of file
            try:
                client_socket.sendall(data)
                send_count += len(data)
                progress.update(len(data))
            except socket.error:
                print_styled("[SYSTEM]", "Client disconnected unexpectedly", Fore.RED)
                break

        progress.close()
        send_end = time.time()

    total_time = send_end - send_start
    print_styled("[SYSTEM]", f"{Fore.CYAN}{file_name}{Style.RESET_ALL} Transfer Complete in: {Fore.YELLOW}{total_time:.2f}{Style.RESET_ALL} seconds")
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
