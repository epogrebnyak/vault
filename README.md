# vault

Encode and decode a local text file with password.

## Nim version

```
Encrypt and decrypt text file (default name - passwords.txt).

Usage: 
    vault open [file]
    vault close [file]

WARNING: this program may overwrite or delete file content without 
a possibilty of recovery. Passwords cannot be recovered.   
```
Uses [xxtea](https://github.com/xxtea/xxtea-nim)

## Python version

```
Simple encrypted filestore. 
Use 'open' and 'close' commands to decypt/encrypt file.

Commands:
    python vault.py open [file]
    python vault.py close [file]
    
Default file:
    passwords.txt     

Dependency:    
    pip install simple-crypt
```

Uses [simple-crypt](https://github.com/andrewcooke/simple-crypt)
