import os
import json
from datetime import datetime
import re

def analizar_archivo(ruta):
    try:
        with open(ruta, 'r', encoding='utf-8', errors='ignore') as f:
            contenido = f.read()
            lineas = len(contenido.splitlines())
            
            analisis = {
                "lineas": lineas,
                "tiene_env": bool(re.search(r'process\.env|dotenv|os\.environ|env\.', contenido)),
                "hardcoded_secrets": bool(re.search(r'password|secret|key|token|api_key|sk_test|pk_test', contenido, re.I)),
                "puerto": re.search(r'port\s*[:=]\s*(\d+)', contenido),
                "db_conexion": bool(re.search(r'postgres|mysql|sqlite|mongodb|sqlalchemy|psycopg2', contenido, re.I)),
                "cors": bool(re.search(r'cors|CORSMiddleware', contenido, re.I)),
                "sockets": bool(re.search(r'socket\.io|websocket|io\.on', contenido, re.I)),
            }
            return contenido[:2000] if len(contenido) > 2000 else contenido, analisis
    except:
        return None, {}

def barrido_completo():
    root = os.getcwd()
    report = {
        "proyecto": "TE HACEMOS LOS MANDADOS",
        "fecha": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "ubicacion": root,
        "archivos_totales": 0,
        "carpetas": [],
        "archivos": [],
        "faltantes_produccion": [],
        "recomendaciones": []
    }

    print("🔍 Iniciando barrido completo del proyecto...")

    for dirpath, dirnames, filenames in os.walk(root):
        # Ignorar node_modules y caches
        if 'node_modules' in dirnames:
            dirnames.remove('node_modules')
        if '__pycache__' in dirnames:
            dirnames.remove('__pycache__')

        rel_path = os.path.relpath(dirpath, root)
        if rel_path == ".":
            rel_path = ""

        for d in dirnames:
            report["carpetas"].append(os.path.join(rel_path, d))

        for f in filenames:
            full_path = os.path.join(dirpath, f)
            rel_file = os.path.join(rel_path, f)
            size = os.path.getsize(full_path) / 1024  # KB

            contenido, analisis = analizar_archivo(full_path)

            file_info = {
                "archivo": rel_file,
                "tamaño_kb": round(size, 2),
                "analisis": analisis
            }

            report["archivos"].append(file_info)
            report["archivos_totales"] += 1

            # Análisis específico por archivo clave
            if "server.js" in f:
                if not analisis.get("tiene_env"):
                    report["faltantes_produccion"].append("server.js → No usa variables de entorno (.env)")
                if not analisis.get("cors"):
                    report["faltantes_produccion"].append("server.js → Falta configuración CORS (seguridad)")

            if "ORQUESTADOR_LEDL_PRO.py" in f:
                if not analisis.get("tiene_env"):
                    report["faltantes_produccion"].append("ORQUESTADOR_LEDL_PRO.py → No usa variables de entorno")

            if "LEDL.sql" in f:
                report["recomendaciones"].append("LEDL.sql → Crear script de migración para producción (Railway/Supabase)")

            if "INVENTARIO_TOTAL.json" in f:
                try:
                    with open(full_path, 'r', encoding='utf-8') as jf:
                        data = json.load(jf)
                        report["recomendaciones"].append(f"INVENTARIO_TOTAL.json → {len(data)} productos detectados")
                except:
                    pass

    # Checklist de producción (lo que te falta para estar 100% online)
    archivos_obligatorios = [".env", "README.md", ".gitignore", "Dockerfile", "docker-compose.yml", "ecosystem.config.js"]
    for arch in archivos_obligatorios:
        if not os.path.exists(os.path.join(root, arch)):
            report["faltantes_produccion"].append(f"Falta archivo crítico: {arch}")

    report["faltantes_produccion"].extend([
        "✅ Hosting conjunto (Node + Python): Recomiendo Railway o Render (tienen soporte gratis para ambos)",
        "✅ Base de datos en la nube (PostgreSQL recomendado)",
        "✅ Autenticación (JWT o Firebase Auth) para clientes y mandaderos",
        "✅ Integración de pagos México (Mercado Pago o Stripe)",
        "✅ Google Maps API + distancia/precio dinámico",
        "✅ Notificaciones push / WhatsApp Business API",
        "✅ HTTPS automático + dominio propio (.com o .mx)",
        "✅ Logging en producción (no solo ledl.log)",
        "✅ Tests básicos (Jest + pytest)",
        "✅ Variables de entorno en deployment (Railway Dashboard)",
        "✅ PM2 o Docker para mantener el servidor vivo"
    ])

    # Guardar reporte completo
    with open("BARRIDO_COMPLETO_REPORT.md", "w", encoding="utf-8") as f:
        f.write(f"# 🚀 BARRIDO COMPLETO - TE HACEMOS LOS MANDADOS\n")
        f.write(f"**Fecha:** {report['fecha']}\n")
        f.write(f"**Archivos analizados:** {report['archivos_totales']}\n\n")
        
        f.write("## 📋 LO QUE TE FALTA PARA 100% FUNCIONAL ONLINE\n")
        for item in report["faltantes_produccion"]:
            f.write(f"- {item}\n")
        
        f.write("\n## 🛠 Recomendaciones prioritarias\n")
        for rec in report["recomendaciones"]:
            f.write(f"- {rec}\n")

        f.write("\n## 📁 Estructura detectada\n")
        f.write("**Carpetas:**\n")
        for c in sorted(report["carpetas"]):
            f.write(f"- {c}\n")

        f.write("\n**Archivos clave analizados:**\n")
        for archivo in report["archivos"]:
            if any(x in archivo["archivo"] for x in ["server.js", "ORQUESTADOR", "FRONTEND", "db.js", "LEDL.sql", "package.json"]):
                f.write(f"- **{archivo['archivo']}** ({archivo['tamaño_kb']} KB) → {archivo['analisis']}\n")

    print("\n✅ ¡Barrido terminado!")
    print(f"📄 Reporte completo guardado en: BARRIDO_COMPLETO_REPORT.md")
    print("\n🔥 Copia y pégame el contenido del reporte (o al menos la sección 'LO QUE TE FALTA') y te ayudo a implementar todo lo que falta paso a paso.")

if __name__ == "__main__":
    barrido_completo()
