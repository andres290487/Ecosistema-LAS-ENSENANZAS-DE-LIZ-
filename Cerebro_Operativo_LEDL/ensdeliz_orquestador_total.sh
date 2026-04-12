#!/bin/bash

echo "🧠 ENSDELIZ IA PROTECCIÓN TOTAL + ALERTAS"
echo "========================================="

# =========================
# CONFIGURACIÓN USUARIO
# =========================
read -p "📡 IP DVR (ej: 192.168.0.108): " DVR_IP
read -p "👤 Usuario DVR: " DVR_USER
read -p "🔐 Password DVR: " DVR_PASS

read -p "🤖 TOKEN Telegram: " TG_TOKEN
read -p "📲 CHAT ID Telegram: " TG_CHAT

BASE="$HOME/ensdeliz_system"
SCRIPT="$BASE/ia.py"

mkdir -p "$BASE"
cd "$BASE"

# =========================
# INSTALACIÓN AUTOMÁTICA
# =========================
echo "📦 Instalando dependencias..."

pkg update -y
pkg install -y python ffmpeg git

pip install --upgrade pip
pip install ultralytics opencv-python-headless numpy requests

# =========================
# CREAR SCRIPT IA
# =========================
echo "🧠 Generando motor IA..."

cat > $SCRIPT <<EOF
import cv2
import subprocess
import time
import requests
from ultralytics import YOLO

# =========================
# CONFIG
# =========================
RTSP_CAM1 = "rtsp://$DVR_USER:$DVR_PASS@$DVR_IP:554/cam/realmonitor?channel=1&subtype=0"
RTSP_CAM2 = "rtsp://$DVR_USER:$DVR_PASS@$DVR_IP:554/cam/realmonitor?channel=2&subtype=0"

TOKEN = "$TG_TOKEN"
CHAT_ID = "$TG_CHAT"

model = YOLO("yolov8n.pt")

ZONA_MOTO = (520, 250, 820, 950)
ZONA_PUERTA = (900, 250, 1200, 900)

def dentro_zona(x, y, zona):
    x1, y1, x2, y2 = zona
    return x1 < x < x2 and y1 < y < y2

def enviar_alerta(msg, file=None):
    requests.post(f"https://api.telegram.org/bot{TOKEN}/sendMessage",
                  data={"chat_id": CHAT_ID, "text": msg})

    if file:
        with open(file, "rb") as f:
            requests.post(f"https://api.telegram.org/bot{TOKEN}/sendVideo",
                          files={"video": f},
                          data={"chat_id": CHAT_ID})

def grabar(rtsp, nombre):
    archivo = f"alerta_{nombre}_{int(time.time())}.mp4"

    subprocess.run([
        "ffmpeg","-y","-i",rtsp,"-t","10","-vcodec","copy",archivo
    ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    enviar_alerta(f"🚨 Intruso detectado en {nombre}", archivo)

def analizar(rtsp, zona, nombre):
    cap = cv2.VideoCapture(rtsp)
    detecciones = 0

    while True:
        ret, frame = cap.read()
        if not ret:
            time.sleep(1)
            continue

        results = model(frame, verbose=False)

        for r in results:
            for box in r.boxes:
                cls = int(box.cls[0])

                if cls == 0 and box.conf[0] > 0.6:
                    x1, y1, x2, y2 = map(int, box.xyxy[0])

                    ancho = x2 - x1
                    alto = y2 - y1

                    if ancho < 50 or alto < 100:
                        continue

                    cx = (x1 + x2)//2
                    cy = (y1 + y2)//2

                    if dentro_zona(cx, cy, zona):
                        detecciones += 1

                        if detecciones >= 3:
                            grabar(rtsp, nombre)
                            detecciones = 0
                            time.sleep(20)

# =========================
# RUN
# =========================
import threading

t1 = threading.Thread(target=analizar, args=(RTSP_CAM1, ZONA_MOTO, "MOTO"))
t2 = threading.Thread(target=analizar, args=(RTSP_CAM2, ZONA_PUERTA, "PUERTA"))

t1.start()
t2.start()

t1.join()
t2.join()
EOF

# =========================
# EJECUCIÓN
# =========================
echo "🚀 Iniciando sistema inteligente..."
python $SCRIPT
