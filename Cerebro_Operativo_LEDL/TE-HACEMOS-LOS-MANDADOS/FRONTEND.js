botonRepartidor.addEventListener('click', async () => {
    const res = await fetch('http://localhost:3000/api/auth/verify-session');
    const data = await res.json();

    if (data.role === 'repartidor') {
        window.location.href = 'repartidor.html';
    }
});
