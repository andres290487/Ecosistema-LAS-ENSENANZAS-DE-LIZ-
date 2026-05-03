import express from 'express';
import { pool } from '../db.js';

const router = express.Router();

// Crear envío
router.post('/', async (req, res) => {
  const { cliente_lat, cliente_lng } = req.body;

  const result = await pool.query(
    `INSERT INTO envios (cliente_lat, cliente_lng)
     VALUES ($1, $2) RETURNING *`,
    [cliente_lat, cliente_lng]
  );

  res.json(result.rows[0]);
});

// Obtener envíos
router.get('/', async (req, res) => {
  const result = await pool.query('SELECT * FROM envios');
  res.json(result.rows);
});

export default router;
