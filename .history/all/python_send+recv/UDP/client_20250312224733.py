import os
import socket
import time
from colorama import Fore, Style, init
import struct

# Initialize colorama for colored output
init(autoreset=True)

class ClientConfig:
    def __init__(self):
        self.DEFAULT_SERVER_IP = "192.168.1.77"  # Adjust as needed
        self.CPORT = 5555
        self.server_host = self.get_server_ip()
        self.client_name = socket.gethostname()
        self.client_IP = socket.gethostbyname(self.client_name)
        self.client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def get_server_ip(self):
        """Prompt user for server IP."""
        user_choice = input(Fore.YELLOW + '[SYSTEM]** Press 1 for default box (192.168.1.77) or any other key for custom IP: ')
        if user_choice == '1':
            return self.DEFAULT_SERVER_IP
        else:
            return input(Fore.YELLOW + '[SYSTEM]** Enter the server IP for connection: ')

def receive_directory(client_socket, base_dir):
    """Receive a directory recursively from the server."""
    while True:
        header = client_socket.recv(1024).decode()
        if not header:
            break
        parts = header.split('|')
        if parts[0] == 'D':
            # Create directory
            dir_path = os.path.join(base_dir, parts[1])
            os.makedirs(dir_path, exist_ok=True)
            print(Fore.GREEN + f"[SYSTEM] Created directory: {dir_path}")
        elif parts[0] == 'F':
            # Receive file
            file_path = os.path.join(base_dir, parts[1])
            file_size = int(parts[2])
            with open(file_path, 'wb') as file:
                receive_count = 0
                while receive_count < file_size:
                    data = client_socket.recv(8192)
                    if not data:
                        break
                    file.write(data)
                    receive_count += len(data)
                print(Fore.GREEN + f"[SYSTEM] Received file: {file_path} ({file_size} bytes)")

def main():
    config = ClientConfig()

    # Connect to the server with retry logic
    while True:
        try:
            config.client_socket.connect((config.server_host, config.CPORT))
            print(Fore.GREEN + f'[SYSTEM][CONNECTING..] {config.server_host} : {config.CPORT}')
            print(Fore.GREEN + f'Hello {config.client_name}, you are connected on: {config.client_IP}')
            break
        except socket.error as e:
            print(Fore.RED + f"[SYSTEM]*[ERROR] Unable to connect to {config.server_host} - {str(e)}")
            print("Retrying in 5 seconds...")
            time.sleep(5)

    # Receive type indicator
    type_indicator = config.client_socket.recv(1).decode()
    
    if type_indicator == 'D':
        # Receive directory
        receive_directory(config.client_socket, '.')
        
    elif type_indicator == 'F':
        # Receive single file
        file_name = config.client_socket.recv(100).decode('utf-8')
        file_size_bytes = config.client_socket.recv(8)
        file_size = struct.unpack('!Q', file_size_bytes)[0]
        
        print(Fore.GREEN + f'[SYSTEM]** {file_name} is : {file_size} bytes \n[SYSTEM].. Initiating File Transfer.')
        
        with open(file_name, 'wb') as file:
            receive_count = 0
            while receive_count < file_size:
                data = config.client_socket.recv(8192)
                if not data:
                    break
                file.write(data)
                receive_count += len(data)
                progress = (receive_count / file_size) * 100
                print(Fore.MAGENTA + f'\r[SYSTEM] Progress: {progress:.2f}% ({receive_count}/{file_size} bytes)', end='')
        print(Fore.GREEN + f"\n[SYSTEM] File {file_name} received successfully.")

    config.client_socket.close()

if __name__ == "__main__":
    main()
