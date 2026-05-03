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
