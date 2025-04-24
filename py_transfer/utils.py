import os
import re
import socket
import sys

def recv_exact(sock, n, timeout=None):
    """Receive exactly n bytes from the socket."""
    if timeout:
        sock.settimeout(timeout)
    data = b''
    while len(data) < n:
        packet = sock.recv(n - len(data))
        if not packet:
            raise ConnectionError("Socket connection broken while receiving data.")
        data += packet
    if timeout:
        sock.settimeout(None)
    return data

SAFE_FILENAME_RE = re.compile(r'^[\w\-. ]+$')

def is_safe_filename(filename):
    """Return True if filename is safe (no path traversal, only allowed chars)."""
    if not filename or filename.startswith('.') or '/' in filename or '\\' in filename:
        return False
    return bool(SAFE_FILENAME_RE.match(filename))

PROTOCOL_VERSION = "FT1.0"

