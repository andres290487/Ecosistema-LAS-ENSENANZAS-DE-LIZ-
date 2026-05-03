import os, sqlite3, sys, time

# Configuración de Colores ANSI para Pulsos Neurales
PULSO = "\033[96m" # Cian
RESET = "\033[0m"
BARRA = "█"

def animacion_pulso(porcentaje):
    n = int(porcentaje / 5)
    sys.stdout.write(f"\r{PULSO}NEURAL_SYNC [{BARRA*n}{' '*(20-n)}] {porcentaje}%{RESET}")
    sys.stdout.flush()

def barrido_total():
    rutas = ["/storage/emulated/0", "/sdcard", os.environ.get("HOME", "/data/data/com.termux/files/home")]
    archivos_totales = 0
    
    # Pre-escaneo para ETA real
    print(f"{PULSO}● INICIANDO BARRIDO NEURAL TOTAL...{RESET}")
    
    conn = sqlite3.connect("Inventario_Total.db")
    conn.execute("CREATE TABLE IF NOT EXISTS archivos (ruta TEXT, nombre TEXT)")
    
    count = 0
    for ruta_base in rutas:
        for root, _, files in os.walk(ruta_base):
            for file in files:
                conn.execute("INSERT INTO archivos VALUES (?, ?)", (os.path.join(root, file), file))
                count += 1
                if count % 100 == 0:
                    animacion_pulso(min(100, (count % 1000) // 10))
    
    conn.commit()
    conn.close()
    print(f"\n{PULSO}● BARRIDO COMPLETADO. ECOSISTEMA SINCRONIZADO.{RESET}")

if __name__ == "__main__":
    barrido_total()
