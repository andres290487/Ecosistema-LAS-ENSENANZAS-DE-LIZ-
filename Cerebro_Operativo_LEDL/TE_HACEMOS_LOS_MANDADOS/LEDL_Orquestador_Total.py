from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os, subprocess, threading, time

app = Flask(__name__, static_folder='.')
DB_PATH = os.path.expanduser('~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/ledl_logistica.db')
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{DB_PATH}'
db = SQLAlchemy(app)

class Pedido(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    cliente = db.Column(db.String(100))
    estado = db.Column(db.String(20), default='pendiente')

def auditor_preventivo():
    while True:
        with app.app_context():
            db.session.execute(db.text("DELETE FROM pedido WHERE estado = 'entregado' AND rowid NOT IN (SELECT rowid FROM pedido ORDER BY rowid DESC LIMIT 50)"))
            db.session.commit()
        time.sleep(3600) # Auditoría cada hora

@app.route('/')
def index(): return send_from_directory('.', 'index.html')

@app.route('/api/pedidos', methods=['GET', 'POST'])
def gestionar():
    if request.method == 'POST':
        p = Pedido(cliente=request.json['cliente'])
        db.session.add(p); db.session.commit()
        return jsonify({"id": p.id})
    return jsonify([{"id": p.id, "cliente": p.cliente, "estado": p.estado} for p in Pedido.query.all()])

@app.route('/api/confirmar/<int:id>', methods=['POST'])
def confirmar(id):
    p = Pedido.query.get(id)
    if p: p.estado = 'entregado'; db.session.commit()
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    with app.app_context(): db.create_all()
    threading.Thread(target=auditor_preventivo, daemon=True).start()
    app.run(port=5000, host='0.0.0.0')
