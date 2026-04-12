#!/bin/bash
# Orquestador: Consolidación Omni-Dir LEDL - EnsDeLiz®
# Autor: J Andres Resendez R.

DEST="/data/data/com.termux/files/home/Main_LEDL/Cerebro_Operativo_LEDL"
mkdir -p "$DEST"

echo "[*] Iniciando unificación total del Cerebro Operativo..."

# Lista de elementos a consolidar
ITEMS=(.cerebro_ledl .ssh .termux *.sh *.py *.txt *.log *.zip *.mp4 manifest.sha256 swapfile)

total=${#ITEMS[@]}
count=0

for item in "${ITEMS[@]}"; do
    count=$((count+1))
    cp -rf "$item" "$DEST/"
    porcentaje=$((count * 100 / total))
    echo "Progreso: [$porcentaje%] Unificando: $item"
done

echo "[+] Consolidación terminada. Todo el Cerebro Operativo reside en $DEST"
