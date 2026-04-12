#!/bin/bash

echo "🧠 ENSDELIZ FORENSE TOTAL (PIXEL + IA HUMANA)"
echo "============================================"

read -p "📂 Ruta DVR: " RUTA

BASE="$HOME/ensdeliz_pro"
OUT="$BASE/output"
SCRIPT="$BASE/ia_forense.py"

mkdir -p "$OUT"
cd "$BASE"

echo "📦 Instalando dependencias..."
pkg install -y python ffmpeg
pip install opencv-python-headless numpy ultralytics

echo "🧠 Creando motor IA..."

cat > $SCRIPT <<EOF
import cv2, os, numpy as np, subprocess, time
from ultralytics import YOLO

INPUT = "$RUTA"
OUT = "$OUT"

model = YOLO("yolov8n.pt")

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
    frames_evento = 0
    inicio = None
    frame_id = 0

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        diff = cv2.absdiff(prev, gray)
        _, th = cv2.threshold(diff, 25, 255, cv2.THRESH_BINARY)

        movimiento = np.sum(th) / 255

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
            frames_evento += 1
        else:
            if frames_evento > 15:
                eventos.append((inicio, frame_id))
            frames_evento = 0
            inicio = None

        prev = gray
        frame_id += 1

    cap.release()

    if eventos:
        nombre = os.path.basename(video)
        log = os.path.join(OUT,"timeline.txt")

        for i,(ini,fin) in enumerate(eventos):
            clip = os.path.join(OUT,f"{nombre}_evento{i}.mp4")

            subprocess.run([
                "ffmpeg","-y","-i",video,
                "-vf",f"select='between(n,{ini},{fin})',setpts=PTS-STARTPTS",
                "-an",clip
            ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

            with open(log,"a") as f:
                f.write(f"{nombre} evento {i} frames {ini}-{fin}\\n")

def recorrer():
    for root,_,files in os.walk(INPUT):
        for f in files:
            if f.endswith((".mp4",".avi",".dav")):
                path = os.path.join(root,f)
                print("🔍",path)

                v = convertir(path)
                analizar(v)

if __name__ == "__main__":
    recorrer()
EOF

echo "🚀 Ejecutando análisis inteligente..."
python $SCRIPT

echo "=================================="
echo "✅ LISTO"
echo "📁 Ver resultados en: $OUT"
