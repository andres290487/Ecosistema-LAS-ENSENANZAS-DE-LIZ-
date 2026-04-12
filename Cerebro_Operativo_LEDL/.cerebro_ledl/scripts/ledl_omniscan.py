import os
import requests

# CONFIGURACIÓN DEL BARRIDO
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
TARGET_REPOS = ["Cerebro_Operativo_LEDL", "THM_SAAS_CLUSTER"] # Nodos identificados

print(f"[LEDL-OMNISCAN] Iniciando auditoría en la nube...")

def scan_repo(repo_name):
    # Escaneo de secretos en variables de entorno de despliegue (via API de GitHub)
    url = f"https://api.github.com/repos/JAndresResendez/{repo_name}/actions/secrets"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        secrets = response.json().get('secrets', [])
        for s in secrets:
            print(f"[FOUND] Secreto detectado en {repo_name}: {s['name']}")
    else:
        print(f"[WARN] No se pudo acceder a {repo_name} (Status: {response.status_code})")

# Ejecución del barrido
for repo in TARGET_REPOS:
    scan_repo(repo)

print("[LEDL-OMNISCAN] Barrido de almacenamiento Cloud finalizado.")
