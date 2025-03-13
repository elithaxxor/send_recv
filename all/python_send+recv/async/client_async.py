import asyncio
import websockets
import json
import base64
import os

async def websocket_client():
    uri = "ws://localhost:6969"
    async with websockets.connect(uri) as websocket:
        print("Connected to WebSocket server")

        while True:
            # Prompt user for an action
            action = input("Choose action (upload, download, list, chat, new-user, exit): ").strip().lower()
            if action == "exit":
                break

            # Handle user actions
            if action == "new-user":
                user_name = input("Enter your username: ").strip()
                message = {"action": "new-user", "user_name": user_name}
                await websocket.send(json.dumps(message))
            elif action == "upload":
                file_path = input("Enter file path to upload: ").strip()
                if not os.path.exists(file_path):
                    print("File not found")
                    continue
                with open(file_path, "rb") as f:
                    file_content = base64.b64encode(f.read()).decode("utf-8")
                file_name = os.path.basename(file_path)
                message = {"action": "upload", "fileName": file_name, "fileContent": file_content}
                await websocket.send(json.dumps(message))
            elif action == "download":
                file_name = input("Enter file name to download: ").strip()
                message = {"action": "download", "fileName": file_name}
                await websocket.send(json.dumps(message))
            elif action == "list":
                message = {"action": "list"}
                await websocket.send(json.dumps(message))
            elif action == "chat":
                message_text = input("Enter chat message: ").strip()
                message = {"action": "chat", "message": message_text}
                await websocket.send(json.dumps(message))
            else:
                print("Invalid action")
                continue

            # Receive and process server response
            response = await websocket.recv()
            data = json.loads(response)
            action = data.get("action")

            if action == "download":
                file_name = data["fileName"]
                file_content = base64.b64decode(data["fileContent"])
                with open(file_name, "wb") as f:
                    f.write(file_content)
                print(f"File {file_name} downloaded successfully")
            elif action == "list":
                files = data["files"]
                print("Available files:")
                for file in files:
                    print(f"- {file}")
            elif action == "chat":
                print(f"Chat from {data['user']}: {data['message']}")
            elif action == "user-connected":
                print(f"User {data['user_name']} connected")
            elif action == "user-disconnected":
                print(f"User {data['user_name']} disconnected")
            elif action == "error":
                print(f"Error: {data['message']}")

if __name__ == "__main__":
    asyncio.run(websocket_client())
