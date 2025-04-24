import os
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext, simpledialog
import threading
from client_backend import FileTransferClient
import time
import sys
import random

try:
    from ttkthemes import ThemedTk
    use_themed = True
except ImportError:
    use_themed = False

# Try to import sound modules
try:
    import winsound
    def beep():
        winsound.Beep(1200, 100)
    def play_hacker_sound():
        winsound.MessageBeep()
except ImportError:
    def beep():
        print("\a", end="")
    def play_hacker_sound():
        print("\a", end="")

# Custom hacker/cyberpunk icons (ASCII art or Unicode)
ICON_UPLOAD = '\u21EA'  # Upwards white arrow
ICON_DOWNLOAD = '\u21E9'  # Downwards white arrow
ICON_DELETE = '\u2620'  # Skull and crossbones
ICON_RENAME = '\u270D'  # Writing hand
ICON_REFRESH = '\u27F3'  # Clockwise gapped circle arrow
ICON_CHAT = '\u25B6'  # Play symbol (like a prompt)
ICON_NOTIFY = '\u26A1'  # Lightning bolt
ICON_TERMINAL = '\u25A0'  # Black square

HACKER_BG = '#181A20'
HACKER_PANEL = '#23272e'
HACKER_ACCENT = '#39ff14'  # Neon green
HACKER_ACCENT2 = '#00ffe7'  # Neon cyan
HACKER_TEXT = '#f8f8f2'
HACKER_WARN = '#ff0059'
HACKER_HEADER = '#8aff80'
HACKER_FONT = 'Fira Mono' if sys.platform != 'win32' else 'Consolas'

