import os
import socket
import time
import numpy
import sys
import select  ## OS LEEL loop
import io
from numpy.lib.format import BUFFER_SIZE
from socket_handler import SocketHandler
from file_transfer import FileTransfer
from chat_handler import ChatHandler
from flask_api import FlaskAPI
import threading

BUFFER_SIZE:int = 8192
CLIENT_PORT:int = 22223

# Choose IPv4 or IPv6
USE_IPV6 = False  # Change to True for IPv6

# Initialize handlers
socket_handler = SocketHandler(port=CLIENT_PORT, use_ipv6=USE_IPV6)
file_transfer = FileTransfer(socket_handler)
chat_handler = ChatHandler(socket_handler)
flask_api = FlaskAPI()

# Start Flask API in a thread
def start_flask():
    flask_api.run()

flask_thread = threading.Thread(target=start_flask, daemon=True)
flask_thread.start()

# Bind and listen
socket_handler.bind_and_listen()
print(f"[SYS] Listening for incoming connections...")

# Accept a client connection (single-threaded for now)
client, addr = socket_handler.accept()
print(f"[+] Connected to {addr}")

# Example: Send a file (replace with actual logic as needed)
file_name = input("[SYSTEM] Enter File Name: ")
file_transfer.send_file(client, file_name)

# Example: Receive a chat message (replace with actual logic as needed)
# message = chat_handler.receive_message(client)
# print(f"[CHAT] {message}")

client.close()
socket_handler.close()

# TODO: For full multi-client support, wrap accept/send/receive in threads.
# TODO: For more features, expand the chat and file transfer logic as needed.
