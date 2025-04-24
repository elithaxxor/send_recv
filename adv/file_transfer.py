import os
import threading

class FileTransfer:
    def __init__(self, socket_handler):
        self.socket_handler = socket_handler

    def send_file(self, conn, filepath):
        filesize = os.path.getsize(filepath)
        conn.sendall(f"FILE:{os.path.basename(filepath)}:{filesize}".encode())
        with open(filepath, 'rb') as f:
            while True:
                data = f.read(8192)
                if not data:
                    break
                conn.sendall(data)
        print(f"[FileTransfer] Sent file {filepath}")

    def receive_file(self, conn, save_dir):
        header = conn.recv(1024).decode()
        if header.startswith("FILE:"):
            _, filename, filesize = header.split(":")
            filesize = int(filesize)
            filepath = os.path.join(save_dir, filename)
            with open(filepath, 'wb') as f:
                received = 0
                while received < filesize:
                    data = conn.recv(min(8192, filesize - received))
                    if not data:
                        break
                    f.write(data)
                    received += len(data)
            print(f"[FileTransfer] Received file {filename}")
