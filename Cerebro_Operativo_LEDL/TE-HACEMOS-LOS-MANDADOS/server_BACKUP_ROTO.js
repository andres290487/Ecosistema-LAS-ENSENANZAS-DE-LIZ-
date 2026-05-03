import express from 'express';
import cors from 'cors';
import { pool } from './db.js';
import http from 'http';
import { Server } from 'socket.io';

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: "*" }
});

const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// =========================
PROJECT_DIR="$HOME/Main_LEDL/Cerebro_Operativo_LEDL/TE-HACEMOS-LOS-MANDADOS"
BASE="$HOME/ledl_system"
LOG="$BASE/ledl.log"
PORT=3000

// Ir al proyecto 🔥
cd "$PROJECT_DIR" || {
  echo "❌ No se encontró el proyecto"
  exit 1
}

mkdir -p "$BASE"
touch "$LOG"

// =========================
// SOCKET CONNECTION
// =========================
io.on('connection', (socket) => {
  console.log('🔌 Cliente conectado:', socket.id);

  socket.on('disconnect', () => {
    console.log('❌ Cliente desconectado:', socket.id);
  });
});

// =========================
// DISTANCIA
// =========================
function calcularDistancia(lat1, lng1, lat2, lng2) {
  const R = 6371;
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLng = (lng2 - lng1) * Math.PI / 180;

  const a =
    Math.sin(dLat/2) ** 2 +
    Math.cos(lat1 * Math.PI/180) *
    Math.cos(lat2 * Math.PI/180) *
    Math.sin(dLng/2) ** 2;

  return 2 * R * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
}

// =========================
// CREAR ENVÍO + EMITIR
// =========================
app.post('/api/envios', async (req, res) => {
  const { cliente, destino, lat, lng } = req.body;

  try {
    const repartidores = await pool.query(
      'SELECT * FROM repartidores WHERE disponible = true'
    );

    let mejor = null;
    let menor = Infinity;

    repartidores.rows.forEach(r => {
      const d = calcularDistancia(lat, lng, r.lat, r.lng);
      if (d < menor) {
        menor = d;
        mejor = r;
      }
    });

    const result = await pool.query(
      'INSERT INTO envios (cliente, destino, estado) VALUES ($1,$2,$3) RETURNING *',
      [cliente, destino, `Asignado a ${mejor.nombre}`]
    );

    const envio = result.rows[0];

    // 🔥 EMITIR A TODOS
    io.emit('nuevo_envio', envio);

    console.log("📡 Enviado en tiempo real");

    res.json({ envio, repartidor: mejor });

  } catch (err) {
    console.error(err);
    res.status(500).send("Error");
  }
});

// =========================
// OBTENER ENVÍOS
// =========================
app.get('/api/envios', async (req, res) => {
  const result = await pool.query(
    'SELECT * FROM envios ORDER BY id DESC'
  );
  res.json(result.rows);
});

// =========================
// START SERVER
// =========================
server.listen(PORT, () => {
  console.log(`🔥 API + WS en http://localhost:${PORT}`);
});
