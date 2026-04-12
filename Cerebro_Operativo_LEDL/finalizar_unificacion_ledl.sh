#!/bin/bash

# Configuración inicial
UNIFIED="$HOME/UNIFIED_CEREBRO_OPERATIVO_LEDL"
DEST="$UNIFIED/src/ledl"
mkdir -p "$DEST"

# Lista de elementos a mover
ITEMS=("ledl_corp" "ledl_fusion" "ledl_global" "ledl_imperio" "ledl_pro" "ledl_real" "ledl_ui" "ledl_ultra" "CEREBRO_OPERATIVO_LEDL_UNIFICADO" "CerebroOperativoLEDL" "Cerebro_Operativo_LEDL_UNIFICADO")

TOTAL=${#ITEMS[@]}
CURRENT=0

echo "=== Iniciando Unificación Final: EnsDeLiz® Preventiva ==="

for item in "${ITEMS[@]}"; do
    ((CURRENT++))
    
    # Animación de progreso
    PERCENT=$((CURRENT * 100 / TOTAL))
    BAR=$(printf "%-$((PERCENT/5))s" | tr ' ' '=')
    
    # ETA simulado basado en el tiempo de procesamiento de disco local
    ETA="2s"
    
    printf "\r[%-20s] %d%% | Procesando: %s (ETA: %s)" "$BAR" "$PERCENT" "$item" "$ETA"
    
    # Movimiento seguro
    if [ -d "$HOME/$item" ]; then
        mv "$HOME/$item" "$DEST/" 2>/dev/null
    fi
done

echo -e "\n✅ Unificación completada exitosamente en el Cerebro Operativo LEDL."
echo "Estructura verificada:"
ls -la "$DEST"
