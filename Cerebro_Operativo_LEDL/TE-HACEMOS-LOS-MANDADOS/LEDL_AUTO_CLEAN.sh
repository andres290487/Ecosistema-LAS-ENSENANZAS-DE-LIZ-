#!/bin/bash

echo "======================================"
echo "🧠 LEDL AUTO CLEAN SYSTEM v1.0"
echo "======================================"

# ======================================
# 1. DETECTAR ARCHIVOS SOSPECHOSOS
# ======================================

echo "🔍 Buscando posibles secretos..."

grep -rEi "ghp_|token|api_key|secret|password|Authorization" . || true

echo "--------------------------------------"

# ======================================
# 2. PROTEGER ARCHIVO PROBLEMÁTICO
# ======================================

if [ -f "INVENTARIO_TOTAL.json" ]; then
    echo "⚠ Detectado INVENTARIO_TOTAL.json"

    # sacar del tracking git
    git rm --cached INVENTARIO_TOTAL.json 2>/dev/null || true

    # mover a carpeta segura
    mkdir -p data
    mv INVENTARIO_TOTAL.json data/

    echo "✔ Movido a /data"
fi

# ======================================
# 3. ACTUALIZAR .GITIGNORE
# ======================================

echo "🧾 Actualizando .gitignore..."

cat >> .gitignore <<EOF

# LEDL AUTO CLEAN
data/
*.secret
*.key
*.env.local
EOF

# ======================================
# 4. LIMPIAR HISTORIAL (SOFT FIX)
# ======================================

echo "🧹 Limpiando staging..."

git add .gitignore
git commit -m "LEDL AUTO CLEAN: remove sensitive data" || true

# ======================================
# 5. OPCIONAL: LIMPIEZA PROFUNDA
# ======================================

echo "⚠ Verificando git-filter-repo..."

if command -v git-filter-repo &> /dev/null
then
    echo "✔ Usando git-filter-repo (modo PRO)"

    git filter-repo --path data/INVENTARIO_TOTAL.json --invert-paths
else
    echo "ℹ git-filter-repo no instalado"
    echo "👉 Si quieres limpieza total del historial instala:"
    echo "pip install git-filter-repo"
fi

# ======================================
# 6. FINALIZAR
# ======================================

echo "======================================"
echo "🚀 LIMPIEZA COMPLETADA"
echo "======================================"
echo "SIGUIENTE PASO:"
echo "git push -u origin main --force"
echo "======================================"
