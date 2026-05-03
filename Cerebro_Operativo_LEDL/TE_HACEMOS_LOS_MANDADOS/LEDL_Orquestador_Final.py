from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import os
import subprocess
from datetime import datetime

app = Flask(__name__)
CORS(app)

DB_PATH = os.path.expanduser('~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/ledl_logistica.db')
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{DB_PATH}'
db = SQLAlchemy(app)
TOKEN_SEGURO = "TOKEN_SEGURO_LEDL_2026"

class Pedido(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    empresa_id = db.Column(db.String(50), nullable=False)
    cliente = db.Column(db.String(100))
    estado = db.Column(db.String(20), default='pendiente')

def ejecutar_auditoria():
    print("[*] Ejecutando Auditoría Preventiva EnsDeLiz...")
    subprocess.run(["python3", os.path.expanduser("~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/Auditor_AutoSanador.py")])

with app.app_context():
    db.create_all()
    # Ejecución automática al arrancar
    ejecutar_auditoria()

@app.route('/webhook/pedido', methods=['POST'])
def recepcion_A():
    data = request.get_json()
    nuevo = Pedido(empresa_id=data.get('empresa_id', 'general'), cliente=data.get('nombre_cliente', 'Desconocido'))
    db.session.add(nuevo)
    db.session.commit()
    return jsonify({"status": "A_OK", "id": nuevo.id}), 201

@app.route('/api/pedidos/<empresa_id>', methods=['GET'])
def get_lista_pedidos(empresa_id):
    if request.headers.get('X-AIKO-Token') != TOKEN_SEGURO:
        return jsonify({"error": "Acceso Denegado"}), 403
    pedidos = Pedido.query.filter_by(empresa_id=empresa_id).all()
    lista = [{"id": p.id, "cliente": p.cliente, "estado": p.estado} for p in pedidos]
    return jsonify(lista)

if __name__ == "__main__":
    app.run(port=5000, host='0.0.0.0')
