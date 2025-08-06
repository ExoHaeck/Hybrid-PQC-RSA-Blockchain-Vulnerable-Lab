#!/usr/bin/env python3
import base64
from Crypto.Cipher import AES
from hashlib import sha256
import os

# 1) Leer secreto (privado) generado antes
secret = open("pqc/kyber_priv.key", "rb").read()

# 2) Derivar clave simétrica
key = sha256(secret).digest()

# 3) Cifrar flag con AES-GCM
data = open("FLAG.txt", "rb").read()
cipher = AES.new(key, AES.MODE_GCM)
nonce = cipher.nonce
ct, tag = cipher.encrypt_and_digest(data)

# 4) Exportar FLAG cifrada como base64 (nonce | tag | ciphertext)
blob = base64.b64encode(nonce + tag + ct).decode()
print(f"export ENCRYPTED_FLAG='{blob}'")

