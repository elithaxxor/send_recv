import threading, os, socket, time, sys, tqdm
from tqdm import tqdm
from hurry.filesize import size
# from Crypto.Cipher import AES
# import pycryptodome as Crypto


''' 
    ************** MAY BE BUG WITH KEY NONCE ******************
    --->  cipher.nonce  # A byte string you must send to the receiver too
    
    pip install pycryptodome
    pip3 install hurry.filesize
    pip3 install pycrypto
    pip3 install tqdm 
'''
''' [+] RSA ENCRYPTION APP
    1. Write function to take user input. [SENER] [RECEIVER]
    2. Write receive encrypted message and send. [SENDER]
    3. Write function receive encrypted message and  decrypt message. [RECEIVER]
'''


''' [+] GENERATE RSA KEYS 
    -> RSA is a public-key cryptosystem that is widely used for secure data transmission.
    -> IT IS ASYMETRIC ENCRYPTION [PUBLIC KEY AND PRIVATE KEY]
    -> IT FUNCTIONS TO ENCRYPT AND DECRYPT DATA, DEPENDING ON USERS INPUT
'''

LOCK = threading.Lock()
def take_user_input():
    ip = input(" [+] IP: ")
    port = input(" [+] PORT: (default = 1423) ")
    filename = input(" [?] FILENAME: ")
    writingThread = threading.Thread(target=send_encrypted_message(ip, port, filename))
    writingThread.start()



def send_encrypted_message(IP, PORT, filename):
    print(f" [+] Sending Encrypted Message\n[!] IP: {IP}\n[!] PORT: {PORT}\n[!] FILENAME: {filename}")
    ''' INIT ENCRYPTION '''
    KEY = b'os.urandom(16)'
    NONCE = b'os.urandom(16)'
   # CIPHER = Crypto.Cipher.AES.new(KEY, Crypto.Cipher.AES.MODE_EAX, nonce=NONCE)
    print(f" [+] Encryption initialized with key: {KEY} and nonce: {NONCE}")
   #       f" [+] Encryption initialized with cipher: {CIPHER}")

    print(f" [+] Connecting to server... \n{IP}, {PORT}")
    ''' INIT CLIENT '''
    CLIENT = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    CLIENT.connect((IP, int(PORT)))
    file_size = os.path.getsize(filename)
    CLIENT.connect((IP, int(PORT)))

   # encrypted = CIPHER.encrypt(filename)
    ''' READ FILE IN BINARY MODE '''
    with open(filename, 'rb') as file:
        while True:
            data = file.read(1024)
            if not data:
                print(" [-] No data to send")
                break

    ''' FAILSAFES  '''
    if CLIENT is None:
        print(" [+] Could not connect to server")
        sys.exit(1)
    print(f" [+] Connected to {IP} on port {PORT}")
    if file_size == 0 or file_size is None:
        print(" [+] File is empty")
        sys.exit(1)

    '''  [SEND FILENAME AND FILE SIZE TO SERVER]
        -> use <EOF> to indicate end of file transmission
        -> remove <EOF> from file on receiving end
    '''
    try:
        print(f" [+] Sending {filename} with size {file_size} bytes\n [+] {os.getcwd()}")
        progress = tqdm.tqdm(range(file_size), f"Sending {filename}", unit="B", unit_scale=True, unit_divisor=1024)

        done = False
        while not done:
            CLIENT.send(f"{str(filename)} {str(file_size)}".encode())
        #    CLIENT.sendall(encrypted)
            CLIENT.send(b"<EOF>")
            CLIENT.close()
            if len(data) < 1024:
                done = True
            progress.update(1024)
            CLIENT.close()
            print(" [+] File sent successfully")


    except Exception as e:
        print(f" [-] Error sending file: {e}")







def receive_encrypted_message():

    ''' INIT ENCRYPTION '''
    KEY = b'os.urandom(16)'
    NONCE = b'os.urandom(16)'
   # CIPHER = Crypto.Cipher.AES.new(KEY, Crypto.Cipher.AES.MODE_EAX, nonce=NONCE)
    CLIENT = None
    ADDR = None

    ''' INIT SERVER '''
    try:
        SERVER = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        HOST = socket.gethostbyname(socket.gethostname())
        SERVER.bind((HOST, 1423))
        SERVER.listen()
        print(f" [+] Server listening on {HOST} on port 1423")

        ''' ACCEPT CONNECTION '''
        CLIENT, ADDR = SERVER.accept()
        print(f" [+] Connection from {ADDR} has been established\n {CLIENT}")
    except Exception as e:
        print(f" [-] Error establishing connection: {e}"
              f" [-] failed to connect to {CLIENT} at {ADDR}...")


    ''' RECEIVE FILENAME AND FILE SIZE
        -> FIRST RECEIVE FILENAME AND FILE SIZE FROM CLIENT
        -> THEN RECEIVE FILE
            -> use <EOF> to indicate end of file transmission 
    '''
    try:
        ''' RECEIVE FILENAME AND FILE SIZE '''
        filename, file_size = CLIENT.recv(1024).decode().split()
        file_size = int(file_size)
        progress = tqdm.tqdm(range(file_size), f"Receiving {filename}", unit="B", unit_scale=True, unit_divisor=1024)
        print(f" [+] Receiving {filename} with size {size(file_size)} ")

        ''' RECEIVE FILE
            -> FILEBYTES IS A BYTES STRING THAT IS EMPTY
            -> USE <EOF> TO INDICATE END OF FILE TRANSMISSION
            -> THE LOOP WILL USE 'DATA' TO READ THE FILE IN CHUNKS OF 1024 BYTES
            -> THE THE CONDITION IS CHECKED AGAINST <EOF> TO BREAK THE LOOP
            -> FINALLY, THE DATA IS WRITTEN TO FILE_BYTES
        '''


        file = open(filename, 'wb') # INITS RECEIVING FILE, THEN GETS WRITTEN TO AFTER DOWNLOAD
        file_bytes = b'' # GETS ENCRYPTED INFO WRITTEN TO DURING DOWNLOAD
        while True:
            data = CLIENT.recv(1024) # INITIALIZE DATA
            if data == b"<EOF>": # CHECK IF DATA IS <EOF>
                break
            file_bytes += data
            progress.update(1024)

        print(f" [+] File received successfully,\n [+] Saved to {os.getcwd()}\n [+] {filename} \n [+] {size(file_size)} bytes")
        file.write(CIPHER.decrypt(file_bytes))
    except Exception as e:
        print(f" [-] Error receiving file: \n{e}")



''' ASK USER IF THEY WANT TO SEND OR RECEIVE MESSAGE 
    -> IF SEND, CALL 
        -> CALL take_user_input()
        -> THEN GENERATE RSA KEYS
    -> THIS WILL THEN CALL send_encrypted_message()
    -> IF RECEIVE, CALL receive_encrypted_message()
'''


def main():
    menu = [
        "Hello, welcome to the RSA Encryption App",
        "What would you like to do?",
        "1. Send Encrypted Message",
        "2. Receive Encrypted Message",
        "3. Exit"
    ]

    for user_input in menu:
        print(f" [+] {user_input}")

    user_input = input(" [+] Enter your choice: ")

    if user_input == '1':
        take_user_input()

    elif user_input == '2':
        receivingThread = threading.Thread(target=receive_encrypted_message())
        receivingThread.start()

    elif user_input == '3':
        print(" [+] Exiting RSA Encryption App")
        exit(0)
    else:
        print(" [+] Invalid choice. Please try again")
        main()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
