import os
import system
import strutils
import terminal 

import xxtea

const FILENAME = "passwords.txt"
const USAGE = """Encrypt and decrypt text file (default name - passwords.txt).

Usage: 
    vault open [file]
    vault close [file]

WARNING: this program may overwrite or delete file content without 
a possibilty of recovery. Passwords cannot be recovered.    
"""

proc quitWithMessage(message: string): void =
    echo message
    quit(1)

proc getpass(message: string = "Password: "): string =
   return terminal.readPasswordFromStdin(message)

proc getpass2(): string =
    let key = getpass()
    let key2 = getpass("Repeat password: ") 
    if key == key2:
        return key    
    else: 
        quitWithMessage("Passwords do not match")

proc filepath(): string =
    if paramCount() == 2:
       return paramStr(2)
    else: 
       return FILENAME

proc command(): string = 
    if paramCount() == 1:
       return paramStr(1).toLowerAscii()
    else:
       quitWithMessage(USAGE)

proc write(content: string): void =
    writeFile(filepath(), content)

proc notify(message: string): void =
    echo message, " ", filepath()
    
# main

if command() notin ["open", "close", "help"]:
    quitWithMessage(USAGE)   

let existingContent = readFile(filepath())

# WARNING: may overwrite or delete file content
case command()    
    of "open":        
        let key = getpass()
        let newContent = xxtea.decrypt(existingContent, key)
        write(newContent)
        notify("Decoded")
    of "close":
        let key = getpass2()
        let newContent = xxtea.encrypt(existingContent, key)
        write(newContent)
        notify("Encoded")
    of "help": 
        quitWithMessage(USAGE)        