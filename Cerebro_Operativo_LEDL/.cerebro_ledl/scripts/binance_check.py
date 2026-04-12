import requests, time, hmac, hashlib, os
API_KEY, SECRET_KEY = os.getenv('BINANCE_API_KEY'), os.getenv('BINANCE_SECRET_KEY')
BASE_URL = 'https://api.binance.com'

# 1. Prueba de Sincronización de Tiempo
server_time = requests.get(f"{BASE_URL}/api/v3/time").json()['serverTime']
local_time = int(time.time() * 1000)
print(f"[SYNC] Diferencia de tiempo: {server_time - local_time}ms")

# 2. Prueba básica de cuenta (Spot)
ts = server_time
sig = hmac.new(SECRET_KEY.encode('utf-8'), f"timestamp={ts}".encode('utf-8'), hashlib.sha256).hexdigest()
url = f"{BASE_URL}/api/v3/account?timestamp={ts}&signature={sig}"
res = requests.get(url, headers={'X-MBX-APIKEY': API_KEY})
print(f"[STATUS] Código de respuesta Spot: {res.status_code}")
print(f"[DEBUG] Respuesta: {res.json()}")