class Dashboard(ThemedTk if use_themed else tk.Tk):
    def __init__(self):
        super().__init__()
        if use_themed:
            self.set_theme("yaru-dark" if "yaru-dark" in self.get_themes() else "black")
        self.title(f"{ICON_TERMINAL} HACKER FILE TRANSFER DASHBOARD")
        self.geometry("950x740")
        self.configure(bg=HACKER_BG)
        self._add_matrix_rain()
        self.client = FileTransferClient(self)
        self._setup_widgets()
        self._setup_client_callbacks()
        self.after(500, play_hacker_sound)

    def _add_matrix_rain(self):
        self.matrix_canvas = tk.Canvas(self, bg=HACKER_BG, highlightthickness=0, bd=0)
        self.matrix_canvas.place(x=0, y=0, relwidth=1, relheight=1)
        self.matrix_chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*'
        self.matrix_cols = 60
        self.matrix_drops = [random.randint(0, 40) for _ in range(self.matrix_cols)]
        self._animate_matrix_rain()

    def _animate_matrix_rain(self):
        w = self.winfo_width()
        h = self.winfo_height()
        if w < 100 or h < 100:
            self.after(50, self._animate_matrix_rain)
            return
        self.matrix_canvas.delete("all")
        font_size = 16
        col_width = w // self.matrix_cols
        for i in range(self.matrix_cols):
            char = random.choice(self.matrix_chars)
            x = i * col_width
            y = self.matrix_drops[i] * font_size
            self.matrix_canvas.create_text(x, y, text=char, fill=HACKER_ACCENT, font=(HACKER_FONT, font_size, "bold"))
            if y > h and random.random() > 0.975:
                self.matrix_drops[i] = 0
            else:
                self.matrix_drops[i] += 1
        self.matrix_canvas.lower()  # Keep background
        self.after(55, self._animate_matrix_rain)

    def _setup_widgets(self):
        style = ttk.Style()
        if not use_themed:
            style.theme_use('clam')
        style.configure('TFrame', background=HACKER_BG)
        style.configure('TLabel', background=HACKER_BG, foreground=HACKER_TEXT, font=(HACKER_FONT, 11))
        style.configure('Header.TLabel', font=(HACKER_FONT, 18, 'bold'), foreground=HACKER_ACCENT, background=HACKER_BG)
        style.configure('Accent.TButton', font=(HACKER_FONT, 11, 'bold'), foreground=HACKER_BG, background=HACKER_ACCENT)
        style.map('Accent.TButton', background=[('active', HACKER_ACCENT2)])
        style.configure('Danger.TButton', font=(HACKER_FONT, 11, 'bold'), foreground=HACKER_BG, background=HACKER_WARN)
        style.map('Danger.TButton', background=[('active', '#ff2b6d')])
        style.configure('Notif.TLabel', font=(HACKER_FONT, 11), foreground=HACKER_ACCENT2, background=HACKER_PANEL)
        style.configure('TSeparator', background=HACKER_ACCENT)

        # --- Header ---
        header = ttk.Label(self, text=f"{ICON_TERMINAL} HACKER FILE TRANSFER DASHBOARD", style="Header.TLabel")
        header.pack(pady=(18, 8))
        ttk.Separator(self, orient='horizontal').pack(fill='x', padx=18, pady=(0, 8))
        # Add Help button to header
        help_btn = ttk.Button(self, text="How to Use", style="Accent.TButton", command=self._show_help_popup)
        help_btn.place(x=820, y=18)
        # Add Key Management button to header
        key_btn = ttk.Button(self, text="Key Management", style="Accent.TButton", command=self._show_key_mgmt_popup)
        key_btn.place(x=680, y=18)
        # --- Connection Frame ---
        conn_frame = ttk.LabelFrame(self, text="Connection", padding=10, style='TFrame')
        conn_frame.configure(borderwidth=2, relief='ridge')
        conn_frame.pack(fill="x", padx=18, pady=6)
        ttk.Label(conn_frame, text="Host:").grid(row=0, column=0, padx=3, pady=2)
        self.host_var = tk.StringVar(value="localhost")
        ttk.Entry(conn_frame, textvariable=self.host_var, width=15, font=(HACKER_FONT, 11)).grid(row=0, column=1)
        ttk.Label(conn_frame, text="Port:").grid(row=0, column=2)
        self.port_var = tk.StringVar(value="22223")
        ttk.Entry(conn_frame, textvariable=self.port_var, width=6, font=(HACKER_FONT, 11)).grid(row=0, column=3)
        ttk.Label(conn_frame, text="Username:").grid(row=0, column=4)
        self.user_var = tk.StringVar()
        ttk.Entry(conn_frame, textvariable=self.user_var, width=12, font=(HACKER_FONT, 11)).grid(row=0, column=5)
        ttk.Label(conn_frame, text="Password:").grid(row=0, column=6)
        self.pw_var = tk.StringVar()
        ttk.Entry(conn_frame, textvariable=self.pw_var, show="*", width=12, font=(HACKER_FONT, 11)).grid(row=0, column=7)
        self.conn_status = ttk.Label(conn_frame, text="Disconnected", foreground=HACKER_WARN, font=(HACKER_FONT, 11, "bold"))
        self.conn_status.grid(row=0, column=8, padx=10)
        ttk.Button(conn_frame, text=f"Connect", style="Accent.TButton", command=self._connect).grid(row=0, column=9, padx=5)
        ttk.Button(conn_frame, text=f"Disconnect", style="Danger.TButton", command=self._disconnect).grid(row=0, column=10)

        # --- File Upload/Download Frame ---
        file_frame = ttk.LabelFrame(self, text="File Transfer", padding=10, style='TFrame')
        file_frame.configure(borderwidth=2, relief='ridge')
        file_frame.pack(fill="x", padx=18, pady=6)
        ttk.Button(file_frame, text=f"{ICON_UPLOAD} Select File", command=self._select_file, style="Accent.TButton").grid(row=0, column=0, padx=5, pady=3)
        self.selected_file = ttk.Label(file_frame, text="No file selected", font=(HACKER_FONT, 10, "italic"))
        self.selected_file.grid(row=0, column=1, sticky="w")
        ttk.Button(file_frame, text=f"{ICON_UPLOAD} Upload", style="Accent.TButton", command=self._upload_file).grid(row=0, column=2, padx=5)
        self.compress_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(file_frame, text="Compress before upload", variable=self.compress_var).grid(row=0, column=3, padx=5)
        ttk.Label(file_frame, text="Available Files:").grid(row=1, column=0, sticky="e")
        self.file_list = tk.Listbox(file_frame, height=7, width=60, font=(HACKER_FONT, 10), bg=HACKER_PANEL, fg=HACKER_ACCENT, selectbackground=HACKER_ACCENT2, selectforeground=HACKER_BG, activestyle='none', borderwidth=1, relief='solid')
        self.file_list.grid(row=1, column=1, columnspan=2, sticky="ew", padx=5)
        ttk.Button(file_frame, text=f"{ICON_REFRESH} Refresh", command=self._refresh_files, style='Accent.TButton').grid(row=1, column=3)
        ttk.Button(file_frame, text=f"{ICON_DOWNLOAD} Download", style="Accent.TButton", command=self._download_file).grid(row=1, column=4, padx=5)
        ttk.Button(file_frame, text=f"{ICON_DELETE} Delete", style="Danger.TButton", command=self._delete_file).grid(row=1, column=5, padx=5)
        ttk.Button(file_frame, text=f"{ICON_RENAME} Rename", command=self._rename_file).grid(row=1, column=6, padx=5)
        self.upload_pb = ttk.Progressbar(file_frame, length=180, style='Accent.TButton')
        self.upload_pb.grid(row=2, column=1, columnspan=2, sticky="ew", pady=2)
        self.download_pb = ttk.Progressbar(file_frame, length=180, style='Accent.TButton')
        self.download_pb.grid(row=2, column=3, columnspan=2, sticky="ew", pady=2)
        self.eta_label = ttk.Label(file_frame, text="", font=(HACKER_FONT, 10, "italic"), foreground=HACKER_ACCENT2)
        self.eta_label.grid(row=3, column=1, columnspan=2, sticky="w", pady=2)
        # Tooltip example
        ToolTip(self.file_list, "Double-click to preview file info. Right-click for actions.")

        # --- Notifications Frame ---
        notif_frame = ttk.LabelFrame(self, text="Notifications", padding=10, style='TFrame')
        notif_frame.configure(borderwidth=2, relief='ridge')
        notif_frame.pack(fill="x", padx=18, pady=6)
        self.notif_area = scrolledtext.ScrolledText(notif_frame, height=4, state="disabled", font=(HACKER_FONT, 10), bg=HACKER_PANEL, fg=HACKER_ACCENT2, insertbackground=HACKER_ACCENT)
        self.notif_area.pack(fill="both", expand=True, padx=5, pady=3)
        ttk.Button(notif_frame, text=f"{ICON_NOTIFY} Poll Notifications", style="Accent.TButton", command=self._poll_notifications).pack(anchor="e", padx=5, pady=2)

        # --- Chat Frame ---
        chat_frame = ttk.LabelFrame(self, text=f"Chat {ICON_CHAT}", padding=10, style='TFrame')
        chat_frame.configure(borderwidth=2, relief='ridge')
        chat_frame.pack(fill="both", expand=True, padx=18, pady=6)
        self.chat_log = scrolledtext.ScrolledText(chat_frame, height=10, state="disabled", font=(HACKER_FONT, 10), bg=HACKER_PANEL, fg=HACKER_ACCENT)
        self.chat_log.pack(fill="both", expand=True, padx=5, pady=3)
        chat_entry_frame = ttk.Frame(chat_frame)
        chat_entry_frame.pack(fill="x", padx=5, pady=2)
        self.chat_var = tk.StringVar()
        ttk.Entry(chat_entry_frame, textvariable=self.chat_var, width=60, font=(HACKER_FONT, 10), foreground=HACKER_ACCENT2, background=HACKER_BG).pack(side="left", fill="x", expand=True)
        ttk.Button(chat_entry_frame, text=f"Send {ICON_CHAT}", style="Accent.TButton", command=self._send_chat).pack(side="left", padx=5)

        # --- Status/Log Frame ---
        log_frame = ttk.LabelFrame(self, text="Status / Logs", padding=10, style='TFrame')
        log_frame.configure(borderwidth=2, relief='ridge')
        log_frame.pack(fill="both", expand=True, padx=18, pady=6)
        self.log_area = scrolledtext.ScrolledText(log_frame, height=6, state="disabled", font=(HACKER_FONT, 10), bg=HACKER_BG, fg=HACKER_ACCENT, insertbackground=HACKER_ACCENT2)
        self.log_area.pack(fill="both", expand=True, padx=5, pady=3)
        ToolTip(self.log_area, "Terminal output. All actions and errors show up here.")

        # Collapsible advanced panel example
        self.adv_panel = CollapsiblePanel(self, "Advanced Tools", fg=HACKER_ACCENT2, bg=HACKER_BG)
        self.adv_panel.pack(fill="x", padx=18, pady=6)
        ttk.Label(self.adv_panel.frame, text="(Future: Matrix Rain, Packet Sniffer, etc.)", foreground=HACKER_HEADER, background=HACKER_BG, font=(HACKER_FONT, 10, "italic")).pack(anchor="w", padx=6, pady=4)
        ttk.Button(self.adv_panel.frame, text="Show About", style="Accent.TButton", command=self._show_about_popup).pack(anchor="w", padx=6, pady=4)

    def _setup_client_callbacks(self):
        self.client.on_connect = self._on_connect
        self.client.on_disconnect = self._on_disconnect
        self.client.on_file_list = self._on_file_list
        self.client.on_upload_progress = self._on_upload_progress
        self.client.on_download_progress = self._on_download_progress
        self.client.on_chat_message = self._on_chat_message
        self.client.on_notifications = self._on_notifications

    def _connect(self):
        self.log("Connecting...")
        threading.Thread(target=self.client.connect,
                         args=(self.host_var.get(), self.port_var.get(), self.user_var.get(), self.pw_var.get()), daemon=True).start()

    def _disconnect(self):
        self.log("Disconnecting...")
        self.client.disconnect()
        self.conn_status.config(text="Disconnected", foreground=HACKER_WARN)

    def _select_file(self):
        filename = filedialog.askopenfilename()
        if filename:
            self.selected_file.config(text=filename)
            self.client.selected_file = filename

    def _upload_file(self):
        self.log("Uploading file...")
        compress = self.compress_var.get()
        threading.Thread(target=self.client.upload_file, kwargs={'compress': compress}, daemon=True).start()

    def _refresh_files(self):
        self.log("Refreshing file list...")
        threading.Thread(target=self.client.list_files, daemon=True).start()

    def _download_file(self):
        selection = self.file_list.curselection()
        if selection:
            filename = self.file_list.get(selection[0]).split(' ')[0]
            self.log(f"Downloading {filename}...")
            threading.Thread(target=self.client.download_file, args=(filename,), daemon=True).start()

    def _send_chat(self):
        msg = self.chat_var.get()
        if msg:
            self.client.send_chat(msg)
            self.chat_var.set("")

    def log(self, msg):
        self.log_area.config(state="normal")
        self.log_area.insert("end", msg + "\n")
        self.log_area.see("end")
        self.log_area.config(state="disabled")

    def _on_connect(self):
        self.conn_status.config(text="Connected", foreground=HACKER_ACCENT)

    def _on_disconnect(self):
        self.conn_status.config(text="Disconnected", foreground=HACKER_WARN)

    def _on_file_list(self, files):
        self.file_list.delete(0, "end")
        for f in files:
            if isinstance(f, dict):
                display = f"{f['name']} (size: {f['size']}, mtime: {time.strftime('%Y-%m-%d %H:%M', time.localtime(f['mtime']))}, owner: {f['owner']})"
                self.file_list.insert("end", display)
            else:
                self.file_list.insert("end", f)

    def _delete_file(self):
        selection = self.file_list.curselection()
        if selection:
            filename = self.file_list.get(selection[0]).split(' ')[0]
            self.log(f"Deleting {filename}...")
            threading.Thread(target=self.client.delete_file, args=(filename,), daemon=True).start()

    def _rename_file(self):
        selection = self.file_list.curselection()
        if selection:
            filename = self.file_list.get(selection[0]).split(' ')[0]
            new_name = simpledialog.askstring("Rename File", f"Enter new name for {filename}:")
            if new_name:
                self.log(f"Renaming {filename} to {new_name}...")
                threading.Thread(target=self.client.rename_file, args=(filename, new_name), daemon=True).start()

    def _poll_notifications(self):
        self.log("Polling notifications...")
        threading.Thread(target=self.client.poll_notifications, daemon=True).start()

    def _on_upload_progress(self, percent, eta):
        self.upload_pb['value'] = percent
        if eta is not None:
            mins, secs = divmod(int(eta), 60)
            self.eta_label.config(text=f"Estimated time remaining: {mins}m {secs}s")
        else:
            self.eta_label.config(text="")

    def _on_download_progress(self, percent):
        self.download_pb['value'] = percent

    def _on_chat_message(self, msg):
        self.chat_log.config(state="normal")
        self.chat_log.insert("end", msg + "\n")
        self.chat_log.see("end")
        self.chat_log.config(state="disabled")

    def _on_notifications(self, notifications):
        self.notif_area.config(state="normal")
        self.notif_area.delete("1.0", "end")
        for n in notifications:
            msg = f"{n['timestamp']} | {n['event']} | {n['user']} | {n['detail']}"
            self.notif_area.insert("end", msg + "\n")
        self.notif_area.config(state="disabled")

    def _show_about_popup(self):
        popup = HackerPopup(self, title="About", text="Hacker File Transfer Dashboard\n\n- Matrix rain\n- Draggable popups\n- Sound effects\n- Cyberpunk style\n\nEnjoy hacking!", accent=HACKER_ACCENT)
        popup.show()
        beep()

    def _show_help_popup(self):
        help_text = (
            "Welcome to the Hacker File Transfer Dashboard!\n\n"
            "\u25B6 Connect: Enter the server host, port, username, and password, then click 'Connect'.\n"
            "\u25B6 Upload: Select a file and click 'Upload'. Optionally compress before upload.\n"
            "\u25B6 Download: Select a file from the list and click 'Download'.\n"
            "\u25B6 Delete/Rename: Select a file and use the respective buttons.\n"
            "\u25B6 Notifications: Poll for recent actions (uploads/downloads/deletes).\n"
            "\u25B6 Chat: Send messages in real time.\n"
            "\u25B6 Advanced Tools: Explore future features and fun extras.\n\n"
            "Tips:\n- Hover for tooltips.\n- Enjoy the Matrix rain!\n- All actions are logged in the terminal panel.\n\n"
            "For best experience, keep your server running and network stable."
        )
        popup = HackerPopup(self, title="How to Use", text=help_text, accent=HACKER_ACCENT2)
        popup.show()
        beep()

    def _show_key_mgmt_popup(self):
        popup = KeyMgmtPopup(self, self.client)
        popup.show()
        beep()

