import socket
import struct
import os

def client_for_server2():
    # Server details
    host = "localhost"
    port = 22223

    # Create socket and connect
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print("Connected to Server 2")

    while True:
        # Prompt user for command
        command = input("Enter command (EXIT, LIST, CHAT, FILE): ").strip().upper()
        if command not in ["EXIT", "LIST", "CHAT", "FILE"]:
            print("Invalid command")
            continue

        # Send command (4 bytes)
        client_socket.sendall(command.encode("utf-8"))

        if command == "EXIT":
            break
        elif command == "LIST":
            # Receive listing size (8 bytes)
            listing_size_bytes = client_socket.recv(8)
            listing_size = struct.unpack("Q", listing_size_bytes)[0]
            if listing_size == 0:
                print("No files available or error occurred")
            else:
                # Receive and display listing
                listing = client_socket.recv(listing_size).decode("utf-8")
                print("Directory listing:")
                print(listing)
        elif command == "CHAT":
            # Receive response (limited functionality in server)
            response = client_socket.recv(1024).decode("utf-8")
            print("Server response:", response)
        elif command == "FILE":
            # Send file name
            file_name = input("Enter file name to download: ").strip()
            file_name_bytes = file_name.encode("utf-8")
            client_socket.sendall(struct.pack("Q", len(file_name_bytes)))
            client_socket.sendall(file_name_bytes)

            # Receive file size (8 bytes)
            file_size_bytes = client_socket.recv(8)
            file_size = struct.unpack("Q", file_size_bytes)[0]
            if file_size == 0:
                print("File not found or error occurred")
                continue

            # Receive file
            output_file = f"downloaded_{file_name}"
            with open(output_file, "wb") as f:
                received = 0
                while received < file_size:
                    data = client_socket.recv(min(16384, file_size - received))
                    if not data:
                        break
                    f.write(data)
                    received += len(data)
            print(f"File downloaded as {output_file}")

    client_socket.close()
    print("Connection closed")

if __name__ == "__main__":
    client_for_server2()
