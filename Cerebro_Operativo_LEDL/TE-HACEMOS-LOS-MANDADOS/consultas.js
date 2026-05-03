// Ejemplo: Crear envío (SQLite vs PostgreSQL)
// PostgreSQL: INSERT INTO shipments (...) VALUES (...) RETURNING id
// SQLite: INSERT INTO shipments (...) VALUES (...); SELECT last_insert_rowid();

const stmt = db.prepare(`
  INSERT INTO shipments (order_number, cliente_id, status, destino_lat, destino_lng, total)
  VALUES (?, ?, ?, ?, ?, ?)
`);
const info = stmt.run(orderNumber, clienteId, 'pendiente', lat, lng, total);
const newId = info.lastInsertRowid;  // SQLite
