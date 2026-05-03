CREATE DATABASE ledl;

\c ledl;

CREATE TABLE envios (
    id SERIAL PRIMARY KEY,
    codigo_seguimiento VARCHAR(50),
    estado VARCHAR(20) DEFAULT 'pendiente',
    cliente_lat DECIMAL,
    cliente_lng DECIMAL,
    negocio_lat DECIMAL,
    negocio_lng DECIMAL,
    repartidor_id INT,
    creado_en TIMESTAMP DEFAULT NOW(),
    actualizado_en TIMESTAMP DEFAULT NOW()
);