class HackerPopup(tk.Toplevel):
    def __init__(self, parent, title="Popup", text="", accent="#39ff14"):
        super().__init__(parent)
        self.title(title)
        self.configure(bg=HACKER_BG)
        self.overrideredirect(True)
        self.geometry("400x200+300+200")
        self._drag_data = {"x": 0, "y": 0}
        self.header = tk.Label(self, text=title, bg=HACKER_BG, fg=accent, font=(HACKER_FONT, 14, "bold"))
        self.header.pack(fill="x", pady=(8, 2))
        self.header.bind("<ButtonPress-1>", self._start_drag)
        self.header.bind("<B1-Motion>", self._on_drag)
        self.body = tk.Label(self, text=text, bg=HACKER_BG, fg=HACKER_TEXT, font=(HACKER_FONT, 11), justify="left")
        self.body.pack(fill="both", expand=True, padx=16, pady=8)
        self.close_btn = ttk.Button(self, text="Close", style="Accent.TButton", command=self.destroy)
        self.close_btn.pack(pady=(0, 10))
    def show(self):
        self.grab_set()
        self.deiconify()
    def _start_drag(self, event):
        self._drag_data["x"] = event.x
        self._drag_data["y"] = event.y
    def _on_drag(self, event):
        x = self.winfo_x() + event.x - self._drag_data["x"]
        y = self.winfo_y() + event.y - self._drag_data["y"]
        self.geometry(f"+{x}+{y}")

