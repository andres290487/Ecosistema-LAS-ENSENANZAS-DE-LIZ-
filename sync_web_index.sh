#!/bin/bash
# Orquestador de Sincronización Web - EnsDeLiz®
# Destino: https://ledl-web-repo-1.onrender.com

echo "[*] Iniciando preparación para despliegue web..."

cd ~/Main_LEDL

# 1. Generar un index.html dinámico que sirva como dashboard
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cerebro Operativo LEDL - Index</title>
    <style>
        body { background: #000; color: #0f0; font-family: 'Courier New', monospace; padding: 20px; }
        .header { border-bottom: 2px solid #0f0; padding-bottom: 10px; margin-bottom: 20px; }
        .repo-list { list-style: none; padding: 0; }
        .repo-item { margin: 5px 0; padding: 5px; border: 1px solid #333; }
        a { color: #0f0; text-decoration: none; }
        a:hover { background: #0f0; color: #000; }
        .progress-bar { width: 100%; background: #111; border: 1px solid #0f0; height: 10px; margin: 10px 0; }
        .progress-fill { height: 100%; background: #0f0; width: 0%; transition: width 0.5s; }
    </style>
</head>
<body>
    <div class="header">
        <h1>ENS-DE-LIZ® PREVENTIVA: SISTEMA SUPREMO</h1>
        <p>Director: J Andres Resendez R. | ORCID: 0009-0007-3528-9413</p>
    </div>
    <div class="progress-bar"><div class="progress-fill" id="pb"></div></div>
    <ul class="repo-list" id="list">
        </ul>
    <script>
        const repos = ["EAVI-LEDL", "Androl4b", "estadocuentaweb", "base", "activos"];
        const list = document.getElementById('list');
        const pb = document.getElementById('pb');
        
        repos.forEach((repo, index) => {
            setTimeout(() => {
                const li = document.createElement('li');
                li.className = 'repo-item';
                li.innerHTML = `> Módulo detectado: <a href="modules/${repo}">${repo}</a> [ONLINE]`;
                list.appendChild(li);
                pb.style.width = ((index + 1) / repos.length * 100) + '%';
            }, index * 200);
        });
    </script>
</body>
</html>
EOF

echo "[+] Index dinámico generado."

# 2. Push al repositorio que Render está escuchando
git add index.html
git commit -m "Web: Actualización de interfaz de Index para Render"
git push origin main
