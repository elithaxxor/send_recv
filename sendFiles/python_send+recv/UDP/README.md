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