class KeyMgmtPopup(tk.Toplevel):
    def __init__(self, parent, client):
        super().__init__(parent)
        self.title("Key Management")
        self.configure(bg=HACKER_BG)
        self.geometry("520x420+340+220")
        self.client = client
        self.header = tk.Label(self, text="Key Management", bg=HACKER_BG, fg=HACKER_ACCENT, font=(HACKER_FONT, 14, "bold"))
        self.header.pack(fill="x", pady=(10, 2))
        # Public Key display
        ttk.Label(self, text="Public Key (PEM, share with others):", style="Header.TLabel").pack(anchor="w", padx=18, pady=(10,2))
        pub_pem = crypto_utils.serialize_public_key(client.public_key).decode()
        self.pub_text = tk.Text(self, height=6, wrap="none", font=(HACKER_FONT, 9), bg=HACKER_PANEL, fg=HACKER_ACCENT2)
        self.pub_text.insert("1.0", pub_pem)
        self.pub_text.config(state="disabled")
        self.pub_text.pack(fill="x", padx=18)
        ttk.Button(self, text="Copy Public Key", style="Accent.TButton", command=lambda: self._copy_to_clipboard(pub_pem)).pack(anchor="w", padx=18, pady=2)
        # Private Key export/import
        ttk.Label(self, text="Private Key (keep secret):", style="Header.TLabel").pack(anchor="w", padx=18, pady=(10,2))
        ttk.Button(self, text="Export Private Key", style="Accent.TButton", command=self._export_private_key).pack(anchor="w", padx=18, pady=2)
        ttk.Button(self, text="Import Private Key", style="Accent.TButton", command=self._import_private_key).pack(anchor="w", padx=18, pady=2)
        ttk.Button(self, text="Generate New Keypair", style="Danger.TButton", command=self._generate_new_keypair).pack(anchor="w", padx=18, pady=12)
        self.close_btn = ttk.Button(self, text="Close", style="Accent.TButton", command=self.destroy)
        self.close_btn.pack(pady=(10, 10))
    def show(self):
        self.grab_set()
        self.deiconify()
    def _copy_to_clipboard(self, text):
        self.clipboard_clear()
        self.clipboard_append(text)
    def _export_private_key(self):
        from tkinter import filedialog
        path = filedialog.asksaveasfilename(defaultextension=".pem", filetypes=[("PEM files", "*.pem")])
        if path:
            pem = crypto_utils.serialize_private_key(self.client.private_key)
            with open(path, 'wb') as f:
                f.write(pem)
    def _import_private_key(self):
        from tkinter import filedialog, messagebox
        path = filedialog.askopenfilename(filetypes=[("PEM files", "*.pem")])
        if path:
            with open(path, 'rb') as f:
                pem = f.read()
            try:
                priv = crypto_utils.load_private_key(pem)
                self.client.private_key = priv
                self.client.public_key = priv.public_key()
                messagebox.showinfo("Success", "Private key imported.")
                self.destroy()
            except Exception as e:
                messagebox.showerror("Error", f"Failed to import private key: {e}")
    def _generate_new_keypair(self):
        from tkinter import messagebox
        priv, pub = crypto_utils.generate_rsa_keypair()
        self.client.private_key = priv
        self.client.public_key = pub
        messagebox.showinfo("Success", "New keypair generated.")
        self.destroy()

