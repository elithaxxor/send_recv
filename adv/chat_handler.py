import threading

class ChatHandler:
    def __init__(self, socket_handler):
        self.socket_handler = socket_handler

    def send_message(self, conn, message):
        conn.sendall(f"CHAT:{message}".encode())

    def receive_message(self, conn):
        data = conn.recv(1024).decode()
        if data.startswith("CHAT:"):
            return data[5:]
        return None
