# Usage: Both clients (threaded and async) handle errors gracefully and provide feedback to the user, aligning with the functionality of their respective servers.

    Running the TCP Client:
        Ensure the TCP server is running (python tcp_server.py).
        Run the client: python tcp_client.py.
        Follow the prompts to interact with the server.


# TCP Client

The TCP server uses a custom binary protocol over TCP on port 22223. It supports commands like EXIT, LIST, CHAT, and FILE, with messages prefixed by length headers. The client will connect to localhost:22223 and provide an interface for these commands.

## Connection: The client uses the socket library to connect to localhost:22223.
### User Interaction: A loop prompts the user to select a command (EXIT, LIST, CHAT, or FILE).

    ```
    EXIT: Closes the connection.
    LIST: Requests a directory listing.
    CHAT: Placeholder command (not implemented on the server).
    FILE: Requests a file download by name.
    ```

### Message Format: Commands are sent with a 4-byte length prefix using struct.pack('!I', ...). For the FILE command, the file name is sent with an 8-byte length prefix.

Response Handling:

    ```
    LIST: Receives an 8-byte size followed by the listing data.
    CHAT: Receives a simple text response.
    FILE: Receives an 8-byte file size, then the file data, which is saved to disk.
    ```
# Usage
    
Running the TCP Client:

    Ensure the TCP server is running (python tcp_server.py).
    Run the client: python tcp_client.py.
    Follow the prompts to interact with the server.

    
## TCP-based Server Fixes

    Consistent Directory Listing:
        Removed redundant listing logic and retained only the send_directory_listing() function to ensure a single, formatted response for the "LIST" command.
    Robust Command Reading:
        Implemented a 4-byte length prefix for commands (using struct.unpack('!I', ...)), allowing variable-length commands to be read reliably.
    Chat Command Placeholder:
        Added a response for the "CHAT" command (b"Chat feature not implemented") to prevent the server from hanging when this unimplemented feature is requested.
    Improved File Transfer:
        Eliminated unnecessary client-side file size reception since the server dictates the file size.
        Added handling for ConnectionAbortedError and BrokenPipeError to gracefully manage client disconnections during file transfers.
    Enhanced Error Handling:
        Ensured error messages are sent only if the client socket is still open, preventing exceptions when writing to a closed connection.

----------------------------------------------------------------------------------------------------------------------
# Websocket Client 

The WebSocket server uses the WebSocket protocol (ws://) and communicates via JSON messages. It supports actions such as uploading files, downloading files, listing files, sending chat messages, and registering new users. The client will connect to ws://localhost:6969 and provide a user-friendly interface for these operations.

## Usage: 

   Running the WebSocket Client:
   
        Ensure the WebSocket server is running (python websocket_server.py).
        Run the client: python websocket_client.py.
        Follow the prompts to interact with the server.

## Explanation

    Connection: The client uses the websockets library to connect to ws://localhost:6969.
    User Interaction: A loop prompts the user to select an action (upload, download, list, chat, new-user, or exit).
        new-user: Registers a username with the server.
        upload: Reads a file, encodes it in base64, and sends it with the file name.
        download: Requests a file by name.
        list: Requests the list of available files.
        chat: Sends a chat message.
    Response Handling: The client listens for server responses and processes them based on the action field:
        Saves downloaded files.
        Displays file lists or chat messages.
        Shows user connection/disconnection events or errors.
        
## WebSocket-based Server Fixes

    File Name Security:
        Applied os.path.basename() in handle_upload and handle_download to sanitize file names, preventing directory traversal attacks.
    User Management:
        In on_close, removed disconnected users from the self.users dictionary to avoid memory leaks and notified other clients of the disconnection.
    Reliable Broadcasting:
        Updated broadcast to remove clients that fail during message sending (using self.clients.discard()), ensuring the clients set contains only active connections.
    Chat Message Handling:
        Modified handle_chat to exclude the sender from the broadcast (self.clients - {websocket}), preventing the sender from receiving their own message.
    Error Reporting:
        Added the send_error method to provide feedback to clients for issues like missing files or invalid actions.
    Directory Initialization:
        Ensured the files directory is created during initialization, with proper error logging if creation fails.



