const socket = io("http://localhost:3000");

socket.on("nuevo_envio", (envio) => {
  console.log("📦 Nuevo pedido en vivo:", envio);

  const lista = document.getElementById("lista-envios");

  const item = document.createElement("li");
  item.textContent = `${envio.cliente} → ${envio.destino} (${envio.estado})`;

  lista.prepend(item);
});
