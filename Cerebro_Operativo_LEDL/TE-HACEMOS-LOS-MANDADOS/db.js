import pkg from "pg";
const { Pool } = pkg;

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "ledl",
  password: "3l1z@T34m0M@$", // deja vacío si no usas password
  port: 5432,
});

export default pool;
// db.js - Versión SQLite para Termux
const Database = require('better-sqlite3');
const path = require('path');

// Base de datos en archivo (se crea automáticamente)
const dbPath = path.join(__dirname, 'data', 'ledl_mandados.db');
const db = new Database(dbPath, { verbose: console.log });

// Crear tablas si no existen (migración automática)
db.exec(`
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT CHECK(role IN ('admin', 'negocio', 'repartidor', 'cliente')) NOT NULL,
    phone TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE IF NOT EXISTS shipments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_number TEXT UNIQUE NOT NULL,
    cliente_id INTEGER REFERENCES users(id),
    negocio_id INTEGER REFERENCES users(id),
    repartidor_id INTEGER REFERENCES users(id),
    status TEXT DEFAULT 'pendiente',
    origen_address TEXT,
    destino_address TEXT,
    origen_lat REAL,
    origen_lng REAL,
    destino_lat REAL,
    destino_lng REAL,
    items TEXT,  -- JSON string
    total REAL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE IF NOT EXISTS tracking_events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shipment_id INTEGER REFERENCES shipments(id),
    repartidor_id INTEGER REFERENCES users(id),
    latitude REAL,
    longitude REAL,
    event_type TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
  );

  CREATE INDEX IF NOT EXISTS idx_shipments_status ON shipments(status);
  CREATE INDEX IF NOT EXISTS idx_tracking_shipment ON tracking_events(shipment_id);
`);

module.exports = db;
