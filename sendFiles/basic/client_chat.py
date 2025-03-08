import asyncio
import websockets
import json

async def send_messages(websocket):
    """Send messages to the server based on user input."""
    while True:
        try:
            # Read user input asynchronously
            message = await asyncio.get_event_loop().run_in_executor(None, input, "Enter message: ")
            if message.lower() == "exit":
                await websocket.close()
                break
            # Format message as JSON and send
            data = {"message": message}
            await websocket.send(json.dumps(data))
        except websockets.ConnectionClosed:
            print("Connection closed while sending.")
            break
        except Exception as e:
            print(f"Error while sending: {e}")

async def receive_messages(websocket):
    """Receive and display messages from the server."""
    try:
        async for message in websocket:
            try:
                data = json.loads(message)
                print(f"Received: {data}")
            except json.JSONDecodeError as e:
                print(f"Invalid message: {e}")
    except websockets.ConnectionClosed:
        print("Connection closed.")

async def main():
    """Main function to connect to the server and run send/receive tasks."""
    uri = "ws://localhost:3001"
    try:
        async with websockets.connect(uri) as websocket:
            # Run sending and receiving tasks concurrently
            await asyncio.gather(
                send_messages(websocket),
                receive_messages(websocket)
            )
    except Exception as e:
        print(f"Failed to connect: {e}")

if __name__ == "__main__":
    asyncio.run(main())
