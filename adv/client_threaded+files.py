import socket
import struct
import os
import re
import sys
import time
import argparse
from utils import recv_exact, is_safe_filename, PROTOCOL_VERSION

# --- Protocol Constants ---
CMD_SIZE = 4
SIZE_HEADER = 8
BUFFER_SIZE = int(os.environ.get('FT_BUFFER', 16384))
SAFE_COMMANDS = {"EXIT", "LIST", "CHAT", "FILE", "BATCH", "UPLOAD"}

# --- Authentication ---
DEFAULT_USER = os.environ.get('FT_USER', "user")
DEFAULT_PASS = os.environ.get('FT_PASS', "pass123")


def authenticate(sock, username, password):
    """
    Authenticate with the server using the provided username and password.

    Args:
        sock (socket): The socket to use for authentication.
        username (str): The username to use for authentication.
        password (str): The password to use for authentication.

    Returns:
        bool: True if authentication is successful, False otherwise.
    """
    username_bytes = username.encode('utf-8')
    password_bytes = password.encode('utf-8')
    sock.sendall(struct.pack('Q', len(username_bytes)))
    sock.sendall(username_bytes)
    sock.sendall(struct.pack('Q', len(password_bytes)))
    sock.sendall(password_bytes)
    resp = recv_exact(sock, 8)
    return resp == b'AUTH_OK'


def print_progress(received, total, bar_length=40):
    """
    Print a progress bar to the console.

    Args:
        received (int): The number of bytes received so far.
        total (int): The total number of bytes to receive.
        bar_length (int, optional): The length of the progress bar. Defaults to 40.
    """
    if total == 0:
        return
    percent = received / total
    bar = '=' * int(bar_length * percent)
    sys.stdout.write(f"\r[{'=' * int(bar_length * percent):<{bar_length}}] {percent*100:5.1f}% ({received}/{total} bytes)")
    sys.stdout.flush()
    if received >= total:
        print()


