import socket
import os
import time
import threading
import queue
import asyncio
import tkinter as tk
from tkinter import filedialog, scrolledtext, messagebox

def get_local_ip():
    """Get the local IP address of the machine."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"  # Fallback to localhost

class ServerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("File Transfer Server (Asyncio)")
        self.running = False
        self.server = None

        # GUI Elements
        tk.Label(root, text="Port:").grid(row=0, column=0, padx=5, pady=5)
        self.port_entry = tk.Entry(root, width=10)
        self.port_entry.insert(0, "5555")
        self.port_entry.grid(row=0, column=1, padx=5, pady=5)

        self.start_button = tk.Button(root, text="Start Server", command=self.start_server)
        self.start_button.grid(row=0, column=2, padx=5, pady=5)
        self.stop_button = tk.Button(root, text="Stop Server", command=self.stop_server, state='disabled')
        self.stop_button.grid(row=0, column=3, padx=5, pady=5)

        woeid=self.status_label = tk.Label(root, text="Server stopped")
        self.status_label.grid(row=1, column=0, columnspan=4, padx=5, pady=5)

        self.log_text = scrolledtext.ScrolledText(root, state='disabled', width=80, height=20)
        self.log_text.grid(row=2, column=0, columnspan=4, padx=5, pady=5)

        # Communication queue
        self.server_to_gui = queue.Queue()
        self.root.after(100, self.check_queue)

    def start_server(self):
        """Start the asyncio server thread with the specified port."""
        try:
            port = int(self.port_entry.get())
            if not (1 <= port <= 65535):
                raise ValueError("Port must be between 1 and 65535")
        except ValueError as e:
            messagebox.showerror("Error", f"Invalid port: {e}")
            return

        self.asyncio_thread = threading.Thread(
            target=asyncio_thread_func,
            args=(port, self.server_to_gui),
            daemon=True
        )
        self.asyncio_thread.start()
        self.start_button['state'] = 'disabled'
        self.stop_button['state'] = 'normal'

    def stop_server(self):
        """Stop the server by setting the flag and closing the server."""
        self.running = False
        if self.server:
            self.server.close()
        self.start_button['state'] = 'normal'
        self.stop_button['state'] = 'disabled'

    def check_queue(self):
        """Process messages from the asyncio thread."""
        while not self.server_to_gui.empty():
            message = self.server_to_gui.get()
            if message[0] == "log":
                timestamp = time.strftime("%H:%M:%S")
                log_msg = f"[{timestamp}] {message[1]}"
                self.log_text.config(state='normal')
                self.log_text.insert('end', log_msg + '\n')
                self.log_text.config(state='disabled')
                self.log_text.see('end')
            elif message[0] == "status":
                self.status_label['text'] = message[1]
            elif message[0] == "client_connected":
                client_id, client_queue = message[1], message[2]
                file_name = filedialog.askopenfilename(title=f"Select file for client {client_id}")
                client_queue.put_nowait(file_name)
        self.root.after(100, self.check_queue)

def asyncio_thread_func(port, server_to_gui):
    """Run the asyncio event loop."""
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_until_complete(asyncio_server(port, server_to_gui))

async def asyncio_server(port, server_to_gui):
    """Run the asyncio server to handle connections."""
    global running, server
    running = True
    try:
        server = await asyncio.start_server(
            lambda r, w: handle_client(r, w, server_to_gui),
            get_local_ip(), port
        )
        server_to_gui.put(("log", f"Server listening on {get_local_ip()}:{port}"))
        server_to_gui.put(("status", f"Server running on {get_local_ip()}:{port}"))
        async with server:
            await server.serve_forever()
    except Exception as e:
        server_to_gui.put(("log", f"Server error: {e}"))
        if not running:
            server_to_gui.put(("log", "Server stopped"))

async def handle_client(reader, writer, server_to_gui):
    """Handle file transfer for a single client using asyncio."""
    addr = writer.get_extra_info('peername')
    try:
        server_to_gui.put(("log", f"Connected to {addr}"))
        client_queue = asyncio.Queue()
        server_to_gui.put(("client_connected", str(addr), client_queue))
        file_name = await client_queue.get()
        if file_name:
            try:
                file_size = os.path.getsize(file_name)
                file_base_name = os.path.basename(file_name)
                writer.write(file_base_name.encode() + b'\n')
                writer.write(str(file_size).encode() + b'\n')
                await writer.drain()
                with open(file_name, "rb") as file:
                    send_count = 0
                    while send_count < file_size:
                        data = file.read(65536)  # 64KB buffer
                        if not data:
                            break
                        writer.write(data)
                        await writer.drain()
                        send_count += len(data)
                        percentage = (send_count / file_size) * 100
                        server_to_gui.put(("log", f"Transferring to {addr}: {percentage:.2f}%"))
                server_to_gui.put(("log", f"Transfer to {addr} complete"))
            except FileNotFoundError:
                server_to_gui.put(("log", f"File not found: {file_name}"))
            except Exception as e:
                server_to_gui.put(("log", f"Error sending file to {addr}: {e}"))
        else:
            server_to_gui.put(("log", f"File selection canceled for {addr}"))
    finally:
        writer.close()
        await writer.wait_closed()

if __name__ == "__main__":
    root = tk.Tk()
    gui = ServerGUI(root)
    root.mainloop()
