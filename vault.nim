# Must install a dependency:
#    nimble install https://github.com/xxtea/xxtea-nim.git

import os
import system
import strutils
import terminal 

import xxtea

const FILENAME = "passwords.txt"
const USAGE = """Encrypt and decrypt a file using a password.

Usage: 
    vault open [file]
    vault close [file]

Default file:
    passwords.txt    

WARNING: this program may overwrite or delete file content without 
a possibilty of recovery. Passwords cannot be recovered. Information 
can be destroyed by repeated attempts of encryption/decryption. Use 
at you own risk. 
"""

# passwords

proc getpass(message: string = "Password: "): string =
   return terminal.readPasswordFromStdin(message)

proc getpass2(): string =
    let key = getpass()
    let key2 = getpass("Repeat password: ") 
    if key == key2:
        return key    
    else: 
        quitWithMessage("Passwords do not match")

# file handling

proc read(): string = 
    return readFile(filepath())

proc write(content: string): void =
    writeFile(filepath(), content)

# console messages

proc notify(message: string): void =
    echo message, " ", filepath()

proc quitWithMessage(message: string): void =
    echo message
    quit(1)

# cli args helpers

proc filepath(): string =
    try:
       return paramStr(2)
    except IndexError: 
       return FILENAME

proc command(): string = 
    try:
       return paramStr(1).toLowerAscii()
    except IndexError: 
       quitWithMessage(USAGE)

# main

if command() notin ["open", "close"]:
    quitWithMessage(USAGE)   

let existingContent = read()
case command()    
    of "open":        
        let key = getpass()
        notify("Decoding")
        let newContent = xxtea.decrypt(existingContent, key)
    of "close":
        let key = getpass2()
        notify("Encoding")
        let newContent = xxtea.encrypt(existingContent, key)
write(newContent)
notify("Finished processing")
