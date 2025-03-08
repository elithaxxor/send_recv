import socket
import struct
import os

def tcp_client():
    host = "localhost"
    port = 22223
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print("Connected to TCP server")

    while True:
        # Prompt user for a command
        command = input("Choose command (EXIT, LIST, CHAT, FILE): ").strip().upper()
        if command not in ["EXIT", "LIST", "CHAT", "FILE"]:
            print("Invalid command")
            continue

        # Send command with 4-byte length prefix
        command_bytes = command.encode()
        client_socket.sendall(struct.pack('!I', len(command_bytes)))
        client_socket.sendall(command_bytes)

        if command == "EXIT":
            break
        elif command == "LIST":
            # Receive listing size (8 bytes) and data
            listing_size_bytes = client_socket.recv(8)
            listing_size = struct.unpack('Q', listing_size_bytes)[0]
            if listing_size == 0:
                print("No files available")
            else:
                listing = client_socket.recv(listing_size).decode()
                print("Available files:")
                print(listing)
        elif command == "CHAT":
            response = client_socket.recv(1024).decode()
            print(response)
        elif command == "FILE":
            file_name = input("Enter file name to download: ").strip()
            # Send file name with 8-byte length prefix
            file_name_bytes = file_name.encode()
            client_socket.sendall(struct.pack('Q', len(file_name_bytes)))
            client_socket.sendall(file_name_bytes)
            # Receive file size (8 bytes) and data
            file_size_bytes = client_socket.recv(8)
            file_size = struct.unpack('Q', file_size_bytes)[0]
            if file_size == 0:
                print("File not found or error occurred")
                continue
            # Download file
            with open(file_name, "wb") as f:
                received = 0
                while received < file_size:
                    data = client_socket.recv(min(1024, file_size - received))
                    if not data:
                        break
                    f.write(data)
                    received += len(data)
            print(f"File {file_name} downloaded successfully")

    client_socket.close()
    print("Disconnected from TCP server")

if __name__ == "__main__":
    tcp_client()
