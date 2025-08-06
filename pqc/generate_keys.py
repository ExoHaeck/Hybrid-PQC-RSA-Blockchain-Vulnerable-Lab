#!/usr/bin/env python3
import os, base64
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP

# 1) Secreto aleatorio (será la "clave compartida")
secret = os.urandom(32)

# 2) Simulamos KEM PQC exponiendo el secreto como "public key"
pqc_pub = secret

# 3) Generar RSA solo para el lab (no usado en exploit)
rsa_key = RSA.generate(2048)
rsa_pub = rsa_key.publickey().export_key()
rsa_priv = rsa_key.export_key()

# 4) Encapsular secreto con RSA (no hace falta para el exploit)
rsa_cipher = PKCS1_OAEP.new(RSA.import_key(rsa_pub))
ct_rsa = rsa_cipher.encrypt(secret)

# 5) Imprimir exports (base64) para entrypoint.sh
print(f"export PQC_PUBLIC_KEY='{base64.b64encode(pqc_pub).decode()}'")
print(f"export RSA_PUBLIC_KEY='{base64.b64encode(rsa_pub).decode()}'")

# 6) Guardar el secreto y RSA priv para debugging interno
with open("pqc/kyber_priv.key", "wb") as f: f.write(secret)
with open("pqc/rsa_priv.pem", "wb") as f: f.write(rsa_priv)

