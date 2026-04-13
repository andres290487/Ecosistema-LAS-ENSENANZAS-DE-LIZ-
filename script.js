function abrirModulo(n, d) {
    document.getElementById('modal-titulo').innerText = "Invocando: " + n;
    document.getElementById('modal-cuerpo').innerText = d;
    document.getElementById('ventana-modulo').style.display = "block";
    console.log("Kernel LEDL: Modulo " + n + " iniciado.");
}
function cerrarModulo() { document.getElementById('ventana-modulo').style.display = "none"; }
console.log('Cerebro Operativo LEDL v167 - SO Web Operativo.');
