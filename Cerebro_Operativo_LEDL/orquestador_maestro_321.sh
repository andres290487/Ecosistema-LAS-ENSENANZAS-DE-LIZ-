#!/bin/bash
# =================================================================
# ORQUESTADOR MAESTRO 3-2-1
# Secuencia: 3 (Watchdog) -> 2 (Frontend) -> 1 (Backend)
# =================================================================

BASE_DIR="$HOME/UNIFIED_CEREBRO_OPERATIVO_LEDL/src/ledl"
WEB_DIR="$HOME/UNIFIED_CEREBRO_OPERATIVO_LEDL/src/ledl/Cerebro_Operativo_LEDL_UNIFICADO/RAMA_LOGISTICA_LOCAL/TE_HACEMOS_LOS_MANDADOS/INTERFACE_VISUAL"

echo "=== [$(date)] Iniciando Secuencia Maestra 3-2-1 ==="

# 3. Lanzar Watchdog (Monitoreo)
(
    while true; do
        if ! pgrep -f "python server.py" > /dev/null; then
            cd "$BASE_DIR" && python server.py > /dev/null 2>&1 &
        fi
        if ! pgrep -f "python -m http.server 8000" > /dev/null; then
            cd "$WEB_DIR" && python -m http.server 8000 > /dev/null 2>&1 &
        fi
        sleep 60
    done
) &
echo "✅ [3] Watchdog Maestro Activo."

# 2. Lanzar Interfaz Frontend
cd "$WEB_DIR" && python -m http.server 8000 > /dev/null 2>&1 &
echo "✅ [2] Interfaz Visual (http://localhost:8000) activa."

# 1. Lanzar Backend API
cd "$BASE_DIR" && python server.py > /dev/null 2>&1 &
echo "✅ [1] Backend API operativo."

echo "=== [EJECUCIÓN FINALIZADA - SISTEMA EN PRODUCCIÓN] ==="
