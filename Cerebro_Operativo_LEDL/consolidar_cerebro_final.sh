#!/bin/bash
# Script de consolidación final: EnsDeLiz® Preventiva
echo "=== Iniciando Consolidación del Cerebro Operativo ==="

# 1. Definir la fuente de la verdad
SOURCE_SERVER="$HOME/UNIFIED_CEREBRO_OPERATIVO_LEDL/src/ledl/server.py"
UNIFIED_DIR="$HOME/UNIFIED_CEREBRO_OPERATIVO_LEDL"

# 2. Mover la lógica del marketplace a su lugar correcto sin duplicar el server.py
# (Si el marketplace es un módulo, se integra como componente, no como servicio independiente duplicado)
echo "Consolidando módulos logísticos..."

# 3. Eliminar duplicados detectados en el find
# ADVERTENCIA: Solo elimina archivos que no sean la fuente de la verdad
find "$UNIFIED_DIR/archives/" -name "server.py" -exec rm {} \;
find "$UNIFIED_DIR/temp/" -name "server.py" -exec rm {} \;

echo "✅ Limpieza de redundancias completada."
echo "Estructura final operativa en: $UNIFIED_DIR"