def client_for_server2():
    """
    The main function for the client.

    This function sets up the socket, authenticates with the server, and enters a loop where it receives commands from the user and sends them to the server.
    """
    parser = argparse.ArgumentParser(description='Threaded File Transfer Client')
    parser.add_argument('--host', type=str, default='localhost', help='Server address')
    parser.add_argument('--port', type=int, default=int(os.environ.get('FT_PORT', 22223)), help='Server port')
    parser.add_argument('--user', type=str, default=DEFAULT_USER, help='Username')
    parser.add_argument('--password', type=str, default=DEFAULT_PASS, help='Password')
    args = parser.parse_args()
    host = args.host
    port = args.port
    username = args.user
    password = args.password
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print(f"Connected to {host}:{port}")
    # Protocol version
    proto_ver = recv_exact(client_socket, 16).decode('utf-8').strip('\0')
    if proto_ver != PROTOCOL_VERSION:
        print(f"[WARNING] Protocol version mismatch: server '{proto_ver}', client '{PROTOCOL_VERSION}'")
    # --- Authenticate ---
    if not authenticate(client_socket, username, password):
        print("Authentication failed. Exiting.")
        client_socket.close()
        return
    print("Authentication succeeded.")
    try:
        while True:
            command = input("Enter command (EXIT, LIST, CHAT, FILE, BATCH, UPLOAD): ").strip().upper()
            if command not in SAFE_COMMANDS:
                print("Invalid command")
                continue
            client_socket.sendall(command.encode("utf-8").ljust(CMD_SIZE, b' '))
            if command == "EXIT":
                break
            elif command == "LIST":
                # Receive directory listing
                size_bytes = recv_exact(client_socket, SIZE_HEADER)
                listing_size = struct.unpack('Q', size_bytes)[0]
                if listing_size == 0:
                    print("No files available.")
                else:
                    listing = recv_exact(client_socket, listing_size).decode('utf-8')
                    print(listing)
            elif command == "FILE":
                file_name = input("Enter file name: ").strip()
                if not is_safe_filename(file_name):
                    print("Unsafe file name.")
                    continue
                file_name_bytes = file_name.encode('utf-8')
                client_socket.sendall(struct.pack('Q', len(file_name_bytes)))
                client_socket.sendall(file_name_bytes)
                size_bytes = recv_exact(client_socket, SIZE_HEADER)
                file_size = struct.unpack('Q', size_bytes)[0]
                if file_size == 0:
                    print("File not found or unsafe.")
                    continue
                out_file = f"downloaded_{file_name}"
                with open(out_file, "wb") as f:
                    received = 0
                    try:
                        from tqdm import tqdm
                        use_tqdm = True
                    except ImportError:
                        use_tqdm = False
                    progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=out_file) if use_tqdm else None
                    while received < file_size:
                        chunk = client_socket.recv(min(BUFFER_SIZE, file_size - received))
                        if not chunk:
                            break
                        f.write(chunk)
                        received += len(chunk)
                        if use_tqdm:
                            progress.update(len(chunk))
                    if use_tqdm:
                        progress.close()
                print(f"Downloaded {out_file} ({file_size} bytes)")
            elif command == "BATCH":
                files = input("Enter comma-separated file names: ").split(',')
                files = [f.strip() for f in files if is_safe_filename(f.strip())]
                client_socket.sendall(struct.pack('Q', len(files)))
                for file_name in files:
                    file_name_bytes = file_name.encode('utf-8')
                    client_socket.sendall(struct.pack('Q', len(file_name_bytes)))
                    client_socket.sendall(file_name_bytes)
                    size_bytes = recv_exact(client_socket, SIZE_HEADER)
                    file_size = struct.unpack('Q', size_bytes)[0]
                    if file_size == 0:
                        print(f"File '{file_name}' not found or unsafe.")
                        continue
                    out_file = f"downloaded_{file_name}"
                    with open(out_file, "wb") as f:
                        received = 0
                        try:
                            from tqdm import tqdm
                            use_tqdm = True
                        except ImportError:
                            use_tqdm = False
                        progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=out_file) if use_tqdm else None
                        while received < file_size:
                            chunk = client_socket.recv(min(BUFFER_SIZE, file_size - received))
                            if not chunk:
                                break
                            f.write(chunk)
                            received += len(chunk)
                            if use_tqdm:
                                progress.update(len(chunk))
                        if use_tqdm:
                            progress.close()
                    print(f"Downloaded {out_file} ({file_size} bytes)")
            elif command == "UPLOAD":
                file_name = input("Enter file name to upload: ").strip()
                if not is_safe_filename(file_name) or not os.path.exists(file_name):
                    print("Unsafe or missing file.")
                    continue
                file_name_bytes = file_name.encode('utf-8')
                client_socket.sendall(struct.pack('Q', len(file_name_bytes)))
                client_socket.sendall(file_name_bytes)
                file_size = os.path.getsize(file_name)
                client_socket.sendall(struct.pack('Q', file_size))
                with open(file_name, "rb") as f:
                    sent = 0
                    try:
                        from tqdm import tqdm
                        use_tqdm = True
                    except ImportError:
                        use_tqdm = False
                    progress = tqdm(total=file_size, unit='B', unit_scale=True, desc=file_name) if use_tqdm else None
                    while sent < file_size:
                        chunk = f.read(BUFFER_SIZE)
                        if not chunk:
                            break
                        client_socket.sendall(chunk)
                        sent += len(chunk)
                        if use_tqdm:
                            progress.update(len(chunk))
                    if use_tqdm:
                        progress.close()
                print(f"Uploaded {file_name} ({file_size} bytes)")
            elif command == "CHAT":
                msg = input("Enter chat message: ")
                msg_bytes = msg.encode('utf-8')
                client_socket.sendall(struct.pack('Q', len(msg_bytes)))
                client_socket.sendall(msg_bytes)
                resp_len_bytes = recv_exact(client_socket, SIZE_HEADER)
                resp_len = struct.unpack('Q', resp_len_bytes)[0]
                resp = recv_exact(client_socket, resp_len).decode('utf-8')
                print(f"Server echo: {resp}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()
        print("Connection closed")


if __name__ == "__main__":
    client_for_server2()
