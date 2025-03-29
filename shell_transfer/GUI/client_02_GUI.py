import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import socket
import threading
import re

class ClientGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("File Transfer Client")
        self.file_list = []  # Store files from LIST command
        self.selected_files = []  # Files selected for GET command

        # Server connection settings
        tk.Label(root, text="Server Address:").grid(row=0, column=0, padx=5, pady=5)
        self.server_entry = tk.Entry(root)
        self.server_entry.insert(0, "localhost")
        self.server_entry.grid(row=0, column=1, padx=5, pady=5)

        tk.Label(root, text="Port:").grid(row=0, column=2, padx=5, pady=5)
        self.port_entry = tk.Entry(root)
        self.port_entry.insert(0, "12345")
        self.port_entry.grid(row=0, column=3, padx=5, pady=5)

        # Command selection
        self.command_var = tk.StringVar()
        self.command_var.set("LIST")
        tk.OptionMenu(root, self.command_var, "LIST", "GETALL", "GET").grid(row=1, column=0, columnspan=2, padx=5, pady=5)

        # Buttons
        tk.Button(root, text="Execute", command=self.execute_command).grid(row=1, column=2, padx=5, pady=5)
        tk.Button(root, text="Quit", command=self.quit).grid(row=1, column=3, padx=5, pady=5)

        # Log display
        self.log_text = tk.Text(root, state='disabled', width=80, height=10)
        self.log_text.grid(row=2, column=0, columnspan=4, padx=5, pady=5)

        # Progress bar
        self.progress = ttk.Progressbar(root, orient="horizontal", length=300, mode="determinate")
        self.progress.grid(row=3, column=0, columnspan=4, padx=5, pady=5)

    def log(self, message):
        """Add a message to the log display."""
        self.log_text.config(state='normal')
        self.log_text.insert(tk.END, message + '\n')
        self.log_text.config(state='disabled')
        self.log_text.see(tk.END)

    def execute_command(self):
        """Execute the selected command in a separate thread."""
        command = self.command_var.get()
        if command == "LIST":
            threading.Thread(target=self.list_files).start()
        elif command == "GETALL":
            threading.Thread(target=self.download_all).start()
        elif command == "GET":
            self.select_files()

    def list_files(self):
        """Send LIST command and display server response."""
        try:
            server = self.server_entry.get()
            port = int(self.port_entry.get())
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((server, port))
                s.sendall(b"LIST")
                data = s.recv(1024).decode()
                self.file_list = re.findall(r'\d+\.\s(.+)', data)  # Parse file names
                self.log("Files on server:\n" + data)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to list files: {str(e)}")

    def select_files(self):
        """Open a window to select files for the GET command."""
        if not self.file_list:
            messagebox.showinfo("Info", "Please list files first.")
            return
        selection_window = tk.Toplevel(self.root)
        selection_window.title("Select Files")
        tk.Label(selection_window, text="Select files to download:").pack()
        listbox = tk.Listbox(selection_window, selectmode=tk.MULTIPLE)
        for file in self.file_list:
            listbox.insert(tk.END, file)
        listbox.pack()
        tk.Button(selection_window, text="Download", command=lambda: self.download_selected(listbox.curselection())).pack()

    def download_selected(self, selections):
        """Download selected files from the server."""
        self.selected_files = [self.file_list[i] for i in selections]
        if not self.selected_files:
            messagebox.showinfo("Info", "No files selected.")
            return
        threading.Thread(target=self.download_files).start()

    def download_files(self):
        """Send GET command with selected files and save the archive."""
        try:
            server = self.server_entry.get()
            port = int(self.port_entry.get())
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((server, port))
                cmd = "GET " + " ".join(self.selected_files)
                s.sendall(cmd.encode())
                output_file = filedialog.asksaveasfilename(defaultextension=".tar.gz", title="Save Archive As")
                if not output_file:
                    return
                self.progress["value"] = 0
                with open(output_file, 'wb') as f:
                    while True:
                        data = s.recv(1024)
                        if not data:
                            break
                        f.write(data)
                        self.progress["value"] += len(data) / 1024  # Rough progress update
                self.log(f"Downloaded selected files to {output_file}")
        except Exception as e:
            messagebox.showerror("Error", f"Download failed: {str(e)}")

    def download_all(self):
        """Send GETALL command and save all files."""
        try:
            server = self.server_entry.get()
            port = int(self.port_entry.get())
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((server, port))
                s.sendall(b"GETALL")
                output_file = filedialog.asksaveasfilename(defaultextension=".tar.gz", title="Save Archive As")
                if not output_file:
                    return
                self.progress["value"] = 0
                with open(output_file, 'wb') as f:
                    while True:
                        data = s.recv(1024)
                        if not data:
                            break
                        f.write(data)
                        self.progress["value"] += len(data) / 1024  # Rough progress update
                self.log(f"Downloaded all files to {output_file}")
        except Exception as e:
            messagebox.showerror("Error", f"Download failed: {str(e)}")

    def quit(self):
        """Close the application."""
        self.root.quit()

if __name__ == "__main__":
    root = tk.Tk()
    app = ClientGUI(root)
    root.mainloop()
