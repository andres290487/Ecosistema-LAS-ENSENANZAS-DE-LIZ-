#!/bin/bash
# Proyecto: Cerebro Operativo LEDL - Registro de Orden de Salida
# Autor: J Andres Resendez R. (ORCID: 0009-0007-3528-9413)

DESTINO="115CoJyJyQ3FsjNVjVyjRheJAZK869UUkP"
ORDEN_FILE="$HOME/.cerebro_ledl/pending_tx.log"

echo "--- Generación de Orden de Transferencia ---"
read -p "Ingrese el monto a transferir (BTC): " MONTO

if [[ -z "$MONTO" ]]; then
    echo "[ERROR] Monto inválido. Operación cancelada."
    exit 1
fi

# Registro de la solicitud con timestamp y destino
echo "$(date): DESTINO=$DESTINO | MONTO=$MONTO | STATUS=PENDIENTE_FIRMA" > "$ORDEN_FILE"

echo "[OK] Orden registrada exitosamente."
echo "[INFO] Archivo de orden creado en: $ORDEN_FILE"
echo "[!] IMPORTANTE: Ahora debes realizar la firma con tu Llave Maestra (ARES-Kal)."
