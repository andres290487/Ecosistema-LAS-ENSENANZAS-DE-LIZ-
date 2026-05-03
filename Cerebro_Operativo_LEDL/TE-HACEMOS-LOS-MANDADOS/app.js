const socket = io("https://TU-BACKEND-RENDER.onrender.com");

let currentOrder = null;

// ==========================
// CREAR PEDIDO
// ==========================
function createOrder() {

  const pickup = document.getElementById("pickup").value.split(",");
  const dropoff = document.getElementById("dropoff").value.split(",");

  const order = {
    id: Date.now(),
    pickup: { lat: parseFloat(pickup[0]), lng: parseFloat(pickup[1]) },
    dropoff: { lat: parseFloat(dropoff[0]), lng: parseFloat(dropoff[1]) }
  };

  socket.emit("new_order", order);

  document.getElementById("status").innerText = "Estado: pedido enviado...";
}

// ==========================
// ORDEN ASIGNADA
// ==========================
socket.on("order_assigned", (order) => {
  currentOrder = order;
  document.getElementById("status").innerText =
    "Repartidor asignado: " + order.driverId;
});

// ==========================
// TRACKING LIVE
// ==========================
socket.on("tracking_update", (data) => {
  console.log("Driver location:", data);
});
