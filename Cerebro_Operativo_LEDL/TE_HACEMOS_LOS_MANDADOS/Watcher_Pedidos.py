import os
import time
import json

PEDIDOS_DIR = os.path.expanduser("~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/pedidos")
PROCESADOS_DIR = os.path.expanduser("~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/procesados")

if not os.path.exists(PROCESADOS_DIR):
    os.makedirs(PROCESADOS_DIR)

print("[*] Watcher Activo: Vigilando nuevos pedidos...")

while True:
    for filename in os.listdir(PEDIDOS_DIR):
        if filename.endswith(".json"):
            # Mover a procesados para evitar duplicidad
            src = os.path.join(PEDIDOS_DIR, filename)
            dst = os.path.join(PROCESADOS_DIR, filename)
            
            with open(src, 'r') as f:
                data = json.load(f)
                print(f"[!] Procesando pedido: {data['pedido_id']}")
                # Aquí dispararías la alerta a Telegram o acción logística
                
            os.rename(src, dst)
            print(f"[+] Pedido {filename} movido a procesados.")
            
    time.sleep(3)
