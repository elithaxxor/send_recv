import socket
import sys
import os
from utils import recv_exact, is_safe_filename, PROTOCOL_VERSION

# --- Protocol Constants ---
FILE_NAME_SIZE = 100
FILE_SIZE_SIZE = 100
BUFFER_SIZE = 8192

def client_for_server1():
    """
    Client function to connect to server1 and download a file.
    """
    import argparse
    parser = argparse.ArgumentParser(description='File Transfer Client')
    parser.add_argument('--host', type=str, default='localhost', help='Server address')
    parser.add_argument('--port', type=int, default=int(os.environ.get('FT_PORT', 22223)), help='Server port')
    parser.add_argument('--file', type=str, help='File name to download (non-interactive)')
    args = parser.parse_args()

    host = args.host
    port = args.port

    # Create socket and connect
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        client_socket.connect((host, port))
        print(f"Connected to {host}:{port}")

        # Receive protocol version
        proto_ver = recv_exact(client_socket, 16).decode('utf-8').strip('\0')
        if proto_ver != PROTOCOL_VERSION:
            print(f"[WARNING] Protocol version mismatch: server '{proto_ver}', client '{PROTOCOL_VERSION}'")

        # Get file name
        if args.file:
            file_name = args.file.strip()
        else:
            file_name = input("Enter the file name to download: ").strip()
        if not is_safe_filename(file_name):
            print(f"Error: Unsafe file name '{file_name}'")
            return
        file_name_bytes = file_name.encode("utf-8")
        if len(file_name_bytes) > FILE_NAME_SIZE:
            print(f"Error: File name too long (max {FILE_NAME_SIZE} bytes)")
            return
        client_socket.sendall(file_name_bytes.ljust(FILE_NAME_SIZE, b"\0"))
        file_size = "0"
        client_socket.sendall(file_size.encode("utf-8").ljust(FILE_SIZE_SIZE, b"\0"))

        # Receive the file
        output_file = f"downloaded_{file_name}"
        total_bytes = 0
        try:
            from tqdm import tqdm
            use_tqdm = True
        except ImportError:
            use_tqdm = False
        with open(output_file, "wb") as f:
            try:
                if use_tqdm:
                    progress = tqdm(unit='B', unit_scale=True, desc=output_file)
                while True:
                    data = client_socket.recv(BUFFER_SIZE)
                    if not data:
                        break
                    f.write(data)
                    total_bytes += len(data)
                    if use_tqdm:
                        progress.update(len(data))
                if use_tqdm:
                    progress.close()
            except Exception as e:
                print(f"Error receiving file: {e}")
        if total_bytes > 0:
            print(f"File downloaded as {output_file} ({total_bytes} bytes)")
        else:
            print("No data received or file not found on server.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()
        print("Connection closed")

if __name__ == "__main__":
    client_for_server1()
