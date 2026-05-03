# backend/main.py
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from pydantic import BaseModel
from typing import List, Dict

app = FastAPI()

# Modelo de Envío (Punto 1 de tu lista)
class Envio(BaseModel):
    id: int
    codigo: str
    estado: str # pendiente, asignado, en_ruta, entregado

# Diccionario de sockets activos para tracking (Punto 5 y 14)
active_sockets: Dict[str, List[WebSocket]] = {}

@app.post("/api/v1/pedidos")
async def crear_pedido(envio: Envio):
    # Lógica de base de datos aquí
    return {"status": "creado", "id": envio.id}

@app.websocket("/ws/tracking/{id_envio}")
async def tracking_websocket(websocket: WebSocket, id_envio: str):
    await websocket.accept()
    if id_envio not in active_sockets: active_sockets[id_envio] = []
    active_sockets[id_envio].append(websocket)
    try:
        while True:
            data = await websocket.receive_json()
            # Reenviar ubicación a los clientes que escuchan este envío
            for client in active_sockets.get(id_envio, []):
                await client.send_json(data)
    except WebSocketDisconnect:
        active_sockets[id_envio].remove(websocket)
