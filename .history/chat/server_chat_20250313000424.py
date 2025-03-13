import asyncio
import websockets
import socket
import json
import logging

# Configure logging
logging.basicConfig(
    filename='websocket.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger()

class WebSocketServer:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.clients = set()

    def get_local_ip(self):
        """Get the local IP address of the machine."""
        try:
            hostname = socket.gethostname()
            local_ip = socket.gethostbyname(hostname)
            print(f"Local ip: {local_ip}")
            print(f"hostname : {hostname}")

            logger.info(f"Local IP detected: {local_ip} Hostname: {hostname}")
            
            return local_ip
            
        except Exception as e:
            logger.error(f"Failed to get local IP: {e}")
            return "127.0.0.1"

    async def on_open(self, websocket):
        """Handle a new client connection."""
        print("[!] Client connected")
        logger.info(f"Client connected: {websocket.remote_address}")
        self.clients.add(websocket)

    async def on_message(self, websocket, message):
        """Handle incoming messages from clients."""
        try:
            data = json.loads(message)
            print(f"[+] Received message: {data}")
            logger.info(f"Received message: {data}")
            await self.broadcast(json.dumps(data))
        except json.JSONDecodeError as e:
            print(f"[-] Invalid message format: {e}")
            logger.error(f"Invalid message format: {e}")

    async def on_error(self, websocket, error):
        """Handle errors (currently unused but kept for potential future use)."""
        print(f"[-] Error: {error}")
        logger.error(f"Error: {error}")

    async def on_close(self, websocket):
        """Handle client disconnection."""
        print("[!] Client disconnected")
        logger.info(f"Client disconnected: {websocket.remote_address}")
        self.clients.discard(websocket)

    async def broadcast(self, message):
        """Broadcast a message to all connected clients."""
        for client in self.clients.copy():
            try:
                await client.send(message)
            except Exception as e:
                print(f"[-] Failed to send to {client.remote_address}: {e}")
                logger.error(f"Failed to send to {client.remote_address}: {e}")
                self.clients.discard(client)

    async def handler(self, websocket, path):
        """Handle WebSocket connections."""
        await self.on_open(websocket)
        try:
            async for message in websocket:
                await self.on_message(websocket, message)
        except websockets.ConnectionClosed:
            await self.on_close(websocket)

    async def start(self):
        """Start the WebSocket server."""
        print(f"[!] Starting WebSocket server on ws://{self.host}:{self.port}")
        logger.info(f"Starting WebSocket server on ws://{self.host}:{self.port}")
        
        async with websockets.serve(self.handler, self.host, self.port):
            await asyncio.Future()  # Run forever

if __name__ == "__main__":
    server = WebSocketServer("0.0.0.0", 3001)
    asyncio.run(server.start())
