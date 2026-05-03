import sqlite3
import hashlib
import os

def boot_soberano():
    db_path = os.path.join(os.path.dirname(__file__), 'ledl_status.db')
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS status (id TEXT PRIMARY KEY, state TEXT, lastSyncTime INTEGER)")
    public_id = hashlib.sha256(os.urandom(32)).hexdigest()
    cursor.execute("INSERT OR IGNORE INTO status VALUES (?, ?, ?)", (public_id, 'ACTIVE', 0))
    conn.commit()
    conn.close()
    print("[+] Nodo inicializado con éxito.")

if __name__ == "__main__":
    boot_soberano()
