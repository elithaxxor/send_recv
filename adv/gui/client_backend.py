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
                self.gui.after(0, self.gui.log, f"Compressed to {file_to_upload}")
                self.gui.after(0, self.gui.reset_compress_progress)
            except Exception as e:
                self.gui.after(0, self.gui.log, f"Compression failed: {e}")
                self.gui.after(0, self.gui.reset_compress_progress)
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
            with open(enc_file_path, 'wb') as ef:
                ef.write(ciphertext)
            with open(enc_file_path + ".key", 'wb') as ek:
                ek.write(enc_key)
            self.gui.after(0, self.gui.log, f"Encrypted file saved as {enc_file_path} (key: {enc_file_path}.key)")
            # TODO: Upload enc_file_path and enc_file_path.key to server
        else:
            # TODO: Upload file_to_upload to server as usual
            self.gui.after(0, self.gui.log, f"Uploading {file_to_upload} (unencrypted)")
        self.gui.upload_pb.start()
        time.sleep(2)  # Simulate upload
        self.gui.upload_pb.stop()
        self.gui.after(0, self.gui.log, f"Uploaded {file_to_upload} (simulated)")
        # Clean up temp file
        if temp_compressed and os.path.exists(temp_compressed):
            os.remove(temp_compressed)

    def _do_compress(self, input_path, output_path):
        self.compressor.compress(input_path, output_path)

    def _compression_progress(self, percent, eta):
        self.gui.after(0, self.gui.update_compress_progress, percent, eta)

    def list_files(self):
        # Connect to server and fetch file list with metadata
        # Simulated: Replace with real socket logic
        files = [
            {'name': 'example.txt', 'size': 12345, 'mtime': 1713920000, 'owner': 1000},
            {'name': 'data.zip', 'size': 987654, 'mtime': 1713925000, 'owner': 1000},
        ]
        self.gui.after(0, self.gui._on_file_list, files)

    def download_file(self, filename):
        # TODO: Download encrypted file and key from server
        enc_file_path = filename + ".enc"
        enc_key_path = enc_file_path + ".key"
        if self.e2ee_enabled:
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
        else:
            # TODO: Download and save file as usual
            self.gui.after(0, self.gui.log, f"Downloaded {filename} (unencrypted)")
        # Simulated download with resume and checksum verification
        partial_path = filename + '.part'
        offset = 0
        if os.path.exists(partial_path):
            offset = os.path.getsize(partial_path)
        # Simulate server response
        file_size = 12345
        checksum = 'dummychecksum1234567890abcdef'
        with open(partial_path, 'ab') as f:
            # Simulate download
            for i in range(offset, file_size, 4096):
                time.sleep(0.01)  # Simulate network
                f.write(b'0' * min(4096, file_size - i))
                percent = int((i + 4096) / file_size * 100)
                self.gui.after(0, self.gui._on_download_progress, percent, None)
        # Verify checksum (simulate)
        actual_checksum = 'dummychecksum1234567890abcdef'
        if actual_checksum == checksum:
            self.gui.after(0, self.gui.log, f"Download complete and verified: {filename}")
            os.rename(partial_path, filename)
        else:
            self.gui.after(0, self.gui.log, f"Checksum mismatch for {filename}!")

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
