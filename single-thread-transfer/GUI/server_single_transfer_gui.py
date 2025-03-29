import socket
import os
import time
import threading
import queue
import tkinter as tk
from tkinter import ttk
from tkinter import filedialog

# Function to get the local IP address
def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"  # Fallback to localhost if unable to get IP

# Global variables
local_ip = get_local_ip()
PORT = 5555  # Port number for the server
running = True  # Flag to control the server loop
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # Server socket

# Queues for thread communication
server_to_gui = queue.Queue()  # Server sends messages to GUI
gui_to_server = queue.Queue()  # GUI sends file selection to server

# Server thread function
def server_thread_func():
    global running
    try:
        server_socket.bind((local_ip, PORT))
        server_socket.listen(5)
        server_to_gui.put(("log", f"Server listening on {local_ip}:{PORT}"))
        server_to_gui.put(("status", "Waiting for connection"))
    except OSError as e:
        server_to_gui.put(("log", f"Failed to start server: {e}"))
        return

    while running:
        try:
            # Accept client connection
            client_socket, addr = server_socket.accept()
            server_to_gui.put(("log", f"Accepted connection from {addr}"))
            server_to_gui.put(("status", "Client connected"))
            server_to_gui.put(("client_connected",))  # Signal GUI to prompt for file

            # Wait for file selection from GUI
            file_name = gui_to_server.get()
            if file_name:
                try:
                    # Prepare and send file
                    file_size = os.path.getsize(file_name)
                    file_base_name = os.path.basename(file_name)
                    client_socket.send(file_base_name.encode())
                    client_socket.send(str(file_size).encode())
                    
                    with open(file_name, "rb") as file:
                        send_count = 0
                        while send_count < file_size:
                            data = file.read(8192)  # Read in 8KB chunks
                            if not data:
                                break
                            client_socket.sendall(data)
                            send_count += len(data)
                            server_to_gui.put(("progress", send_count))
                    server_to_gui.put(("transfer_complete",))
                    server_to_gui.put(("log", f"Transfer of {file_base_name} complete"))
                    server_to_gui.put(("status", "Transfer complete"))
                except Exception as e:
                    server_to_gui.put(("log", f"Error sending file: {e}"))
            else:
                server_to_gui.put(("log", "File selection canceled, closing connection"))
            
            client_socket.close()
            server_to_gui.put(("status", "Waiting for next connection"))
            time.sleep(60)  # Wait 60 seconds before accepting next connection
        except socket.error:
            if running:  # Log error only if not due to server shutdown
                server_to_gui.put(("log", "Socket error, shutting down"))
            break
        except Exception as e:
            server_to_gui.put(("log", f"Unexpected error: {e}"))
            break
    server_socket.close()
    server_to_gui.put(("log", "Server stopped"))

# GUI setup
root = tk.Tk()
root.title("File Transfer Server")

# Log text widget with scrollbar
log_text = tk.Text(root, state='disabled', width=80, height=20)
log_text.grid(row=0, column=0, sticky='nsew')

scrollbar = tk.Scrollbar(root, command=log_text.yview)
scrollbar.grid(row=0, column=1, sticky='ns')
log_text['yscrollcommand'] = scrollbar.set

# Progress bar
progress_var = tk.DoubleVar()
progress_bar = ttk.Progressbar(root, variable=progress_var, maximum=100)
progress_bar.grid(row=1, column=0, sticky='ew', pady=5)

# Status label
status_label = tk.Label(root, text="Server starting...")
status_label.grid(row=2, column=0, pady=5)

# Configure grid to make log text widget expandable
root.grid_rowconfigure(0, weight=1)
root.grid_columnconfigure(0, weight=1)

# Function to process queue messages and update GUI
def check_queue():
    while True:
        try:
            message = server_to_gui.get_nowait()
            msg_type = message[0]
            if msg_type == "log":
                log_text.config(state='normal')
                log_text.insert('end', message[1] + '\n')
                log_text.config(state='disabled')
                log_text.see('end')  # Auto-scroll to the latest log
            elif msg_type == "status":
                status_label.config(text=message[1])
            elif msg_type == "client_connected":
                file_name = filedialog.askopenfilename(
                    title="Select File to Send",
                    filetypes=(("All files", "*.*"),)
                )
                if file_name:
                    file_size = os.path.getsize(file_name)
                    progress_var.set(0)
                    progress_bar['maximum'] = file_size
                    gui_to_server.put(file_name)
                    server_to_gui.put(("status", "Transferring file"))
                else:
                    gui_to_server.put(None)
            elif msg_type == "progress":
                progress_var.set(message[1])
            elif msg_type == "transfer_complete":
                progress_var.set(progress_bar['maximum'])  # Ensure bar is full
        except queue.Empty:
            break
    root.after(100, check_queue)  # Check again after 100ms

# Handle window close event
def on_closing():
    global running
    running = False
    server_socket.close()  # Interrupt accept() and shutdown server
    root.destroy()

root.protocol("WM_DELETE_WINDOW", on_closing)

# Start checking the queue
root.after(100, check_queue)

# Start server thread
server_thread = threading.Thread(target=server_thread_func, daemon=True)
server_thread.start()

# Run the GUI
root.mainloop()
