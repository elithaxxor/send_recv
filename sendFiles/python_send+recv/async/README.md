
TCP-based Server Fixes

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

WebSocket-based Server Fixes

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
