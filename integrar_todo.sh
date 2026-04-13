#!/bin/bash
# Orquestador: Integración Masiva de Submódulos para EnsDeLiz®
# Autor: J Andres Resendez R.

cd ~/Main_LEDL
echo "[*] Iniciando integración masiva en $(pwd)"

# Lista de repositorios a integrar (obtenida de tu overview)
REPOS=("Androl4b" "EAVI" "EAVI-LEDL" "EAVI-LEDL-ALL" "EIPs" "Ecosistema-LAS-ENSENANZAS-DE-LIZ-" "Hugo" "LEDL_OS-termux.github.io" "activos" "base" "blokada" "brew" "changelog.com" "choosealicense.com" "devguide" "docs" "docs-1" "dogecoin" "estadocuentaweb" "estadocuentaweb-" "git-credential-manager" "idmanagement.gov" "langgraph" "las-ensenanzas-de-liz.github.io" "libreta-de-direcciones-AAVE" "mis-archivos-publicos" "netifaces" "plantilla-de-panel-de-control-del-gdp")

for REPO in "${REPOS[@]}"; do
    if [ ! -d "modules/$REPO" ]; then
        echo "[+] Integrando: $REPO"
        # Usamos el alias de la cuenta 290487 porque la mayoría están allí
        git submodule add git@github-290487:andres290487/$REPO.git modules/$REPO
    else
        echo "[!] Ya existe: $REPO, saltando..."
    fi
done

echo "[+] Integración finalizada. Consolidando..."
git add .
git commit -m "Arquitectura: Consolidación masiva de Ecosistema LEDL en Monorepo"
git push -u origin main