class ToolTip:
    def __init__(self, widget, text):
        self.widget = widget
        self.text = text
        self.tipwindow = None
        widget.bind("<Enter>", self.show_tip)
        widget.bind("<Leave>", self.hide_tip)
    def show_tip(self, event=None):
        if self.tipwindow or not self.text:
            return
        x, y, _, cy = self.widget.bbox("insert")
        x = x + self.widget.winfo_rootx() + 30
        y = y + cy + self.widget.winfo_rooty() + 10
        self.tipwindow = tw = tk.Toplevel(self.widget)
        tw.wm_overrideredirect(True)
        tw.wm_geometry(f"+{x}+{y}")
        label = tk.Label(tw, text=self.text, justify='left', background=HACKER_PANEL, foreground=HACKER_ACCENT2, relief='solid', borderwidth=1, font=(HACKER_FONT, 9))
        label.pack(ipadx=4)
    def hide_tip(self, event=None):
        tw = self.tipwindow
        self.tipwindow = None
        if tw:
            tw.destroy()

class CollapsiblePanel(ttk.Frame):
    def __init__(self, parent, text, fg=HACKER_ACCENT2, bg=HACKER_BG):
        super().__init__(parent)
        self.show = tk.BooleanVar(value=False)
        self.header = ttk.Label(self, text=f"[+] {text}", foreground=fg, background=bg, font=(HACKER_FONT, 12, "bold"))
        self.header.pack(fill="x", padx=2, pady=2)
        self.header.bind('<Button-1>', self.toggle)
        self.frame = ttk.Frame(self, style='TFrame')
        self.frame.pack(fill="x", padx=2, pady=2)
        self.frame.pack_forget()
    def toggle(self, event=None):
        if self.show.get():
            self.header.config(text=self.header.cget('text').replace('[-]', '[+]'))
            self.frame.pack_forget()
            self.show.set(False)
        else:
            self.header.config(text=self.header.cget('text').replace('[+]', '[-]'))
            self.frame.pack(fill="x", padx=2, pady=2)
            self.show.set(True)

if __name__ == "__main__":
    app = Dashboard()
    app.mainloop()
