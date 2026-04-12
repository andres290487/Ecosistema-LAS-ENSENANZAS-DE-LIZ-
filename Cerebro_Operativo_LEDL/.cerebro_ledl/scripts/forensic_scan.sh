#!/bin/bash
echo "[FORENSIC] Iniciando barrido profundo..."
# 1. Búsqueda de archivos de billetera
find /data/data/com.termux/files/home/ -type f \( -name "*.key" -o -name "*.json" -o -name "*.dat" \) -exec grep -l "private" {} + 2>/dev/null

# 2. Invocación de IPFS (si el demonio está activo)
echo "[FORENSIC] Consultando nodo IPFS..."
ipfs cat /ipfs/b3c926ea29c3eda3cebabe2e46790393cf7c3ad92d1dfd924f25d7f3c8aeefe2 2>/dev/null || echo "[WARN] Nodo IPFS inaccesible o hash no encontrado."
