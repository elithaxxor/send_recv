import os
import subprocess
import sys
import time
import filecmp
import tempfile
import shutil
import socket

import pytest

SERVER_SCRIPT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../server_socket+files.py'))
CLIENT_SCRIPT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../client_socket+files.py'))
SERVER_DIR = os.path.dirname(SERVER_SCRIPT)

@pytest.fixture(scope="module")
def temp_file():
    # Create a temporary file in the server directory so the server can access it
    temp_file_path = os.path.join(SERVER_DIR, "testfile.txt")
    with open(temp_file_path, "w") as f:
        f.write("This is a test file for transfer.\n")
    yield temp_file_path
    if os.path.exists(temp_file_path):
        os.remove(temp_file_path)

@pytest.fixture(scope="module")
def start_server(temp_file):
    # Start the server in a subprocess, capturing output
    proc = subprocess.Popen(
        [sys.executable, SERVER_SCRIPT],
        cwd=SERVER_DIR,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    time.sleep(1)  # Give server time to start
    yield proc
    # After the test, print any server output for debugging
    try:
        out, err = proc.communicate(timeout=2)
        print('SERVER STDOUT:')
        print(out)
        print('SERVER STDERR:')
        print(err)
    except Exception:
        pass
    proc.terminate()
    proc.wait()

@pytest.fixture(scope="module")
def wait_for_server():
    """Wait for the server to start accepting connections on CLIENT_PORT."""
    port = 22223
    host = "localhost"
    timeout = 10  # seconds
    start = time.time()
    while time.time() - start < timeout:
        try:
            with socket.create_connection((host, port), timeout=1):
                return
        except (ConnectionRefusedError, OSError):
            time.sleep(0.2)
    raise RuntimeError("Server did not start listening in time.")

def test_file_transfer(temp_file, start_server, wait_for_server):
    # Change to server directory so file is found
    cwd = SERVER_DIR
    file_name = os.path.basename(temp_file)
    # The client expects to be run interactively; simulate input
    client_proc = subprocess.Popen(
        [sys.executable, CLIENT_SCRIPT],
        cwd=cwd,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    try:
        # Send the file name as input to the client
        stdout, stderr = client_proc.communicate(input=f"{file_name}\n", timeout=10)
        print('CLIENT STDOUT:')
        print(stdout)
        print('CLIENT STDERR:')
        print(stderr)
        assert "File downloaded as" in stdout
        # Check that the downloaded file matches the original
        downloaded = os.path.join(cwd, f"downloaded_{file_name}")
        assert os.path.exists(downloaded)
        assert filecmp.cmp(temp_file, downloaded, shallow=False)
    finally:
        # Clean up downloaded file
        downloaded = os.path.join(cwd, f"downloaded_{file_name}")
        if os.path.exists(downloaded):
            os.remove(downloaded)
