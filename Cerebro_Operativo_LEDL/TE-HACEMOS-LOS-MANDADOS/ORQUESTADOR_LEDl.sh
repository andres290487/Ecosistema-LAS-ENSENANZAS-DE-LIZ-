#!/bin/bash

echo "💀 LEDL ORQUESTADOR AUTÓNOMO PRO MAX"

# =========================
# CONFIG
# =========================
BASE="$HOME/ledl_system"
LOG="$BASE/ledl.log"
PORT=3000
DB_NAME="ledl"
DB_USER="u0_a274"

mkdir -p "$BASE"
touch "$LOG"

# =========================
# LIMPIEZA
# =========================
echo "🧹 Limpieza total..."
pkill -f node 2>/dev/null
pkill -f postgres 2>/dev/null
sleep 2

# =========================
# INICIAR POSTGRES
# =========================
echo "🧠 Iniciando PostgreSQL..."
pg_ctl -D $PREFIX/var/lib/postgresql start >> "$LOG" 2>&1

sleep 3

pg_isready
if [ $? -ne 0 ]; then
  echo "❌ PostgreSQL no inició" | tee -a "$LOG"
  exit 1
fi

echo "✅ PostgreSQL activo"

# =========================
# CREAR DB Y TABLAS
# =========================
psql postgres <<EOF
CREATE DATABASE $DB_NAME;
\c $DB_NAME;

CREATE TABLE IF NOT EXISTS envios (
    id SERIAL PRIMARY KEY,
    cliente VARCHAR(100),
    destino VARCHAR(100),
    estado VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS repartidores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    estado VARCHAR(50)
);
EOF

# =========================
# DEPENDENCIAS NODE
# =========================
echo "📦 Verificando Node..."
if [ ! -d "node_modules" ]; then
  npm install >> "$LOG" 2>&1
fi

# =========================
# LIBERAR PUERTO
# =========================
if lsof -i:$PORT >/dev/null 2>&1; then
  echo "⚠️ Puerto ocupado → liberando..."
  fuser -k $PORT/tcp
  sleep 2
fi

# =========================
# INICIAR API
# =========================
echo "🚀 Iniciando API..."

PORT=$PORT node server.js >> "$LOG" 2>&1 &
PID_NODE=$!

echo $PID_NODE > "$BASE/node.pid"

sleep 3

# =========================
# VALIDACIÓN INICIAL
# =========================
if ! ps -p $PID_NODE > /dev/null; then
  echo "💀 API no inició correctamente" | tee -a "$LOG"
  tail -n 20 "$LOG"
  exit 1
fi

echo "✅ API activa en http://localhost:$PORT"

# =========================
# WATCHDOG INTELIGENTE
# =========================
INTENTOS=0
MAX_INTENTOS=5

echo "🧠 Vigilancia activa..."

while true; do

  if ! ps -p $PID_NODE > /dev/null; then

    echo "⚠️ API caída → analizando..." | tee -a "$LOG"
    ERROR=$(tail -n 20 "$LOG")

    echo "$ERROR"

    # Evitar loop por puerto
    if echo "$ERROR" | grep -q "EADDRINUSE"; then
      echo "💀 Puerto ocupado detectado. Abortando." | tee -a "$LOG"
      exit 1
    fi

    # Error de export/import
    if echo "$ERROR" | grep -q "does not provide an export"; then
      echo "💀 Error en db.js detectado. Abortando." | tee -a "$LOG"
      exit 1
    fi

    if [ $INTENTOS -ge $MAX_INTENTOS ]; then
      echo "💀 Demasiados reinicios. Sistema detenido." | tee -a "$LOG"
      exit 1
    fi

    echo "🔄 Reiniciando API..." | tee -a "$LOG"
    PORT=$PORT node server.js >> "$LOG" 2>&1 &
    PID_NODE=$!
    ((INTENTOS++))
  fi

  sleep 5
done
