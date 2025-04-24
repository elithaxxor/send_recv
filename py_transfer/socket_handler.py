import socket

class SocketHandler:
    def __init__(self, host=None, port=22223, use_ipv6=False):
        self.host = host or socket.gethostname()
        self.port = port
        self.use_ipv6 = use_ipv6
        self.family = socket.AF_INET6 if use_ipv6 else socket.AF_INET
        self.sock = socket.socket(self.family, socket.SOCK_STREAM)

    def bind_and_listen(self):
        ip = socket.gethostbyname(self.host) if not self.use_ipv6 else socket.getaddrinfo(self.host, self.port, socket.AF_INET6)[0][4][0]
        self.sock.bind((ip, self.port))
        self.sock.listen(5)
        print(f"[SocketHandler] Listening on {ip}:{self.port} (IPv6={self.use_ipv6})")

    def accept(self):
        return self.sock.accept()

    def connect(self, host, port):
        self.sock.connect((host, port))

    def close(self):
        self.sock.close()
