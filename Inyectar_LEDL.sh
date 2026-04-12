#!/bin/bash
# Orquestador: Inyección Corregida - EnsDeLiz®

cd /data/data/com.termux/files/home/
DEST="Main_LEDL/Cerebro_Operativo_LEDL"
mkdir -p "$DEST"

echo "[*] Iniciando migración de archivos raíz a Main_LEDL..."

# Mover y copiar los archivos identificados
cp -rf .cerebro_ledl .ssh .termux *.sh *.py *.txt *.log *.zip *.mp4 manifest.sha256 swapfile "$DEST/" 2>/dev/null

echo "[+] Migración completada al contenedor de integración."
