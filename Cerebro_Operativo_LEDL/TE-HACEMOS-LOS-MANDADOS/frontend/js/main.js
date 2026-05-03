document.addEventListener("DOMContentLoaded", () => {

  document.getElementById("cliente").onclick = () => {
    alert("Cliente activo (ya crea envíos)");
  };

  document.getElementById("repartidor").onclick = () => {
    window.location.href = "/repartidor.html";
  };

  document.getElementById("negocio").onclick = () => {
    window.location.href = "/negocio.html";
  };

});
