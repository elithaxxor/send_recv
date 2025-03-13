How It Works

    Sending Messages:
        The send_messages coroutine prompts the user for input using input("Enter message: "), executed in a separate thread via run_in_executor to avoid blocking.
        If the user types "exit" (case-insensitive), the WebSocket connection is closed, and the loop exits.
        Otherwise, the input is wrapped in a JSON object (e.g., {"message": "hello"}) and sent to the server.
        Exceptions like ConnectionClosed (if the server disconnects) or general errors are caught, printing a message and breaking the loop.
    Receiving Messages:
        The receive_messages coroutine uses async for message in websocket to listen for incoming messages.
        Each message is parsed as JSON and printed. If parsing fails (e.g., invalid JSON), an error is displayed.
        If the connection closes (e.g., server shutdown or user-initiated "exit"), it catches ConnectionClosed, prints a message, and exits.
    Main Execution:
        The main function connects to ws://localhost:3001.
        It uses asyncio.gather to run send_messages and receive_messages concurrently.
        Connection errors (e.g., server not running) are caught and reported.

Usage

    Start the Server: Run the provided server code first. It will listen on port 3001.
    Run the Client: Execute this client script in a separate terminal.
    Interact:
        Type a message (e.g., "hello") and press Enter to send it to the server.
        The server broadcasts the message, and the client prints it (e.g., Received: {'message': 'hello'}).
        Type "exit" to close the connection and stop the client.

Notes

    Host: The client connects to localhost since the server binds to "0.0.0.0". If the server runs on a different machine, replace "localhost" with the server’s IP address.
    Message Format: The client sends JSON with a "message" key, matching the server’s expectation of JSON data.
    Dependencies: Only standard libraries (asyncio, json) and websockets are required, matching the server’s dependencies.

This client effectively communicates with the provided WebSocket server, fulfilling the requirements for sending, receiving, and handling connection states.
