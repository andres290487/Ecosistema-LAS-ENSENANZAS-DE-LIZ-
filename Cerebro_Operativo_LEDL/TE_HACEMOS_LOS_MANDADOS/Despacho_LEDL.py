import json

# 1. Definición del Payload (El objeto de datos)
json_string_input = json.dumps({
    "transmision": {
        "receptor": "+5218147928662",
        "mensaje": "Hola, este es un mensaje de prueba",
        "datos": {
            "tipo": "imagen",
            "url": "https://internet.wm.com"
        }
    },
    "metadatos": {
        "fecha_creacion": "2026-04-13",
        "autor": "J. Andrés Resendez R"
    }
})

# 2. Función de Procesamiento (El núcleo)
def procesar_payload(json_data):
    # Si recibes un dict, no necesitas loads; si recibes string, sí.
    payload = json.loads(json_data) if isinstance(json_data, str) else json_data
    print(f"[*] Procesando instrucción de: {payload['metadatos']['autor']}")
    
    if payload['transmision']['datos']['tipo'] == "imagen":
        print(f"[+] Despachando recurso: {payload['transmision']['datos']['url']}")
    return True

# 3. Ejecución controlada
if __name__ == "__main__":
    resultado = procesar_payload(json_string_input)
    print(f"[+] Estado de operación: {'Exitosa' if resultado else 'Fallida'}")
