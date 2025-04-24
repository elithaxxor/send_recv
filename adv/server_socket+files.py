import socket
import threading
import os
import logging
import time
import hashlib
from concurrent.futures import ThreadPoolExecutor
import sys
import signal
import struct
from utils import recv_exact, is_safe_filename, PROTOCOL_VERSION

# --- Protocol Constants ---
FILE_NAME_SIZE = 100
FILE_SIZE_SIZE = 8  # 8 bytes for file size (unsigned long long)
BUFFER_SIZE = 65536  # 64KB buffer for faster transfers
DEFAULT_PORT = 22223
MAX_WORKERS = 20
SHARED_DIR = os.path.abspath(os.environ.get('SHARED_DIR', './shared_files'))
os.makedirs(SHARED_DIR, exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('server.log'),
        logging.StreamHandler(sys.stdout)
    ])

def sha256sum(filepath):
    h = hashlib.sha256()
    with open(filepath, 'rb') as f:
        while True:
            chunk = f.read(BUFFER_SIZE)
            if not chunk:
                break
            h.update(chunk)
    return h.hexdigest()

class FileServer:
    def __init__(self, port=DEFAULT_PORT, shared_dir=SHARED_DIR):
        self.port = port
        self.shared_dir = shared_dir
        self.executor = ThreadPoolExecutor(max_workers=MAX_WORKERS)
        self.clients = set()
        self.notifications = []  # In-memory event log for polling
        self.lock = threading.Lock()

    def log_event(self, event_type, user, detail):
        timestamp = time.strftime('%Y-%m-%d %H:%M:%S')
        log_entry = {'timestamp': timestamp, 'event': event_type, 'user': user, 'detail': detail}
        logging.info(f"{event_type} | {user} | {detail}")
        with self.lock:
            self.notifications.append(log_entry)
            # Keep only last 100 notifications
            if len(self.notifications) > 100:
                self.notifications.pop(0)

    def list_files(self):
        files = []
        for fname in os.listdir(self.shared_dir):
            fpath = os.path.join(self.shared_dir, fname)
            if os.path.isfile(fpath):
                stat = os.stat(fpath)
                files.append({
                    'name': fname,
                    'size': stat.st_size,
                    'mtime': stat.st_mtime,
                    'owner': stat.st_uid
                })
        return files

    def handle_client(self, client_socket, addr):
        user = str(addr)
        try:
            self.log_event('connect', user, 'Connected')
            client_socket.sendall(PROTOCOL_VERSION.encode('utf-8').ljust(16, b'\0'))
            while True:
                cmd = client_socket.recv(4)
                if not cmd:
                    break
                cmd = cmd.decode('utf-8').strip().upper()
                if cmd == 'LIST':
                    files = self.list_files()
                    # Send number of files
                    client_socket.sendall(struct.pack('H', len(files)))
                    for f in files:
                        # Send metadata: name (100 bytes), size (8), mtime (8), owner (4)
                        name_bytes = f['name'].encode('utf-8')[:FILE_NAME_SIZE].ljust(FILE_NAME_SIZE, b'\0')
                        client_socket.sendall(name_bytes)
                        client_socket.sendall(struct.pack('Q', f['size']))
                        client_socket.sendall(struct.pack('d', f['mtime']))
                        client_socket.sendall(struct.pack('I', f['owner']))
                elif cmd == 'GETF':
                    # Receive file name length and name
                    name_len = struct.unpack('H', client_socket.recv(2))[0]
                    file_name = client_socket.recv(name_len).decode('utf-8')
                    abs_path = os.path.abspath(os.path.join(self.shared_dir, file_name))
                    if not abs_path.startswith(self.shared_dir) or not os.path.exists(abs_path):
                        client_socket.sendall(struct.pack('Q', 0))
                        continue
                    # Support resume: receive offset
                    offset = struct.unpack('Q', client_socket.recv(8))[0]
                    file_size = os.path.getsize(abs_path)
                    client_socket.sendall(struct.pack('Q', file_size))
                    # Send SHA-256
                    checksum = sha256sum(abs_path)
                    client_socket.sendall(checksum.encode('utf-8'))
                    with open(abs_path, 'rb') as f:
                        f.seek(offset)
                        while True:
                            data = f.read(BUFFER_SIZE)
                            if not data:
                                break
                            client_socket.sendall(data)
                    self.log_event('download', user, file_name)
                elif cmd == 'DEL ':  # Delete file
                    name_len = struct.unpack('H', client_socket.recv(2))[0]
                    file_name = client_socket.recv(name_len).decode('utf-8')
                    abs_path = os.path.abspath(os.path.join(self.shared_dir, file_name))
                    if os.path.exists(abs_path):
                        os.remove(abs_path)
                        client_socket.sendall(b'OK')
                        self.log_event('delete', user, file_name)
                    else:
                        client_socket.sendall(b'NO')
                elif cmd == 'RENA':  # Rename file
                    name_len = struct.unpack('H', client_socket.recv(2))[0]
                    old_name = client_socket.recv(name_len).decode('utf-8')
                    name_len2 = struct.unpack('H', client_socket.recv(2))[0]
                    new_name = client_socket.recv(name_len2).decode('utf-8')
                    old_path = os.path.abspath(os.path.join(self.shared_dir, old_name))
                    new_path = os.path.abspath(os.path.join(self.shared_dir, new_name))
                    if os.path.exists(old_path) and is_safe_filename(new_name):
                        os.rename(old_path, new_path)
                        client_socket.sendall(b'OK')
                        self.log_event('rename', user, f'{old_name} -> {new_name}')
                    else:
                        client_socket.sendall(b'NO')
                elif cmd == 'NOTI':  # Poll notifications
                    with self.lock:
                        notif = self.notifications[-10:]
                    client_socket.sendall(struct.pack('H', len(notif)))
                    for n in notif:
                        msg = f"{n['timestamp']} | {n['event']} | {n['user']} | {n['detail']}"
                        msg_bytes = msg.encode('utf-8')[:200].ljust(200, b'\0')
                        client_socket.sendall(msg_bytes)
                else:
                    client_socket.sendall(b'UNKNOWN')
        except Exception as e:
            logging.error(f"Error handling client {addr}: {e}")
        finally:
            client_socket.close()
            self.log_event('disconnect', user, 'Disconnected')

    def serve(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            server_socket.bind(("0.0.0.0", self.port))
            server_socket.listen(5)
            logging.info(f"Server listening on port {self.port}, sharing dir: {self.shared_dir}")
            def shutdown_handler(signum, frame):
                logging.info("Shutting down server...")
                server_socket.close()
                sys.exit(0)
            signal.signal(signal.SIGINT, shutdown_handler)
            signal.signal(signal.SIGTERM, shutdown_handler)
            while True:
                try:
                    client_sock, addr = server_socket.accept()
                    self.executor.submit(self.handle_client, client_sock, addr)
                except OSError:
                    break

if __name__ == "__main__":
    server = FileServer()
    server.serve()