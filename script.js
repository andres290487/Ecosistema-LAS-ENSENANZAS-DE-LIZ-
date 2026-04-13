function abrirModulo(n, d) { 
    document.getElementById('modal-titulo').innerText = n; 
    document.getElementById('modal-cuerpo').innerText = d; 
    document.getElementById('ventana-modulo').style.display = "block"; 
}
function cerrarModulo() { document.getElementById('ventana-modulo').style.display = "none"; }
function ejecutarAuditoria() {
    let addr = prompt("Ingrese dirección de Wallet para auditoría forense (ARES-Kal):");
    if (addr) {
        document.getElementById('modal-titulo').innerText = "ARES-Kal: Auditoría en Curso";
        document.getElementById('modal-cuerpo').innerHTML = "Analizando bloque... <br>Dirección: <b>" + addr + "</b>";
        document.getElementById('ventana-modulo').style.display = "block";
    }
}
