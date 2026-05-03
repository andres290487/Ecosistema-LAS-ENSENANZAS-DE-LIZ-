import os, sys, time, threading

# Códigos ANSI para evitar dependencias externas
CYAN = "\033[96m"
YELLOW = "\033[93m"
WHITE = "\033[97m"
GREEN = "\033[92m"
RESET = "\033[0m"

def pulso_neural(monitor, progreso, archivo_actual):
    bar = "█" * (progreso // 5)
    sys.stdout.write(f"\r{CYAN}[{monitor}] {WHITE}{progreso}% {YELLOW}{bar:<20} {WHITE}{archivo_actual[:40]:<40}{RESET}")
    sys.stdout.flush()

def ejecutar_barrido(monitor, ruta):
    count = 0
    total = 200 
    for root, _, files in os.walk(ruta):
        for file in files:
            count += 1
            progreso = int((count % total) / total * 100)
            if count % 5 == 0:
                pulso_neural(monitor, progreso, file)
            time.sleep(0.02)

# Ejecución paralela
monitores = [("STORAGE", "/sdcard"), ("SYSTEM", "/data/data/com.termux/files/usr"), ("HOME", "/data/data/com.termux/files/home")]
threads = []
for mon, ruta in monitores:
    t = threading.Thread(target=ejecutar_barrido, args=(mon, ruta))
    threads.append(t)
    t.start()

for t in threads: t.join()
print(f"\n{GREEN}● BARRIDO TOTAL FINALIZADO. DATOS SINCRONIZADOS.{RESET}")
