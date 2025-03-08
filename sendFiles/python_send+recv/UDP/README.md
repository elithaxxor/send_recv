## Recent Fixes 
Client: Now handles errors robustly, calculates progress accurately, retries connections safely, and validates file size data.
Server: Ensures file existence, sends data reliably with fixed formats, handles client disconnections, and adapts to the local network dynamically.

## Updated Server Code
Applied Fixes
    * Added File Existence Check: Verified the file exists before attempting to send it to the client.
    
    * Sent File Size Using Fixed Format: Used struct.pack('!Q', file_size) to send the file size as an 8-byte unsigned integer.
    
    * Handled Client Disconnection During Transfer: Added error handling around sendall() to gracefully handle client disconnections.
    
    * Improved Minute Counter: Replaced with a real-time elapsed minutes calculation based on server uptime.
    
    * Removed Hardcoded IP: Dynamically fetched the local IP using get_local_ip() for flexibility.

## Updated Client Code
Applied Fixes
    * Corrected Progress Calculation: Used an integer (file_size_int) instead of a string for accurate progress computation.
    
    * Added File Size Validation: Included a try-except block to handle invalid file size data from the server.
    
    * Handled Incomplete File Reception: Added a check for empty data to detect premature server disconnection.
    
    * Improved Exception Handling: Enhanced socket operation error handling to catch specific issues like timeouts and connection refusals.
    
    * Replaced Recursive Main Call with Loop: Switched to a while loop for connection retries to prevent stack overflow.
    
    * Decoded File Size Using Fixed Format: Used struct.unpack('!Q', ...) for consistent file size reception matching the server’s format



Below is a complete `README.md` file for your GitHub repository, designed for a Python TCP file transfer project. This README provides a clear overview of the project, installation steps, usage instructions, and additional notes to help users get started.

---

# Python TCP File Transfer

A simple client-server application for transferring files over TCP using Python sockets.

## Description

This project consists of two scripts: a **server** and a **client**. The server sends a specified file to the client over a TCP connection. The client connects to the server, receives the file, and displays the transfer progress using a progress bar. The system leverages Python's `socket` library for networking, with `colorama` for colored terminal output and `tqdm` for progress visualization.

## Features

- **Server**: Sends a user-specified file to the client upon connection.
- **Client**: Connects to the server, receives the file, and shows real-time transfer progress.
- **User Interface**: Enhanced with colored output and progress bars.

## Requirements

- Python 3.x
- `colorama`
- `tqdm`

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/your-repo-name.git
   cd your-repo-name
   ```

2. Install the required dependencies:
   ```bash
   pip install colorama tqdm
   ```

## Usage

### Running the Server

1. Start the server by running:
   ```bash
   python server.py
   ```

2. The server will display its local IP address and begin listening for client connections.

3. When a client connects, you’ll be prompted to enter the name of the file to send. Make sure the file exists in the current directory.

### Running the Client

1. Start the client by running:
   ```bash
   python client.py
   ```

2. When prompted, press `1` to use the default server IP (e.g., `192.168.1.77`) or enter a custom IP address.

3. The client will attempt to connect to the server. If the connection fails, it will retry every 5 seconds.

4. Once connected, the client will receive the file and display the transfer progress.

## Notes

- Ensure the server and client are on the same network for successful communication.
- The server dynamically binds to the local IP address, adapting to your network setup.
- The client automatically retries connecting if the server isn’t available initially.
- TCP ensures reliable file transfer with data integrity.
