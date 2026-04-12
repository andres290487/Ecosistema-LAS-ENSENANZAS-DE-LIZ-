#!/bin/bash
# Orquestador: Fusión de Nodos en Monorepo - EnsDeLiz®
# Autor: J Andres Resendez R.

# 0% [####################] 100% | ETA: Calculando...
mkdir -p Main_LEDL
cd Main_LEDL
git init
git checkout -b main

# Lista de nodos
NODOS=(.github libreta-de-direcciones-AAVE Androl4b activos blokada brew changelog.com choosealicense.com devguide docs docs-1 dogecoin EAVI EAVI-LEDL EAVI-LEDL-ALL Ecosistema-LAS-ENSENANZAS-DE-LIZ- EIPs estadocuentaweb estadocuentaweb- base plantilla-de-panel-de-control-del-gdp git-credential-manager Hugo idmanagement.gov langgraph las-ensenanzas-de-liz.github.io LEDL_OS-termux.github.io mis-archivos-publicos netifaces)

total=${#NODOS[@]}
count=0

for nodo in "${NODOS[@]}"; do
    count=$((count+1))
    echo "[*] Procesando nodo ($count/$total): $nodo"
    
    # Clonar nodo
    git remote add -f "$nodo" "https://github.com/andres290487/$nodo.git"
    git merge -s ours --no-commit "$nodo/main"
    git read-tree --prefix="$nodo/" -u "$nodo/main"
    git commit -m "Fusión de nodo: $nodo en Main_LEDL"
    
    # Progreso
    porcentaje=$((count * 100 / total))
    echo "Progreso: [$porcentaje%] Completado: $nodo"
done

echo "[+] Fusión finalizada. Estructura consolidada en 'Main_LEDL'."
