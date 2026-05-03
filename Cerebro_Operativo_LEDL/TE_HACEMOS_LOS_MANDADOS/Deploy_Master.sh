#!/bin/bash
BASE_DIR="$HOME/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS"

echo "[*] INICIANDO SECUENCIA LEDL..."

# Paso 1: Init System
python3 "$BASE_DIR/Init_System.py"
if [ $? -eq 0 ]; then
    echo "[##########----------] 25% - Nodos OK"
else
    echo "[!] FALLA EN NODOS. Iniciando MODO MANTENIMIENTO (2)..."
    python3 "$BASE_DIR/Dispatcher_Interface.py" 2
    exit 1
fi

# Paso 2: Interfaz Real
python3 "$BASE_DIR/Dispatcher_Interface.py" 1
