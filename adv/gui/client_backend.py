import os
import time
import threading
import base64
from .. import crypto_utils

try:
    from c_accel import compress_file
except ImportError:
    compress_file = None

class Compressor:
    def __init__(self, callback=None):
        self.callback = callback
        self.cancelled = False

    def compress(self, input_path, output_path):
        if compress_file is None:
            raise RuntimeError("Compression module not available")
        def cb(processed, total, elapsed, eta):
            if self.cancelled:
                raise Exception("Compression cancelled")
            percent = int((processed / total) * 100) if total > 0 else 0
            if self.callback:
                self.callback(percent, eta)
        compress_file(input_path, output_path, progress_cb=cb)

    def cancel(self):
        self.cancelled = True

class FileTransferClient:
    def __init__(self, gui):
        self.gui = gui
        self.selected_file = None
        self.connected = False
        self.compressor = Compressor(callback=self._compression_progress)
        self._compress_thread = None
        self.e2ee_enabled = True  # Default to E2EE on
        # Load/generate keys for demo (in production, use secure storage)
        self.private_key, self.public_key = crypto_utils.generate_rsa_keypair()
        self.server_public_key = None  # To be set after handshake

    def connect(self, host, port, username, password):
        time.sleep(1)
        self.connected = True
        self.gui.after(0, self.gui.conn_status.config, {"text": "Connected", "foreground": "green"})
        self.gui.after(0, self.gui.log, "Connected to server.")
        # Exchange public keys (demo: assign server_public_key to self.public_key)
        self.server_public_key = self.public_key  # Replace with real key exchange
        self.list_files()

    def disconnect(self):
        self.connected = False
        self.gui.after(0, self.gui.log, "Disconnected from server.")

    def upload_file(self, compress=False):
        if not self.selected_file:
            self.gui.after(0, self.gui.log, "No file selected.")
            return
        file_to_upload = self.selected_file
        temp_compressed = None
        if compress:
            self.gui.after(0, self.gui.log, "Compressing file before upload...")
            try:
                temp_compressed = file_to_upload + ".gz"
                self._compress_thread = threading.Thread(target=self._do_compress, args=(file_to_upload, temp_compressed), daemon=True)
                self._compress_thread.start()
                self._compress_thread.join()
                file_to_upload = temp_compressed
            except Exception as e:
                self.gui.after(0, self.gui.log, f"Compression failed: {e}")
                return
        # --- E2EE: Encrypt file before upload ---
        if self.e2ee_enabled:
            self.gui.after(0, self.gui.log, "Encrypting file (E2EE)...")
            with open(file_to_upload, 'rb') as f:
                plaintext = f.read()
            aes_key = crypto_utils.generate_aes_key()
            ciphertext = crypto_utils.aes_encrypt(aes_key, plaintext)
            # Encrypt AES key with server's public key
            enc_key = crypto_utils.rsa_encrypt(self.server_public_key, aes_key)
            # Save encrypted file and key (simulate upload)
            enc_file_path = file_to_upload + ".enc"
            enc_key_path = enc_file_path + ".key"
            with open(enc_file_path, 'wb') as ef:
                ef.write(ciphertext)
            with open(enc_key_path, 'wb') as ek:
                ek.write(enc_key)
            self.gui.after(0, self.gui.log, f"Encrypted file saved as {enc_file_path} (key: {enc_key_path})")
            # --- Upload to server ---
            self._upload_to_server_e2ee(enc_file_path, enc_key_path)
        else:
            # TODO: Upload file_to_upload to server as usual
            self.gui.after(0, self.gui.log, f"Uploading {file_to_upload} (unencrypted)")

    def _do_compress(self, input_path, output_path):
        self.compressor.compress(input_path, output_path)

    def _compression_progress(self, percent, eta):
        self.gui.after(0, self.gui.update_compress_progress, percent, eta)

    def _upload_to_server_e2ee(self, enc_file_path, enc_key_path):
        # Simulate socket connection and PUTF command
        import socket, struct
        host, port = '127.0.0.1', 22223  # Demo values
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((host, port))
            s.sendall(b'PUTF')
            # Send file name
            fname = os.path.basename(enc_file_path)
            s.sendall(struct.pack('H', len(fname)))
            s.sendall(fname.encode('utf-8'))
            # Send file size
            fsize = os.path.getsize(enc_file_path)
            s.sendall(struct.pack('Q', fsize))
            # Send file data
            with open(enc_file_path, 'rb') as f:
                while True:
                    chunk = f.read(65536)
                    if not chunk:
                        break
                    s.sendall(chunk)
            # Indicate key is coming
            s.sendall(b'1')
            # Send key file name
            kname = os.path.basename(enc_key_path)
            s.sendall(struct.pack('H', len(kname)))
            s.sendall(kname.encode('utf-8'))
            ksize = os.path.getsize(enc_key_path)
            s.sendall(struct.pack('Q', ksize))
            with open(enc_key_path, 'rb') as kf:
                while True:
                    chunk = kf.read(65536)
                    if not chunk:
                        break
                    s.sendall(chunk)
            resp = s.recv(2)
            if resp == b'OK':
                self.gui.after(0, self.gui.log, f"Encrypted file and key uploaded to server.")
            else:
                self.gui.after(0, self.gui.log, f"Server upload failed.")

    def list_files(self):
        # Connect to server and fetch file list with metadata
        # Simulated: Replace with real socket logic
        files = [
            {'name': 'example.txt', 'size': 12345, 'mtime': 1713920000, 'owner': 1000},
            {'name': 'data.zip', 'size': 987654, 'mtime': 1713925000, 'owner': 1000},
        ]
        self.gui.after(0, self.gui._on_file_list, files)

    def download_file(self, filename):
        # Download encrypted file and key from server using GETF command
        if self.e2ee_enabled:
            import socket, struct
            host, port = '127.0.0.1', 22223  # Demo values
            enc_file_path = filename + ".enc"
            enc_key_path = enc_file_path + ".key"
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((host, port))
                # Download encrypted file
                s.sendall(b'GETF')
                fname = os.path.basename(enc_file_path)
                s.sendall(struct.pack('H', len(fname)))
                s.sendall(fname.encode('utf-8'))
                s.sendall(struct.pack('Q', 0))  # offset 0
                # Receive file size
                file_size = struct.unpack('Q', s.recv(8))[0]
                if file_size == 0:
                    self.gui.after(0, self.gui.log, f"File not found on server: {enc_file_path}")
                    return
                # Receive SHA-256 (skip)
                s.recv(64)
                with open(enc_file_path, 'wb') as ef:
                    received = 0
                    while received < file_size:
                        chunk = s.recv(min(65536, file_size - received))
                        if not chunk:
                            break
                        ef.write(chunk)
                        received += len(chunk)
                # Download encrypted key
                s.sendall(b'GETF')
                kname = os.path.basename(enc_key_path)
                s.sendall(struct.pack('H', len(kname)))
                s.sendall(kname.encode('utf-8'))
                s.sendall(struct.pack('Q', 0))  # offset 0
                key_size = struct.unpack('Q', s.recv(8))[0]
                if key_size == 0:
                    self.gui.after(0, self.gui.log, f"Key not found on server: {enc_key_path}")
                    return
                s.recv(64)  # skip SHA-256
                with open(enc_key_path, 'wb') as ek:
                    received = 0
                    while received < key_size:
                        chunk = s.recv(min(65536, key_size - received))
                        if not chunk:
                            break
                        ek.write(chunk)
                        received += len(chunk)
            # Decrypt after download
            try:
                self.gui.after(0, self.gui.log, "Decrypting file (E2EE)...")
                with open(enc_file_path, 'rb') as ef:
                    ciphertext = ef.read()
                with open(enc_key_path, 'rb') as ek:
                    enc_key = ek.read()
                aes_key = crypto_utils.rsa_decrypt(self.private_key, enc_key)
                plaintext = crypto_utils.aes_decrypt(aes_key, ciphertext)
                out_path = filename + ".decrypted"
                with open(out_path, 'wb') as outf:
                    outf.write(plaintext)
                self.gui.after(0, self.gui.log, f"Decrypted file saved as {out_path}")
            except Exception as e:
                self.gui.after(0, self.gui.log, f"Decryption failed: {e}")
        else:
            # TODO: Download and save file as usual
            self.gui.after(0, self.gui.log, f"Downloaded {filename} (unencrypted)")

    def delete_file(self, filename):
        # Simulate server delete
        self.gui.after(0, self.gui.log, f"Deleted {filename} (simulated)")
        self.list_files()

    def rename_file(self, old_name, new_name):
        # Simulate server rename
        self.gui.after(0, self.gui.log, f"Renamed {old_name} to {new_name} (simulated)")
        self.list_files()

    def poll_notifications(self):
        # Simulate polling server for notifications
        notifications = [
            {'timestamp': '2025-04-24 00:51:53', 'event': 'download', 'user': 'user1', 'detail': 'example.txt'},
            {'timestamp': '2025-04-24 00:52:10', 'event': 'delete', 'user': 'user2', 'detail': 'data.zip'}
        ]
        self.gui.after(0, self.gui._on_notifications, notifications)

    def send_chat(self, msg):
        self.gui.after(0, self.gui.update_chat, f"You: {msg}")
        time.sleep(0.5)
        self.gui.after(0, self.gui.update_chat, f"Server: Echo - {msg}")
