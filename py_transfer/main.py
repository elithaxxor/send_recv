import os
import socket
import time
import numpy
import sys
import select  ## OS LEEL loop
import io

from numpy.lib.format import BUFFER_SIZE
##  TODO: MAKE STRUCTURE FOR FILE TRANSFER AND CHAT AND CLIENT/SERVER INFO
### TODO: MAKE DATASTRUCTURES A CLASS; SEPERATE FILES BY INDIVIDUAL FUNCTIONS (CWD, CHILD, PARENT, ETC)
### TODO: ADD THREADING TO INCLUDE MULTIPLE CLIENTS AND SERVERS
## TODO: Add Chat Functionality and Simple FLASK API
## TODO: MAKE A CLASS FOR FILE TRANSFER
## TODO: ADD A CLASS FOR CHAT FUNCTIONALITY
## TODO: ADD A CLASS FOR FLASK API
###########################################

## 01_sender.py
## TODO: 1. Add a class for socket // 2. Add a class for file transfer // 3.  Add a class for chat // 4. Add a class for flask
BUFFER_SIZE:int = 8192
CLIENT_PORT:int = 22223

## 1. Create a socket
## TODO: Add Conditional for IPV4 and IPV6 //
CLIENT_HOSTNAME = socket.gethostname()
CLIENT_IP = socket.gethostbyname(CLIENT_HOSTNAME)
socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

## 1a. Display connection details
print(f"[SYS]connected to {CLIENT_HOSTNAME} with IP {CLIENT_IP} at port: {CLIENT_PORT}")
print(f"[SYS] Initiating connection..{type(socket)} + {socket}")
print(f"[SYS] {socket.getsockname()}")  ## getsockname()



## 2. Bind the socket to the IP and PORT
socket.bind((CLIENT_IP, CLIENT_PORT))
socket.listen(5)  # sets max que  to 5
print(f"[SYSTEM] {socket.getsockname()}")

## accepting connection
file_name = input("[SYSTEM] Enter File Name: ")
file_size = os.path.getsize(file_name)

'''sending a file from a server to a client over a socket connection. '''
client, addr = socket.accept()
print(f"[+] connected to {client}, {addr}")
time.sleep(1)

bytes_name = client.send(file_name.encode())
time.sleep(.5)
bytes_sent = client.send(str(file_size).encode())

send_count = 0
buffer = file_size
send_start = time.time()

''' open and read as binary for parsing '''
print(f"[+] {file_name} is {file_size} bytes \n[SYSTEM].. Initiating File Transfer.")
while buffer != file_size:
    elapsed_time = time.time - file_size - send_start
    print(f"[+] {file_name} Transfer in progress: {send_count} of {file_size} bytes sent. \n[!] Elapsed Time: {elapsed_time}")
    
    with open(file_name, "rb") as file:
        data = file.read(8192)

        if not (data):
            print(f"[SYSTEM] {file_name} Transfer Complete, {send_count} of {file_size} bytes sent.")
            break  # <- end of F/T

        client.sendall(data)
        send_count += len(data)  ## byte format established line 63
        send_curr = time.time()

send_end = time.time()


total_time = send_end - send_start
print(f"[SYSTEM] {file_name} Transfer Complete in: {total_time}")
socket.close()  # stop

#
#
#
# ##################################
# def linesplit(socket):
#     buffer = socket.recv(4096)
#     buffering = True
#     while buffering:
#     ## open and read as binary for parsing
#         with open(file_name, 'rb', buffering = 3000000000) as file: ## buffer by 3GB
#             send_count = 0
#             send_start = time.time()
#                 # start loop
#             while send_count != file_size: # start loop
#                 data = file.read(4096)
#                 if not (data):
#                 break #<- end of F/T
#                 client.sendall(data)
#                 send_count += len(data) ## byte format established line 63
#
#         send_end = time.time()
# total_time = send_end - send_start
# print(f'[SYSTEM] {file_name} Transfer Complete in: {total_time}')
# socket.close() # stop
#
#
#

#
#
#
# # sample buffer #
# while True:
#     clientsocket, address = s.accept()
#     print(f"Connection from {address} has been established.")
#     # clientsocket.send(bytes('[SERVER**]- You have been connected to the SERVER', 'utf-8'))
#     clientsocket.send(bytes(msg,"utf-8"))
#     #d = {1:"hi", 2: "there"}
#     msg = pickle.dumps(d)
#     msg = bytes(f"{len(msg):<{HEADERSIZE}}", 'utf-8') + msg
#     print(msg)
#     clientsocket.send(msg)
#
#     msg = "[SERVER] Welcome to the server!"
#     msg = f'{len(MSG):<{HEADERSIZE}} + MSG' ## left align lenght of MSG to the left and append MSG from ^
#     print(f'DEBUGGING--> CHECK MESSAGE FORMATTING: {MSG}') #### DEBUG `delete later}     clientsocket.send(bytes("utf-8"))
#     clientsocket.send(bytes(msg,"utf-8"))
#     #clientsocket.close()
#     while True:
#         time.sleep(3)
#         msg = f"The time is {time.time()}"
#         msg = f"{len(msg):<{HEADERSIZE}}" + msg
#         print(msg)


#
# def linesplit(socket):
#     buffer = socket.recv(4096)
#     buffering = True
#     while buffering:
#         if "\n" in buffer:
#             (line, buffer) = buffer.split("\n", 1)
#             yield line + "\n"
#         else:
#             more = socket.recv(4096)
#             if not more:
#                 buffering = False
#             else:
#                 buffer += more
#     if buffer:
#         yield buffer
