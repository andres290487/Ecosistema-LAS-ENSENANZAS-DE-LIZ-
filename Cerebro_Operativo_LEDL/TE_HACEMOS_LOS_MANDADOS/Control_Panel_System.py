print('[+] Control_Panel_System.py ejecutado')
import sqlite3
import os

def mostrar_panel():
    print("""
    =======================================================
    [ PROPIETARIO / SOCIO - PANEL DE CONTROL MAESTRO ]
    =======================================================
    1. VISOR DE ESTADOS (Nodos & Rutas)
    2. GESTIÓN DE LIQUIDACIONES (Dispersion Pagos)
    3. AUDITORÍA DE SEGURIDAD (Hash & Firmas)
    4. MENÚ DE EMERGENCIA (Parada de Nodo)
    =======================================================
    """)

def obtener_datos():
    # Consulta directa a tu base de datos de estado
    conn = sqlite3.connect('ledl_status.db')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM status")
    datos = cursor.fetchall()
    conn.close()
    return datos

if __name__ == "__main__":
    mostrar_panel()
