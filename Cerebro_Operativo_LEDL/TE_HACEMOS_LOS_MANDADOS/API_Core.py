from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)
db_path = os.path.expanduser('~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/ledl_logistica.db')
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{db_path}'
db = SQLAlchemy(app)

class Pedido(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    empresa_id = db.Column(db.String(50), nullable=False)
    cliente = db.Column(db.String(100))
    estado = db.Column(db.String(20), default='pendiente')

with app.app_context():
    db.create_all()

# --- FASE 10: AIKO FORENSICS (Blindaje) ---
@app.route('/api/pedidos_seguros/<empresa_id>', methods=['GET'])
def get_pedidos_seguros(empresa_id):
    # Verificación de Token
    token = request.headers.get('X-AIKO-Token')
    if token != "TOKEN_SEGURO_LEDL_2026":
        return jsonify({"status": "ERROR", "message": "Acceso Forense Denegado: Credencial AIKO Requerida"}), 403
    
    pedidos = Pedido.query.filter_by(empresa_id=empresa_id).all()
    return jsonify([{"id": p.id, "cliente": p.cliente, "estado": p.estado} for p in pedidos])

if __name__ == "__main__":
    app.run(port=5000, host='0.0.0.0')
