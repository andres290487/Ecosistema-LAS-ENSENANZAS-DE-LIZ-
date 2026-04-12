#!/bin/bash
# Proyecto: Cerebro Operativo LEDL - Registro de Activos v1.0
# Autor: J Andres Resendez R. (ORCID: 0009-0007-3528-9413)

REGISTRO="$HOME/.cerebro_ledl/inventario_activos.log"

echo "--- Registro de Nuevo Activo para LEDL ---"
read -p "Nombre del equipo: " EQUIPO
read -p "ID/Serial del equipo: " SERIAL
read -p "Ubicación (NODO): " NODO

echo "$(date): EQUIPO=$EQUIPO | SERIAL=$SERIAL | NODO=$NODO | ORIGEN_FONDOS=SOLVENCIA_0.05BTC" >> "$REGISTRO"

echo "[OK] Activo registrado en el inventario del Cerebro Operativo."
cat "$REGISTRO"
