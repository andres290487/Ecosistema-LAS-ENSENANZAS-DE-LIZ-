import cv2
import subprocess
import time
from ultralytics import YOLO

# =========================
# CONFIGURACIÓN
# =========================
RTSP_CAM1 = "rtsp://admin:RERj870429@192.168.0.108:554/cam/realmonitor?channel=1&subtype=0"
RTSP_CAM2 = "rtsp://admin:RERj870429@192.168.0.108:554/cam/realmonitor?channel=2&subtype=0"

model = YOLO("yolov8n.pt")  # ligera y rápida

# ZONAS (ajustar según tu imagen)
# formato: (x1, y1, x2, y2)
ZONA_MOTO = (400, 200, 700, 900)
ZONA_PUERTA = (800, 200, 1100, 800)

def dentro_zona(x, y, zona):
    x1, y1, x2, y2 = zona
    return x1 < x < x2 and y1 < y < y2

def grabar_clip(rtsp, nombre):
    archivo = f"alerta_{nombre}_{int(time.time())}.mp4"
    subprocess.run([
        "ffmpeg", "-y",
        "-i", rtsp,
        "-t", "10",
        "-vcodec", "copy",
        archivo
    ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print(f"🚨 ALERTA: {archivo}")

def analizar(rtsp, zona, nombre):
    cap = cv2.VideoCapture(rtsp)

    while True:
        ret, frame = cap.read()
        if not ret:
            time.sleep(1)
            continue

        results = model(frame, verbose=False)

        for r in results:
            for box in r.boxes:
                cls = int(box.cls[0])
                if cls == 0:  # PERSONA
                    x1, y1, x2, y2 = map(int, box.xyxy[0])
                    cx = (x1 + x2) // 2
                    cy = (y1 + y2) // 2

                    if dentro_zona(cx, cy, zona):
                        grabar_clip(rtsp, nombre)
                        time.sleep(10)  # evitar spam

# =========================
# EJECUCIÓN
# =========================
import threading

t1 = threading.Thread(target=analizar, args=(RTSP_CAM1, ZONA_MOTO, "moto"))
t2 = threading.Thread(target=analizar, args=(RTSP_CAM2, ZONA_PUERTA, "puerta"))

t1.start()
t2.start()
