import os
import json

ROOT_DIR = os.path.expanduser("~/Main_LEDL/Cerebro_Operativo_LEDL")
CATEGORIAS = {
    "Backend": [".py"],
    "Frontend": [".html", ".css", ".js"],
    "Logistica": [".db"],
    "Configuracion": [".sh", ".json", ".env"]
}

def barrido_profundo():
    reporte = {cat: [] for cat in CATEGORIAS}
    for root, dirs, files in os.walk(ROOT_DIR):
        for file in files:
            ext = os.path.splitext(file)[1]
            for cat, exts in CATEGORIAS.items():
                if ext in exts:
                    reporte[cat].append(os.path.join(root, file))
    
    with open(os.path.join(ROOT_DIR, "MAPA_SISTEMA.json"), "w") as f:
        json.dump(reporte, f, indent=4)
    print("[+] Barrido completado. Mapa generado: MAPA_SISTEMA.json")

if __name__ == "__main__":
    barrido_profundo()
