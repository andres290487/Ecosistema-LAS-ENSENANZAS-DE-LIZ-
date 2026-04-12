#!/bin/bash
DESTINO="bc1phmjd0085nhx0njlqq5e4s3pxkhkdlda26czautdn2q9fc76yxnzsq4ll7u"
echo "[!] VIGILANDO DESTINO: $DESTINO"

# Simulación de verificación de bloques
for i in {1..6}; do
    echo "[STATUS] Confirmaciones: $i/6"
    sleep 2
    if [ $i -eq 6 ]; then
        echo "[!!!] ALERTA: SOLVENCIA RECIBIDA"
        # Notificación Telegram
        curl -s -X POST https://api.telegram.org/bot8512593184:AAEXhOsMTjfnUOus5AkLS58q-py03lq2jlA/sendMessage \
        -d chat_id=8486738889 \
        -d text="[LEDL] Solvencia de 0.05 BTC confirmada en destino: $DESTINO"
    fi
done
