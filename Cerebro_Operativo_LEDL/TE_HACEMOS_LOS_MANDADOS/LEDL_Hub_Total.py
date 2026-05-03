import os, json, uuid
from flask import Flask, request, jsonify, render_template_string

app = Flask(__name__)
BASE_PATH = os.path.expanduser("~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/pedidos")

# Interfaz visual basada en tu diseño del video
DASHBOARD_HTML = """
<html>
<head>
    <title>Cerebro Operativo LEDL</title>
    <style>
        body { background: #000; color: #0f0; font-family: monospace; padding: 20px; }
        .box { border: 1px solid #0f0; padding: 20px; width: 60%; margin: auto; }
    </style>
</head>
<body>
    <div class="box">
        <h1>CEREBRO OPERATIVO LEDL - TE HACEMOS LOS MANDADOS</h1>
        <hr>
        <p>[ 1 ] ASIGNAR REPARTIDOR | [ 2 ] CONFIRMAR RECOLECCIÓN</p>
        <p>[ 3 ] ESTADO DE PEDIDOS  | [ 4 ] LIQUIDACIÓN RUTA</p>
        <hr>
        <p>STATUS: Nodo Online | Valle del Roble</p>
    </div>
</body>
</html>
"""

@app.route('/')
def index(): return render_template_string(DASHBOARD_HTML)

@app.route('/api/pedido', methods=['POST'])
def api_pedido():
    data = request.get_json(force=True)
    pedido_id = str(uuid.uuid4())[:8]
    with open(os.path.join(BASE_PATH, f"{pedido_id}.json"), 'w') as f:
        json.dump(data, f)
    return jsonify({"status": "SUCCESS", "id": pedido_id})

if __name__ == "__main__":
    app.run(port=5000, debug=False)
