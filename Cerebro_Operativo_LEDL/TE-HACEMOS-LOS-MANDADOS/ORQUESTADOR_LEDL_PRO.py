import os, sys, threading, time, sqlite3, json
from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__, static_folder='frontend')
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///ledl_produccion.db'
db = SQLAlchemy(app)

# 1. MODELOS DE DATOS (NIVEL PRODUCCIÓN)
class Envios(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(50), unique=True)
    estado = db.Column(db.String(20), default='pendiente')
    cliente = db.Column(db.String(100))

# 2. BARRIDO PROFUNDO Y ORGANIZACIÓN (AUDITORÍA TOTAL)
def barrido_total():
    print(f"\033[96m[NEURAL_SCAN] Iniciando barrido profundo...\033[0m")
    inventario = {}
    for root, dirs, files in os.walk(os.environ.get("HOME", "/")):
        for file in files:
            ext = os.path.splitext(file)[1]
            inventario.setdefault(ext, []).append(os.path.join(root, file))
            # Animación de pulso
            if len(inventario) % 1000 == 0:
                sys.stdout.write(f"\r[PULSO_NEURAL] Escaneando: {file[:30]}")
    with open("INVENTARIO_TOTAL.json", "w") as f: json.dump(inventario, f)
    print("\n[+] Inventario completado.")

# 3. ENDPOINTS API (GESTIÓN LOGÍSTICA)
@app.route('/api/pedidos', methods=['GET', 'POST'])
def gestionar():
    if request.method == 'POST':
        data = request.json
        nuevo = Envios(codigo=data['codigo'], cliente=data['cliente'])
        db.session.add(nuevo); db.session.commit()
        return jsonify({"status": "OK"}), 201
    return jsonify([{"id": e.id, "codigo": e.codigo, "estado": e.estado} for e in Envios.query.all()])

@app.route('/')
def index(): return send_from_directory('frontend', 'index.html')

# 4. EJECUCIÓN MAESTRA
if __name__ == "__main__":
    with app.app_context(): db.create_all()
    threading.Thread(target=barrido_total, daemon=True).start()
    app.run(port=5000, host='0.0.0.0')
