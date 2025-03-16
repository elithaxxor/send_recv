import asyncio
import websockets
import json
import curses
import datetime
from typing import List, Dict
import signal
import sys

class ChatUI:
    def __init__(self, stdscr):
        self.stdscr = stdscr
        self.messages: List[Dict] = []
        self.input_buffer = ""
        self.max_messages = 50
        
        # Initialize colors
        curses.start_color()
        curses.use_default_colors()
        curses.init_pair(1, curses.COLOR_GREEN, -1)   # System messages
        curses.init_pair(2, curses.COLOR_CYAN, -1)    # User messages
        curses.init_pair(3, curses.COLOR_YELLOW, -1)  # Input area
        curses.init_pair(4, curses.COLOR_RED, -1)     # Error messages
        
        # Hide cursor
        curses.curs_set(0)
        
        # Enable keypad
        self.stdscr.keypad(True)
        
        # Get terminal dimensions
        self.height, self.width = self.stdscr.getmaxyx()
        
        # Create windows
        self.chat_win = curses.newwin(self.height - 3, self.width, 0, 0)
        self.input_win = curses.newwin(3, self.width, self.height - 3, 0)
        
        # Enable scrolling in chat window
        self.chat_win.scrollok(True)
        
        # Draw initial UI
        self.draw_ui()

    def draw_ui(self) -> None:
        """Draw the basic UI elements."""
        self.stdscr.clear()
        self.chat_win.box()
        self.input_win.box()
        
        # Draw title
        title = "💬 WebSocket Chat Client"
        self.chat_win.addstr(0, (self.width - len(title)) // 2, title, curses.color_pair(2))
        
        # Draw status bar
        status = "Connected | Press Ctrl+C to exit | Enter to send"
        self.input_win.addstr(0, (self.width - len(status)) // 2, status, curses.color_pair(1))
        
        # Draw input prompt
        self.input_win.addstr(1, 2, "> ", curses.color_pair(3))
        
        self.refresh_all()

    def refresh_all(self) -> None:
        """Refresh all windows."""
        self.chat_win.refresh()
        self.input_win.refresh()
        self.stdscr.refresh()

    def add_message(self, message: Dict) -> None:
        """Add a new message to the chat window."""
        timestamp = datetime.datetime.now().strftime("%H:%M:%S")
        self.messages.append({"time": timestamp, **message})
        
        if len(self.messages) > self.max_messages:
            self.messages.pop(0)
            
        self.redraw_messages()

    def redraw_messages(self) -> None:
        """Redraw all messages in the chat window."""
        self.chat_win.clear()
        self.chat_win.box()
        
        # Redraw title
        title = "💬 WebSocket Chat Client"
        self.chat_win.addstr(0, (self.width - len(title)) // 2, title, curses.color_pair(2))
        
        y = 1
        for msg in self.messages:
            if y >= self.height - 4:  # Leave space for box and input
                break
                
            time = msg["time"]
            content = msg.get("message", "")
            
            # Format: [HH:MM:SS] Message
            message_text = f"[{time}] {content}"
            
            # Wrap long messages
            while len(message_text) > self.width - 4:
                self.chat_win.addstr(y, 2, message_text[:self.width-4], curses.color_pair(2))
                message_text = message_text[self.width-4:]
                y += 1
                if y >= self.height - 4:
                    break
            
            if y < self.height - 4:
                self.chat_win.addstr(y, 2, message_text, curses.color_pair(2))
                y += 1
        
        self.refresh_all()

    def update_input(self) -> None:
        """Update the input window with current buffer."""
        self.input_win.clear()
        self.input_win.box()
        
        # Redraw status
        status = "Connected | Press Ctrl+C to exit | Enter to send"
        self.input_win.addstr(0, (self.width - len(status)) // 2, status, curses.color_pair(1))
        
        # Draw input with prompt
        self.input_win.addstr(1, 2, "> " + self.input_buffer, curses.color_pair(3))
        self.refresh_all()

class AsyncChatClient:
    def __init__(self, uri: str, ui: ChatUI):
        self.uri = uri
        self.ui = ui
        self.websocket = None
        self.running = True

    async def connect(self) -> None:
        """Connect to the WebSocket server."""
        try:
            self.websocket = await websockets.connect(self.uri)
            self.ui.add_message({"message": f"Connected to {self.uri}"})
        except Exception as e:
            self.ui.add_message({"message": f"Connection failed: {str(e)}"})
            self.running = False

    async def receive_messages(self) -> None:
        """Receive and display messages from the server."""
        try:
            while self.running:
                message = await self.websocket.recv()
                try:
                    data = json.loads(message)
                    self.ui.add_message(data)
                except json.JSONDecodeError:
                    self.ui.add_message({"message": f"Invalid message format: {message}"})
        except websockets.ConnectionClosed:
            self.ui.add_message({"message": "Connection closed by server"})
            self.running = False
        except Exception as e:
            self.ui.add_message({"message": f"Error receiving messages: {str(e)}"})
            self.running = False

    async def handle_input(self) -> None:
        """Handle user input."""
        while self.running:
            try:
                # Get character
                ch = self.ui.stdscr.getch()
                
                if ch == ord('\n'):  # Enter key
                    if self.ui.input_buffer:
                        message = self.ui.input_buffer
                        self.ui.input_buffer = ""
                        self.ui.update_input()
                        
                        try:
                            await self.websocket.send(json.dumps({"message": message}))
                        except Exception as e:
                            self.ui.add_message({"message": f"Failed to send message: {str(e)}"})
                
                elif ch == curses.KEY_BACKSPACE or ch == 127:  # Backspace
                    self.ui.input_buffer = self.ui.input_buffer[:-1]
                    self.ui.update_input()
                
                elif ch == curses.KEY_RESIZE:  # Terminal resize
                    self.ui.height, self.ui.width = self.ui.stdscr.getmaxyx()
                    self.ui.chat_win.resize(self.ui.height - 3, self.ui.width)
                    self.ui.input_win.resize(3, self.ui.width)
                    self.ui.input_win.mvwin(self.ui.height - 3, 0)
                    self.ui.draw_ui()
                    self.ui.redraw_messages()
                
                elif 32 <= ch <= 126:  # Printable characters
                    self.ui.input_buffer += chr(ch)
                    self.ui.update_input()
                
            except Exception as e:
                self.ui.add_message({"message": f"Input error: {str(e)}"})

    async def run(self) -> None:
        """Run the chat client."""
        await self.connect()
        if self.running:
            await asyncio.gather(
                self.receive_messages(),
                self.handle_input()
            )

def main(stdscr) -> None:
    """Main function to set up and run the chat client."""
    # Get server details
    address = input("Enter server address (default: localhost): ").strip() or "localhost"
    port = input("Enter server port (default: 3001): ").strip() or "3001"
    
    try:
        port = int(port)
    except ValueError:
        print("Invalid port number. Using default port 3001.")
        port = 3001
    
    uri = f"ws://{address}:{port}"
    
    # Clear screen before starting curses
    print("\033[2J\033[H")
    
    # Initialize UI
    ui = ChatUI(stdscr)
    client = AsyncChatClient(uri, ui)
    
    # Handle Ctrl+C gracefully
    def signal_handler(sig, frame):
        client.running = False
        sys.exit(0)
    
    signal.signal(signal.SIGINT, signal_handler)
    
    # Run the client
    asyncio.run(client.run())

if __name__ == "__main__":
    curses.wrapper(main)
