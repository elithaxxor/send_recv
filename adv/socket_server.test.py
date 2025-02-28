import socket
import threading
from socket_server import handle_clients1

def test_handle_client():
    # Create a test client socket
    test_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    test_socket.bind(('localhost', 0))
    test_socket.listen(1)
    
    # Start the server in a separate thread
    server_thread = threading.Thread(target=handle_clients1, args=(test_socket, ('localhost', test_socket.getsockname()[1])))
    server_thread.start()
    
    # Connect to the server
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
        client_socket.connect(('localhost', test_socket.getsockname()[1]))
        
        # Send a test command
        client_socket.sendall(b'TEST')
        
        # Receive the response
        response = client_socket.recv(1024)
        print(f"Received response: {response}"  )
        
        # Close the connection
        
    # Stop the server
    