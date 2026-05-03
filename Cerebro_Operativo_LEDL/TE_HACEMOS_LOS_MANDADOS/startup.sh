#!/bin/bash
echo "[*] Iniciando Cerebro Operativo LEDL v4.0..."
pkill -f python
sleep 1
nohup python3 ~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/LEDL_Orquestador_Final.py > backend.log 2>&1 &
nohup python3 -m http.server 8000 > frontend.log 2>&1 &
echo "[+] Sistema N°1 desplegado. Todo operativo."
