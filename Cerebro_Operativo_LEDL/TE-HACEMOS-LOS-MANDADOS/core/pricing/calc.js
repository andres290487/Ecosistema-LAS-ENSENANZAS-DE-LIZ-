function calculatePrice(distance, demandFactor = 1) {
  const base = 25;
  const perKm = 8;
  return (base + distance * perKm) * demandFactor;
}

module.exports = { calculatePrice };
