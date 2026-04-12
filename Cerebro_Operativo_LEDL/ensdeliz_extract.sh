#!/bin/bash

IMG="evidencia.img"
OUT="ensdeliz_output"

echo "🧠 ENSDELIZ FORENSE - EXTRACCIÓN INTELIGENTE"
echo "==========================================="

mkdir -p $OUT/{raw,video,logs,timeline,keywords}

# =========================
# 1. IDENTIFICACIÓN GENERAL
# =========================
echo "🔍 Escaneando estructura..."
binwalk $IMG > $OUT/binwalk.txt

# =========================
# 2. EXTRACCIÓN AUTOMÁTICA
# =========================
echo "📦 Extrayendo contenido..."
binwalk -e $IMG --directory $OUT/raw

# =========================
# 3. RECUPERACIÓN FOREMOST
# =========================
echo "🧬 Recuperando archivos..."
foremost -i $IMG -o $OUT/foremost

# =========================
# 4. DETECCIÓN DE VIDEO
# =========================
echo "🎥 Buscando videos..."
find $OUT -type f \( -iname "*.dav" -o -iname "*.mp4" -o -iname "*.h264" \) > $OUT/video/lista_videos.txt

# =========================
# 5. CONVERSIÓN AUTOMÁTICA
# =========================
echo "🔄 Convirtiendo .dav a mp4..."
while read file; do
    if [[ "$file" == *.dav ]]; then
        ffmpeg -i "$file" "$OUT/video/$(basename "$file").mp4" 2>/dev/null
    fi
done < $OUT/video/lista_videos.txt

# =========================
# 6. BÚSQUEDA INTELIGENTE
# =========================
echo "🧠 Analizando palabras clave..."
strings $IMG | grep -Ei "admin|login|error|motion|delete|alarm|record" > $OUT/keywords/hits.txt

# =========================
# 7. TIMELINE
# =========================
echo "🕒 Generando timeline..."
strings $IMG | grep -E "202[0-9]" > $OUT/timeline/timeline.txt

# =========================
# 8. REPORTE
# =========================
echo "📄 Generando reporte..."

echo "==== REPORTE ENSDELIZ ====" > $OUT/reporte.txt
echo "Imagen: $IMG" >> $OUT/reporte.txt
echo "Videos encontrados:" >> $OUT/reporte.txt
wc -l $OUT/video/lista_videos.txt >> $OUT/reporte.txt

echo "Eventos detectados:" >> $OUT/reporte.txt
wc -l $OUT/keywords/hits.txt >> $OUT/reporte.txt

echo "Timeline generado: OK" >> $OUT/reporte.txt

echo "================================="
echo "✅ EXTRACCIÓN COMPLETA"
echo "📁 Revisa: $OUT/"
