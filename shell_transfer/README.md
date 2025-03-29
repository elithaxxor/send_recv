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


`README.md` file for the `server_transfer_bind.sh` script:

```markdown
# Server Transfer Bind Script

This script facilitates file transfers between a client and a server using Netcat (`nc`). It allows the user to list and download files from the server directory.

## Prerequisites

- Ensure Netcat (`nc`) is installed on both the client and server machines.
- The server machine must have a corresponding script or process to handle the commands sent by this script (e.g., sending directory listings or files).

## Usage

### Running the Script

```bash
./server_transfer_bind.sh [SERVER_ADDRESS] [PORT]
```

- `SERVER_ADDRESS`: The IP address of the server (default: `192.168.1.112`).
- `PORT`: The port number to connect to on the server (default: `12345`).

### Script Options

Once the script is running, you will be presented with the following options:

1. **List files**: List the contents of the server directory.
2. **Download files**: Download files from the server by specifying their numbers or ranges.
3. **Exit**: Exit the script.

### Downloading Files

- You can specify individual file numbers (e.g., `1 3 5`).
- You can specify a range of file numbers (e.g., `1-5`).
- You can download all files by typing `all`.

## Functions

- `send_command()`: Sends a command to the server using Netcat.
- `list_files()`: Lists the contents of the server directory.
- `download_files()`: Prompts the user to select files to download from the server.

## Example

1. List files on the server:

```bash
Choose an option (1-3): 1
```

2. Download specific files from the server:

```bash
Choose an option (1-3): 2
Enter file numbers (e.g., 1 3 5 or 1-5) or 'all': 1 3
```

## Notes

- Ensure the server is configured to handle the commands (`LIST`, `GET`, `GETALL`) sent by this script.
- The script uses `tar -xzvf -` to extract files received from the server. Ensure `tar` is installed and available on the client machine.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

This `README.md` file provides an overview of the script, usage instructions, and examples to help users understand and use the script effectively.
