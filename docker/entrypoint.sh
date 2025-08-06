#!/bin/bash
set -e

# Generar claves híbridas (stub) y exportar variables
eval "$(python3 pqc/generate_keys.py)"

# Cifrar la flag y exportar ENCRYPTED_FLAG
eval "$(python3 pqc/encrypt_flag.py)"

# Arrancar Anvil
anvil --host 0.0.0.0 \
      --accounts 10 \
      --balance 10000000000000000000 \
      --mnemonic "test test test test test test test test test test test junk" &

sleep 3

# Desplegar contrato
forge script script/Deploy.s.sol \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    --broadcast

# Mantener vivo
tail -f /dev/null











