"""Simple encrypted filestore. 
Use 'open' and 'close' commands to decypt/encrypt file.

Commands:
    python vault.py open [file]
    python vault.py close [file]
    
Default file:
    passwords.txt     

Dependency:    
    pip install simple-crypt
"""

from getpass import getpass
from pathlib import Path 
import sys

from simplecrypt import encrypt, decrypt

DEFAULT_FILENAME = "passwords.txt"

# TODO:
# - isEncypted
# - open notepad in Windows, e3dit on linux

# similar funcitnality in Go 
# https://www.thepolyglotdeveloper.com/2018/02/encrypt-decrypt-data-golang-application-crypto-packages/

def decode(password, ciphertext):
    return decrypt(password, ciphertext).decode('utf8')
    
    
def open(filename: str):
    password = getpass()
    ciphertext = Path(filename).read_bytes()    
    text = decode(password, ciphertext)
    Path(filename).write_text(text)
    print(f"Successfully decrypted {filename}")

    
def close(filename):
    password = double_password()
    plaintext = Path(filename).read_text()
    ciphertext = encrypt(password, plaintext)
    Path(filename).write_bytes(ciphertext)
    print(f"Successfully encrypted {filename}")    
    
    
def assert_exists(filename):    
    if not Path(filename).exists():
       raise FileNotFoundError(filename)       
    
    
def double_password():
    password1 = getpass()
    password2 = getpass("Repeat password:")
    if password1 == password2:
        return password1
    else: 
        raise ValueError("Passwords do not match")    
    
def get_args():    
    try:
        command = sys.argv[1].lower()
    except IndexError:
        sys.exit(__doc__)
    try:        
        filename = sys.argv[2]
    except IndexError:
        filename = DEFAULT_FILENAME
    return command, filename        

    
if __name__ == '__main__':    
    command, filename = get_args()
    if command == 'open':        
        open(filename)
    elif command == 'close':        
        close(filename)
    else:
        print(__doc__)