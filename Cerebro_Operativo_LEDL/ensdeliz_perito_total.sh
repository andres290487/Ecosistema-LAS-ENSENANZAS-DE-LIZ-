#!/bin/bash

echo "🧠⚖️ ENSDELIZ MODO PERITO TOTAL"
echo "================================"

read -p "📂 Ruta evidencia: " RUTA

BASE="$HOME/ensdeliz_peritaje"
OUT="$BASE/output"
LOG="$OUT/cadena_custodia.txt"
SCRIPT="$BASE/perito.py"

mkdir -p "$OUT"
cd "$BASE"

echo "📦 Instalando dependencias..."
pkg install -y python ffmpeg coreutils
pip install opencv-python-headless numpy ultralytics

echo "🧾 Iniciando cadena de custodia..."
echo "===== CADENA DE CUSTODIA =====" > $LOG
date >> $LOG
echo "Origen: $RUTA" >> $LOG

echo "🧠 Generando motor pericial..."

cat > $SCRIPT <<EOF
import cv2, os, hashlib, subprocess, time
import numpy as np
from ultralytics import YOLO

INPUT = "$RUTA"
OUT = "$OUT"
LOG = "$LOG"

model = YOLO("yolov8n.pt")

def hash_file(file):
    h = hashlib.sha256()
    with open(file,'rb') as f:
        while chunk := f.read(8192):
            h.update(chunk)
    return h.hexdigest()

def registrar(texto):
    with open(LOG,"a") as f:
        f.write(texto + "\\n")

def convertir(video):
    if video.endswith(".dav"):
        nuevo = video.replace(".dav",".mp4")
        subprocess.run(["ffmpeg","-y","-i",video,nuevo],
                       stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
        return nuevo
    return video

def analizar(video):
    cap = cv2.VideoCapture(video)
    ret, prev = cap.read()

    if not ret:
        return

    prev = cv2.cvtColor(prev, cv2.COLOR_BGR2GRAY)

    eventos = []
    inicio = None
    frames = 0
    frame_id = 0

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        diff = cv2.absdiff(prev, gray)
        _, th = cv2.threshold(diff, 25, 255, cv2.THRESH_BINARY)

        movimiento = np.sum(th)/255
        humano = False

        if movimiento > 4000:
            res = model(frame, verbose=False)
            for r in res:
                for box in r.boxes:
                    if int(box.cls[0]) == 0 and box.conf[0] > 0.6:
                        humano = True

        if humano:
            if inicio is None:
                inicio = frame_id
            frames += 1
        else:
            if frames > 15:
                eventos.append((inicio, frame_id))
            inicio = None
            frames = 0

        prev = gray
        frame_id += 1

    cap.release()

    nombre = os.path.basename(video)

    for i,(ini,fin) in enumerate(eventos):
        clip = os.path.join(OUT,f"{nombre}_evento{i}.mp4")

        subprocess.run([
            "ffmpeg","-y","-i",video,
            "-vf",f"select='between(n,{ini},{fin})',setpts=PTS-STARTPTS",
            "-an",clip
        ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        h = hash_file(clip)

        registrar(f"Archivo: {clip}")
        registrar(f"Frames: {ini}-{fin}")
        registrar(f"SHA256: {h}")
        registrar(f"Fecha: {time.ctime()}")
        registrar("----------------------")

def recorrer():
    for root,_,files in os.walk(INPUT):
        for f in files:
            if f.endswith((".mp4",".avi",".dav")):
                path = os.path.join(root,f)

                registrar(f"Analizando: {path}")
                v = convertir(path)

                if os.path.exists(v):
                    registrar(f"Hash original: {hash_file(v)}")
                    analizar(v)

if __name__ == "__main__":
    recorrer()
EOF

echo "🚀 Ejecutando análisis pericial..."
python $SCRIPT

echo "=================================="
echo "✅ PERITAJE COMPLETADO"
echo "📁 Evidencia en: $OUT"
echo "📄 Cadena custodia: $LOG"
