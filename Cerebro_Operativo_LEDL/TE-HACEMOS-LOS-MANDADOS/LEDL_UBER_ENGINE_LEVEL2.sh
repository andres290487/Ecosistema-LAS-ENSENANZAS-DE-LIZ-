#!/bin/bash

echo "===================================="
echo "🚀 UBER ENGINE LEVEL 2 INIT"
echo "===================================="

mkdir -p core/{dispatch,tracking,pricing,events}
mkdir -p services/{api,drivers,orders}
mkdir -p realtime workers config

# ==========================
# ENV PRO LEVEL
# ==========================
cat > .env <<EOF
SERVICE_NAME=mandados_core_v2
NODE_ENV=production
PORT=3000

DB_HOST=localhost
DB_PORT=5432
DB_NAME=ledl_mandados

JWT_SECRET=uber_level_2_secret

GOOGLE_MAPS_API_KEY=
EOF

# ==========================
# DISPATCH ENGINE (REAL LOGIC)
# ==========================
cat > core/dispatch/matching.js <<'EOF'
function calculateDistance(a, b) {
  const R = 6371;
  const dLat = (b.lat - a.lat) * Math.PI / 180;
  const dLng = (b.lng - a.lng) * Math.PI / 180;

  const x =
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(a.lat * Math.PI/180) *
    Math.cos(b.lat * Math.PI/180) *
    Math.sin(dLng/2) * Math.sin(dLng/2);

  const c = 2 * Math.atan2(Math.sqrt(x), Math.sqrt(1-x));
  return R * c;
}

function findBestDriver(order, drivers) {
  return drivers
    .filter(d => d.available)
    .sort((a,b) =>
      calculateDistance(a.location, order.pickup) -
      calculateDistance(b.location, order.pickup)
    )[0];
}

module.exports = { findBestDriver };
EOF

# ==========================
# TRACKING ENGINE
# ==========================
cat > core/tracking/stream.js <<'EOF'
const activeDrivers = new Map();

function updateDriverLocation(driverId, location) {
  activeDrivers.set(driverId, {
    ...location,
    timestamp: Date.now()
  });
}

function getDriverLocation(driverId) {
  return activeDrivers.get(driverId);
}

module.exports = { updateDriverLocation, getDriverLocation };
EOF

# ==========================
# PRICING ENGINE (SURGE)
# ==========================
cat > core/pricing/calc.js <<'EOF'
function calculatePrice(distance, demandFactor = 1) {
  const base = 25;
  const perKm = 8;
  return (base + distance * perKm) * demandFactor;
}

module.exports = { calculatePrice };
EOF

# ==========================
# UBER CORE SERVER (LEVEL 2)
# ==========================
cat > server.js <<'EOF'
require('dotenv').config();

const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const { findBestDriver } = require('./core/dispatch/matching');
const { updateDriverLocation } = require('./core/tracking/stream');
const { calculatePrice } = require('./core/pricing/calc');

const app = express();
const server = http.createServer(app);

const io = new Server(server, {
  cors: { origin: "*" }
});

app.use(express.json());

let drivers = [];
let orders = [];

// HEALTH
app.get("/", (req,res)=>{
  res.json({
    service: "UBER ENGINE LEVEL 2",
    status: "ONLINE"
  });
});

// SOCKET CORE
io.on("connection", (socket) => {

  // DRIVER GPS
  socket.on("driver_location", (data) => {
    updateDriverLocation(data.driverId, data.location);
    io.emit("tracking_update", data);
  });

  // NEW ORDER
  socket.on("new_order", (order) => {

    order.price = calculatePrice(order.distance || 1, 1);

    const driver = findBestDriver(order, drivers);

    if(driver){
      order.driverId = driver.id;
      order.status = "ASSIGNED";
    }

    orders.push(order);

    io.emit("order_created", order);
  });

  // REGISTER DRIVER
  socket.on("register_driver", (driver) => {
    drivers.push(driver);
  });

});

const PORT = process.env.PORT || 3000;

server.listen(PORT, "0.0.0.0", ()=>{
  console.log("====================================");
  console.log("🚀 UBER ENGINE LEVEL 2 ONLINE");
  console.log("PORT:", PORT);
  console.log("====================================");
});
EOF

# ==========================
# PM2 CONFIG
# ==========================
cat > ecosystem.config.js <<EOF
module.exports = {
  apps: [
    {
      name: "uber-engine-level2",
      script: "server.js",
      env: {
        NODE_ENV: "production",
        PORT: 3000
      }
    }
  ]
};
EOF

echo "===================================="
echo "🚀 UBER ENGINE LEVEL 2 READY"
echo "===================================="
echo "RUN:"
echo "npm install"
echo "pm2 start ecosystem.config.js"
echo "===================================="
