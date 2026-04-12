#!/bin/bash
# Script híbrido para proot-distro (Ubuntu)
# Automatiza: swap, fstab, instalación PyTorch/Ultralytics en venv, export ONNX y copia a LEDL

set -e

echo "🚀 Iniciando configuración proot-distro LEDL..."

# --- 1. Instalar proot-distro si no está ---
pkg install -y proot-distro

# --- 2. Instalar Ubuntu si no existe ---
proot-distro install ubuntu || true

# --- 3. Ejecutar configuración dentro de Ubuntu ---
proot-distro login ubuntu -- bash -c '
set -e
echo "📦 Actualizando paquetes..."
apt update && apt upgrade -y
apt install -y python3 python3-pip python3-venv git nano wget

# --- 4. Crear swapfile ---
if [ ! -f /swapfile ]; then
  dd if=/dev/zero of=/swapfile bs=1M count=2048
  chmod 600 /swapfile
  mkswap /swapfile
  echo "/swapfile none swap sw 0 0" >> /etc/fstab
  swapon /swapfile
fi

echo "✅ Swap activado"
free -h

# --- 5. Crear entorno virtual para evitar error PEP 668 ---
echo "📥 Creando entorno virtual..."
python3 -m venv /root/ledl-venv
source /root/ledl-venv/bin/activate

# --- 6. Instalar PyTorch y Ultralytics en venv ---
pip install --upgrade pip
pip install torch torchvision torchaudio ultralytics

# --- 7. Exportar modelo YOLOv8 a ONNX ---
echo "⚙️ Exportando modelo YOLOv8n a ONNX..."
yolo export model=yolov8n.pt format=onnx

# --- 8. Copiar ONNX a carpeta LEDL compartida ---
LEDL_PATH=/data/data/com.termux/files/home/UNIFIED_CEREBRO_OPERATIVO_LEDL/models
mkdir -p $LEDL_PATH
cp runs/export/yolov8n.onnx $LEDL_PATH/

echo "✅ Modelo ONNX copiado a $LEDL_PATH"
'

echo "🎉 Configuración completa. Ahora puedes ejecutar:"
echo "python ~/UNIFIED_CEREBRO_OPERATIVO_LEDL/scripts/analizar_moto.py"
