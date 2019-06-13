# vault

Encode and decode a local text file with password.

## Nim version

```
Encrypt and decrypt a file using a password.

Usage: 
    vault open [file]
    vault close [file]

Default file:
    passwords.txt    

WARNING: this program may overwrite or delete file content without 
a possibilty of recovery. Passwords cannot be recovered. Information 
can be destroyed by repeated attempts of encryption/decryption. Use 
at you own risk.   
```

Uses [xxtea](https://github.com/xxtea/xxtea-nim)

[Request for code review](https://codereview.stackexchange.com/questions/222172/file-encoder-decoder-in-nim-lang)

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
