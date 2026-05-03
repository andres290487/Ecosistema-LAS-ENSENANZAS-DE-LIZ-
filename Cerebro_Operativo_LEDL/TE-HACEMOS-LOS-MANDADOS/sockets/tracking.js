export default function initSockets(io) {
  io.on('connection', (socket) => {
    console.log('🟢 Cliente conectado');

    socket.on('escuchar_tracking', (envioId) => {
      socket.join(`tracking_${envioId}`);
    });

    socket.on('repartidor_movimiento', (data) => {
      io.to(`tracking_${data.id_envio}`).emit('actualizar_mapa', {
        lat: data.lat,
        lng: data.lng,
        timestamp: new Date()
      });
    });
  });
}
