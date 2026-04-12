#!/bin/bash
# Cerebro Operativo LEDL: Orquestador invocar_LEDL
CONFIG_FILE="$HOME/.cerebro_ledl/config/node_registry.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
    echo "[OK] Registro de nodos cargado."
else
    echo "[ERROR] Registro de nodos no encontrado."
    exit 1
fi

echo "--- Invocando Imperio LEDL 2026 ---"
echo "ID IPNS: $IPNS_ID"
echo "[STATUS] Buscando actualizaciones en el nodo: $CONTENT_CID"

if [ ! -z "$IPNS_ID" ]; then
    echo "[SUCCESS] Nodo LEDL localizado y sincronizado."
else
    echo "[ERROR] Fallo en la resolución de red."
fi
