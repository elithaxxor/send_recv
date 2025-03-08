import socket

def client_for_server1():
    # Server details
    host = "localhost"
    port = 22223

    # Create socket and connect
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print("Connected to Server 1")

    try:
        # Prompt user for file name
        file_name = input("Enter the file name to download: ").strip()
        
        # Send file name (up to 100 bytes)
        file_name_bytes = file_name.encode("utf-8")
        if len(file_name_bytes) > 100:
            print("Error: File name too long (max 100 bytes)")
            return
        client_socket.sendall(file_name_bytes.ljust(100, b"\0"))  # Pad to 100 bytes

        # Send file size (dummy value, server uses it as a trigger)
        # Assuming the server just needs a number, we'll send a placeholder
        file_size = "0"  # Server doesn’t check this, but must send 100 bytes
        file_size_bytes = file_size.encode("utf-8")
        client_socket.sendall(file_size_bytes.ljust(100, b"\0"))  # Pad to 100 bytes

        # Receive the file
        buffer_size = 8192
        output_file = f"downloaded_{file_name}"
        with open(output_file, "wb") as f:
            while True:
                data = client_socket.recv(buffer_size)
                if not data:
                    break
                f.write(data)
        print(f"File downloaded as {output_file}")

    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()
        print("Connection closed")

if __name__ == "__main__":
    client_for_server1()
