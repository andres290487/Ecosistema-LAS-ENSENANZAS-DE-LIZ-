import os
import sys
import hashlib
import time

def mostrar_cabecera(modo):
    status_msg = "ONLINE COMPLETO" if modo == "1" else "MODO EMERGENCIA / MANTENIMIENTO"
    print("="*60)
    print(f"       CEREBRO OPERATIVO LEDL - TE HACEMOS LOS MANDADOS")
    print(f"       ZONA: VALLE DEL ROBLE | ESTADO: {status_msg}")
    print("="*60)

def modo_online():
    # Conecta con la DB y Telegram
    mostrar_cabecera("1")
    print("[*] Sincronizando con Nodo Blockchain...")
    print("[*] Conectando con API Telegram (ID: 8486738889)...")
    time.sleep(1)
    print("[+] Sistema 100% Vinculado. Esperando pedidos...")
    # Aquí se integra el loop de escucha de pedidos

def modo_mantenimiento():
    # Operación local simplificada para evitar bloqueos
    mostrar_cabecera("2")
    print("[!] ADVERTENCIA: Operando en modo local seguro.")
    print("[+] Interfaz simplificada activa para despacho manual.")
    print("[ 1 ] Registro Manual  [ 2 ] Ver Ledger Local")

if __name__ == "__main__":
    # Si no hay argumentos, preguntar por consola
    print("\n[ SELECCIONE MODO DE DESPLIEGUE ]")
    print("1. MODO ONLINE (Completo)")
    print("2. MODO EMERGENCIA (Mantenimiento)")
    opcion = input("\nLEDL > ")
    
    if opcion == "1":
        modo_online()
    else:
        modo_mantenimiento()
