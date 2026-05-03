import json
import uuid
import os

def normalizar_pedido(canal, datos_cliente, contenido):
    # Crea un ID único y un formato estándar para el Cerebro Operativo
    pedido_id = str(uuid.uuid4())[:8]
    pedido = {
        "pedido_id": pedido_id,
        "canal_origen": canal, # WhatsApp, Telegram, o Web
        "cliente": datos_cliente,
        "detalles": contenido,
        "status": "NUEVO"
    }
    
    # Ruta maestra de persistencia
    path = f"{os.environ['HOME']}/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/pedidos/{pedido_id}.json"
    with open(path, 'w') as f:
        json.dump(pedido, f)
    return pedido_id
