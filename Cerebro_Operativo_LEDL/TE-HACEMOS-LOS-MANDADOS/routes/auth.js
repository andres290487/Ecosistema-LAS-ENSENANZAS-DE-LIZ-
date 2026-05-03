import express from 'express';
const router = express.Router();

// Demo: usuario fijo
router.get('/verify-session', (req, res) => {
  res.json({ role: 'repartidor' }); // simula sesión
});

export default router;
