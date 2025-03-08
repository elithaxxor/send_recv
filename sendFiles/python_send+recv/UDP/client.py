import os
import socket
import time
import sys
from colorama import Fore, Style, init
import struct

# Initialize colorama for colored output
init(autoreset=True)

class ClientConfig:
    def __init__(self):
        self.DEFAULT_SERVER_IP = "192.168.1.77"
        self.CPORT = 5555
        self.server_host = self.get_server_ip()
        self.client_name = socket.gethostname()
        self.client_IP = socket.gethostbyname(self.client_name)
        self.client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def get_server_ip(self):
        user_choice = input(Fore.YELLOW + '[SYSTEM]** Press 1 for default box (192.168.1.77) or any other key for custom IP: ')
        if user_choice == '1':
            return self.DEFAULT_SERVER_IP
        else:
            return input(Fore.YELLOW + '[SYSTEM]** Enter the server IP for connection: ')

def main():
    config = ClientConfig()

    # Retry connection in a loop until successful
    while True:
        try:
            config.client_socket.connect((config.server_host, config.CPORT))
            print(Fore.GREEN + f'[SYSTEM][CONNECTING..] {config.server_host} : {config.CPORT}')
            print(Fore.GREEN + f'Hello {config.client_name}, you are connected on: {config.client_IP}')
            break  # Exit loop on successful connection
        except socket.timeout:
            print(Fore.RED + f"[SYSTEM]*[ERROR] Connection timed out to {config.server_host}")
            print("Retrying in 5 seconds...")
            time.sleep(5)
        except socket.error as e:
            print(Fore.RED + f"[SYSTEM]*[ERROR] Unable to connect to {config.server_host} - {str(e)}")
            print("Retrying in 5 seconds...")
            time.sleep(5)

    # Display server's local IP
    server_IP = config.client_socket.getsockname()[0]
    print(Fore.CYAN + f'[SYSTEM] Server Local IP: {server_IP}')

    # Receive file parameters from server
    file_name = config.client_socket.recv(100).decode('utf-8')
    file_size_bytes = config.client_socket.recv(8)
    
    try:
        file_size_int = struct.unpack('!Q', file_size_bytes)[0]
    except struct.error:
        print(Fore.RED + "[SYSTEM]*[ERROR] Invalid file size received from server")
        config.client_socket.close()
        return

    print(Fore.GREEN + f'[SYSTEM]** {file_name} is : {file_size_int} bytes \n[SYSTEM].. Initiating File Transfer.')

    # Receive and write the file in binary mode
    start_time = time.time()
    with open(file_name, 'wb') as file:
        receive_count = 0
        while receive_count < file_size_int:
            data = config.client_socket.recv(8192)
            if not data:
                print(Fore.RED + "[SYSTEM]*[ERROR] Connection closed by server before file transfer completed")
                break
            file.write(data)
            receive_count += len(data)

            # Display transfer progress
            progress = (receive_count / file_size_int) * 100
            print(Fore.MAGENTA + f'\r[SYSTEM] Progress: {progress:.2f}% ({receive_count}/{file_size_int} bytes)', end='')

    end_time = time.time()

    # Calculate and display transfer time
    time_to_complete = end_time - start_time
    print(Fore.GREEN + f'\n[SYSTEM] File Transfer Complete in {time_to_complete:.2f} seconds')
    
    # Close the socket
    config.client_socket.close()

if __name__ == "__main__":
    main()
