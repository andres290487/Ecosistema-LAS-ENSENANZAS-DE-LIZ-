import sqlite3
import os
import requests

DB_PATH = os.path.expanduser('~/Main_LEDL/Cerebro_Operativo_LEDL/TE_HACEMOS_LOS_MANDADOS/ledl_logistica.db')
TOKEN_BOT = "TU_TOKEN_TELEGRAM_AQUI"
CHAT_ID = "TU_CHAT_ID_AQUI"

def sanar_base_datos():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM pedido WHERE estado = 'entregado'")
    count_to_purge = cursor.fetchone()[0]
    
    cursor.execute("DELETE FROM pedido WHERE estado = 'entregado'")
    conn.commit()
    cursor.execute("VACUUM")
    conn.commit()
    conn.close()
    
    if count_to_purge > 10:
        msg = f"⚠️ ALERTA LEDL: Purga masiva de datos. Registros eliminados: {count_to_purge}"
        requests.get(f"https://api.telegram.org/bot{TOKEN_BOT}/sendMessage?chat_id={CHAT_ID}&text={msg}")

if __name__ == "__main__":
    sanar_base_datos()
