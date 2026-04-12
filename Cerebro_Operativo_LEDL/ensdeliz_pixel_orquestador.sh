#!/bin/bash

echo "🧠 ENSDELIZ FORENSE - ANÁLISIS POR CAMBIO DE PIXELES"
echo "==================================================="

read -p "📂 Ruta del disco DVR (ej: /storage/dvr): " RUTA

BASE="$HOME/ensdeliz_pixel"
OUT="$BASE/output"
TMP="$BASE/tmp"
SCRIPT="$BASE/analisis.py"

mkdir -p "$OUT" "$TMP"
cd "$BASE"

echo "📦 Instalando dependencias..."

pkg update -y
pkg install -y python ffmpeg

pip install opencv-python-headless numpy

echo "🧠 Generando motor de análisis..."

cat > $SCRIPT <<EOF
import cv2
import os
import numpy as np
import subprocess
import time

INPUT = "$RUTA"
OUT = "$OUT"

os.makedirs(OUT, exist_ok=True)

def convertir_dav(video):
    if video.endswith(".dav"):
        nuevo = video.replace(".dav", ".mp4")
        subprocess.run(["ffmpeg","-y","-i",video,nuevo],
                       stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
        return nuevo
    return video

def analizar_video(video):
    cap = cv2.VideoCapture(video)
    ret, prev = cap.read()

    if not ret:
        return

    prev_gray = cv2.cvtColor(prev, cv2.COLOR_BGR2GRAY)
    eventos = []
    contador = 0

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        diff = cv2.absdiff(prev_gray, gray)
        _, thresh = cv2.threshold(diff, 25, 255, cv2.THRESH_BINARY)

        movimiento = np.sum(thresh) / 255

        if movimiento > 5000:
            contador += 1
        else:
            if contador > 10:
                eventos.append(contador)
            contador = 0

        prev_gray = gray

    cap.release()

    if eventos:
        nombre = os.path.basename(video)
        log = os.path.join(OUT, "eventos.txt")

        with open(log, "a") as f:
            f.write(f"{nombre} -> eventos detectados: {len(eventos)}\\n")

        # Extraer clip inicial
        clip = os.path.join(OUT, f"clip_{nombre}.mp4")
        subprocess.run([
            "ffmpeg","-y","-i",video,"-t","15","-vcodec","copy",clip
        ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def recorrer():
    for root, dirs, files in os.walk(INPUT):
        for file in files:
            if file.endswith((".mp4",".avi",".dav")):
                path = os.path.join(root, file)

                print(f"🔍 Analizando: {path}")

                video = convertir_dav(path)
                analizar_video(video)

if __name__ == "__main__":
    recorrer()
EOF

echo "🚀 Ejecutando análisis total..."
python $SCRIPT

echo "================================="
echo "✅ ANÁLISIS COMPLETO"
echo "📁 Resultados en: $OUT"
