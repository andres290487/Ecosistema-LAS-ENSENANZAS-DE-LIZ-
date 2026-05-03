#!/bin/bash

# ==========================================
# 🚀 LEDL AUTO ORQUESTADOR TOTAL v1.0
# TE HACEMOS LOS MANDADOS - AUTODEPLOY CORE
# ==========================================

set -e

echo "=========================================="
echo "🚀 INICIANDO ORQUESTADOR TOTAL LEDL"
echo "=========================================="

BASE_DIR=$(pwd)

echo "📁 Directorio actual: $BASE_DIR"

# ==========================================
# 1. CREAR ESTRUCTURA CRÍTICA FALTANTE
# ==========================================

echo "📦 Creando archivos base..."

# .env
if [ ! -f ".env" ]; then
cat > .env <<EOF
PORT=3000
NODE_ENV=development

DB_HOST=localhost
DB_PORT=5432
DB_NAME=ledl_mandados
DB_USER=postgres
DB_PASSWORD=postgres

JWT_SECRET=change_this_secret

MERCADOPAGO_ACCESS_TOKEN=
MERCADOPAGO_PUBLIC_KEY=
GOOGLE_MAPS_API_KEY=
EOF
echo "✔ .env creado"
fi

# .gitignore
cat > .gitignore <<EOF
node_modules/
.env
*.log
__pycache__/
*.pyc
.DS_Store
EOF

echo "✔ .gitignore listo"

# README
cat > README.md <<EOF
# TE HACEMOS LOS MANDADOS

Sistema full-stack de logística y mandados.

STACK:
- Node.js + Express
- Socket.io
- Python Orquestador
- PostgreSQL

AUTO-GENERADO POR LEDL ORQUESTADOR
EOF

echo "✔ README.md listo"

# ecosystem PM2
cat > ecosystem.config.js <<EOF
module.exports = {
  apps: [
    {
      name: "mandados-node",
      script: "server.js",
      env: {
        NODE_ENV: "production",
        PORT: 3000
      }
    },
    {
      name: "mandados-python",
      script: "ORQUESTADOR_LEDL_PRO.py",
      interpreter: "python3"
    }
  ]
};
EOF

echo "✔ ecosystem.config.js listo"

# ==========================================
# 2. FIX NODE DEPENDENCIAS
# ==========================================

echo "📦 Instalando dependencias Node..."

if [ -f "package.json" ]; then
  npm install || true
else
cat > package.json <<EOF
{
  "name": "te-hacemos-los-mandados",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "socket.io": "^4.7.2",
    "dotenv": "^16.3.1",
    "cors": "^2.8.5"
  }
}
EOF
npm install
fi

echo "✔ Node listo"

# ==========================================
# 3. PYTHON ENV SETUP
# ==========================================

echo "🐍 Configurando entorno Python..."

if [ ! -d "venv" ]; then
  python3 -m venv venv || true
fi

source venv/bin/activate || true

pip install --upgrade pip || true

if [ -f "requirements.txt" ]; then
  pip install -r requirements.txt || true
else
cat > requirements.txt <<EOF
flask
requests
psycopg2-binary
python-dotenv
EOF
pip install -r requirements.txt || true
fi

echo "✔ Python listo"

# ==========================================
# 4. PARCHE SERVER.JS (BÁSICO SAFE MODE)
# ==========================================

if grep -q "process.env" server.js 2>/dev/null; then
  echo "✔ server.js ya usa env"
else
  echo "⚠ Recomendación: agregar dotenv manual en server.js"
fi

# ==========================================
# 5. VALIDACIÓN FINAL
# ==========================================

echo "🔍 Validando sistema..."

FILES=("server.js" "ORQUESTADOR_LEDL_PRO.py")

for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    echo "✔ $f OK"
  else
    echo "⚠ FALTA: $f"
  fi
done

# ==========================================
# 6. INSTRUCCIONES FINALES
# ==========================================

echo "=========================================="
echo "🚀 SISTEMA LISTO PARA SIGUIENTE FASE"
echo "=========================================="
echo ""
echo "SIGUIENTE PASO:"
echo "1. npm start"
echo "2. o pm2 start ecosystem.config.js"
echo "3. o deploy en Railway"
echo ""
echo "RECOMENDADO:"
echo "- Subir a GitHub"
echo "- Conectar a Railway"
echo "- Agregar PostgreSQL cloud"
echo "=========================================="
