#!/bin/bash
# Prueba de estrés para Cerebro Operativo LEDL
SERVER_URL="http://localhost:8080" # Ajusta al puerto de tu server.py
CONCURRENCY=50
TOTAL_REQUESTS=200

echo "=== Iniciando Estrés Test: EnsDeLiz® Preventiva ==="
echo "Enviando $TOTAL_REQUESTS peticiones con $CONCURRENCY de concurrencia..."

# Ejecutar test de carga usando ab (Apache Benchmark) si está disponible, sino simulado
if command -v ab >/dev/null 2>&1; then
    ab -n $TOTAL_REQUESTS -c $CONCURRENCY $SERVER_URL/
else
    echo "Benchmark no disponible, simulando carga de CPU/Memoria..."
    for i in {1..10}; do
        (dd if=/dev/zero of=/dev/null bs=1M count=1000 &)
    done
    sleep 5
    echo "Carga de estrés aplicada."
fi

echo "=== Prueba finalizada ==="
