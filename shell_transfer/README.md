Here's a `README.md` for the `server_transfer_.bind.sh` script:

```markdown
# Server Transfer Shell Script

This repository contains a shell script that sets up a simple server to handle file transfer commands over a specified port.

## Description

The `server_transfer_.bind.sh` script uses `netcat` to listen for incoming connections on a specified port. It accepts commands to list files in the directory, send all files as a compressed archive, or send specific files as a compressed archive.

## Usage

### Starting the Server

To start the server, run the script with an optional port number. If no port number is specified, the default port `12345` is used.

```bash
./server_transfer_.bind.sh [PORT]
```

### Commands

Once the server is running, it can accept the following commands from the client:

- `LIST`: Lists all files in the current directory, numbered.
- `GETALL`: Sends the entire directory as a compressed `tar.gz` archive.
- `GET <filename1> <filename2> ...`: Sends the specified files as a compressed `tar.gz` archive.

### Example

1. **Start the Server**:
   ```bash
   ./server_transfer_.bind.sh 12345
   ```

2. **Client Command**:
   You can use `netcat` or `nc` to connect to the server and issue commands.
   
   ```bash
   echo "LIST" | nc localhost 12345
   echo "GETALL" | nc localhost 12345 > all_files.tar.gz
   echo "GET file1.txt file2.txt" | nc localhost 12345 > selected_files.tar.gz
   ```

## Script Details

- **Port Configuration**: The script accepts an optional port number as an argument. If not provided, it defaults to `12345`.
- **Command Handling**: The server listens for the following commands:
  - `LIST`: Lists files in the directory.
  - `GETALL`: Compresses and sends the entire directory.
  - `GET <filename1> <filename2> ...`: Compresses and sends the specified files.
- **Error Handling**: If an invalid command is received or a specified file is not found, appropriate error messages are sent to the client.

## Dependencies

- `netcat` or `nc`
- `tar`
- `ls`
- `nl`
- `sed`
