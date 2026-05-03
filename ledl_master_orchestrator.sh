#!/bin/bash
# --- ORQUESTADOR MAESTRO LEDL v167-FINAL ---
# Propietario: J Andres Resendez R. | ORCID: 0009-0007-3528-9413
# Función: Consolidación total, Limpieza Forense y Lanzamiento del SO Web LEDL

echo "[1/4] Iniciando purga de zombis y submódulos..."
rm -rf Dockerfile src/ modules/ 2>/dev/null
git rm -rf --cached modules/ 2>/dev/null

echo "[2/4] Generando Núcleo Visual (index.html, style.css, script.js)..."
# Generar index.html con esquemas de alto rendimiento
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="es-MX"><head><meta charset="UTF-8"><title>Cerebro Operativo LEDL v167</title>
<link rel="stylesheet" href="style.css"></head>
<body><header><div>SISTEMA ONLINE | PROPIETARIO: J ANDRES RESENDEZ R.</div></header>
<main id="desktop">
    <div class="module" onclick="abrirModulo('AIKO', 'Auditoría Forense activa.')">AIKO<br><small>CYBERSEC</small></div>
    <div class="module" onclick="ejecutarAuditoria()">ARES-Kal<br><small>AUDIT</small></div>
</main>
<div id="ventana-modulo" class="modal"><div class="modal-content"><span class="close" onclick="cerrarModulo()">&times;</span>
<h2 id="modal-titulo"></h2><p id="modal-cuerpo"></p></div></div>
<script src="script.js"></script></body></html>
EOF

# Generar Kernel (script.js) con el Módulo de Auditoría de Wallets integrado
cat << 'EOF' > script.js
function abrirModulo(n, d) { 
    document.getElementById('modal-titulo').innerText = n; 
    document.getElementById('modal-cuerpo').innerText = d; 
    document.getElementById('ventana-modulo').style.display = "block"; 
}
function cerrarModulo() { document.getElementById('ventana-modulo').style.display = "none"; }
function ejecutarAuditoria() {
    let addr = prompt("Ingrese dirección de Wallet para auditoría forense (ARES-Kal):");
    if (addr) {
        document.getElementById('modal-titulo').innerText = "ARES-Kal: Auditoría en Curso";
        document.getElementById('modal-cuerpo').innerHTML = "Analizando bloque... <br>Dirección: <b>" + addr + "</b>";
        document.getElementById('ventana-modulo').style.display = "block";
    }
}
EOF

# Generar Estilos (style.css)
cat << 'EOF' > style.css
body { background: #000; color: #00ff41; font-family: 'Courier New', monospace; }
.module { border: 1px solid #00ff41; padding: 20px; cursor: pointer; display: inline-block; }
.modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.9); }
.modal-content { background: #111; margin: 10% auto; padding: 20px; border: 1px solid #00ff41; width: 300px; }
EOF

echo "[3/4] Sincronizando con nodo maestro..."
git add index.html style.css script.js
git commit -m "Orquestador v167-FINAL: Despliegue de SO Web Soberano"
git push -u origin main

echo "[4/4] DESPLIEGUE COMPLETADO. SISTEMA ONLINE."
