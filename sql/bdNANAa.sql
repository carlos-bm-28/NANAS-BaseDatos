CREATE DATABASE bd_nanas;
use bd_nanas;
-- =========================================================
-- TABLA: usuarios
-- =========================================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,

    correo VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    fecha_nacimiento DATE NOT NULL,

    foto_perfil VARCHAR(500),

    tipo_usuario ENUM(
        'CLIENTE',
        'NANA',
        'ADMIN'
    ) NOT NULL,

    estado_cuenta ENUM(
        'ACTIVA',
        'SUSPENDIDA',
        'PENDIENTE'
    ) DEFAULT 'PENDIENTE',

    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    ultimo_login DATETIME
);

-- =========================================================
-- TABLA: direcciones
-- =========================================================

CREATE TABLE direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    departamento VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    distrito VARCHAR(100) NOT NULL,

    direccion VARCHAR(255) NOT NULL,
    referencia VARCHAR(255),

    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: universidades
-- =========================================================

CREATE TABLE universidades (
    id_universidad INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(150) NOT NULL UNIQUE,
    siglas VARCHAR(20),

    tipo ENUM(
        'PUBLICA',
        'PRIVADA'
    ) NOT NULL,

    departamento VARCHAR(100),
    provincia VARCHAR(100)
);

-- =========================================================
-- TABLA: nanas
-- =========================================================

CREATE TABLE nanas (
    id_nana INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL UNIQUE,
    id_universidad INT NOT NULL,

    codigo_universitario VARCHAR(50) NOT NULL,

    carrera VARCHAR(150) NOT NULL,

    ciclo INT NOT NULL,

    descripcion TEXT,

    experiencia TEXT,

    tarifa_hora DECIMAL(10,2) NOT NULL,

    disponibilidad ENUM(
        'DISPONIBLE',
        'OCUPADA',
        'NO_DISPONIBLE'
    ) DEFAULT 'DISPONIBLE',

    verificado BOOLEAN DEFAULT FALSE,

    rating_promedio DECIMAL(3,2) DEFAULT 0.00,

    cantidad_reviews INT DEFAULT 0,

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_universidad)
        REFERENCES universidades(id_universidad)
);

-- =========================================================
-- TABLA: especialidades
-- =========================================================

CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- =========================================================
-- TABLA: nana_especialidad
-- =========================================================

CREATE TABLE nana_especialidad (
    id_nana INT NOT NULL,
    id_especialidad INT NOT NULL,

    PRIMARY KEY (id_nana, id_especialidad),

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
        ON DELETE CASCADE,

    FOREIGN KEY (id_especialidad)
        REFERENCES especialidades(id_especialidad)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: clientes
-- =========================================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL UNIQUE,

    tipo_cliente ENUM(
        'PADRE',
        'MADRE',
        'TUTOR',
        'FAMILIAR'
    ) NOT NULL,

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: personas_cuidadas
-- =========================================================

CREATE TABLE personas_cuidadas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,

    nombre VARCHAR(100) NOT NULL,

    fecha_nacimiento DATE,

    sexo ENUM(
        'M',
        'F',
        'OTRO'
    ),

    tipo_cuidado ENUM(
        'BEBE',
        'NINO',
        'ADULTO_MAYOR'
    ) NOT NULL,

    alergias TEXT,

    condiciones_medicas TEXT,

    observaciones TEXT,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: solicitudes_servicio
-- =========================================================
select*from usuarios;
CREATE TABLE solicitudes_servicio (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,

    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,

    direccion_servicio VARCHAR(255) NOT NULL,

    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8),

    descripcion TEXT,

    estado ENUM(
        'PENDIENTE',
        'ACEPTADA',
        'CANCELADA',
        'FINALIZADA'
    ) DEFAULT 'PENDIENTE',

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: postulaciones
-- =========================================================

CREATE TABLE postulaciones (
    id_postulacion INT AUTO_INCREMENT PRIMARY KEY,

    id_solicitud INT NOT NULL,
    id_nana INT NOT NULL,

    mensaje TEXT,

    estado ENUM(
        'PENDIENTE',
        'ACEPTADA',
        'RECHAZADA'
    ) DEFAULT 'PENDIENTE',

    fecha_postulacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_solicitud)
        REFERENCES solicitudes_servicio(id_solicitud)
        ON DELETE CASCADE,

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: reservas
-- =========================================================

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,
    id_nana INT NOT NULL,

    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,

    monto_total DECIMAL(10,2) NOT NULL,

    estado_pago ENUM(
        'PENDIENTE',
        'PAGADO',
        'REEMBOLSADO'
    ) DEFAULT 'PENDIENTE',

    estado_reserva ENUM(
        'PENDIENTE',
        'CONFIRMADA',
        'CANCELADA',
        'FINALIZADA'
    ) DEFAULT 'PENDIENTE',

    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
);

-- =========================================================
-- TABLA: pagos
-- =========================================================

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,

    id_reserva INT NOT NULL UNIQUE,

    monto DECIMAL(10,2) NOT NULL,

    metodo_pago ENUM(
        'YAPE',
        'PLIN',
        'TARJETA',
        'TRANSFERENCIA',
        'MERCADO_PAGO',
        'CULQI'
    ) NOT NULL,

    estado_pago ENUM(
        'PENDIENTE',
        'PAGADO',
        'FALLIDO'
    ) DEFAULT 'PENDIENTE',

    fecha_pago DATETIME,

    comision_plataforma DECIMAL(10,2) DEFAULT 0.00,

    FOREIGN KEY (id_reserva)
        REFERENCES reservas(id_reserva)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: membresias
-- =========================================================

CREATE TABLE membresias (
    id_membresia INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    precio DECIMAL(10,2) NOT NULL,

    duracion_dias INT NOT NULL,

    beneficios TEXT,

    tipo_usuario ENUM(
        'CLIENTE',
        'NANA'
    ) NOT NULL
);

-- =========================================================
-- TABLA: suscripciones
-- =========================================================

CREATE TABLE suscripciones (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,
    id_membresia INT NOT NULL,

    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,

    estado ENUM(
        'ACTIVA',
        'VENCIDA',
        'CANCELADA'
    ) DEFAULT 'ACTIVA',

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_membresia)
        REFERENCES membresias(id_membresia)
);

-- =========================================================
-- TABLA: verificaciones
-- =========================================================

CREATE TABLE verificaciones (
    id_verificacion INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    tipo_verificacion ENUM(
        'DNI',
        'UNIVERSIDAD',
        'TELEFONO',
        'CORREO',
        'ANTECEDENTES'
    ) NOT NULL,

    estado ENUM(
        'PENDIENTE',
        'APROBADO',
        'RECHAZADO'
    ) DEFAULT 'PENDIENTE',

    archivo_url VARCHAR(500),

    fecha_verificacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: reviews
-- =========================================================

CREATE TABLE reviews (
    id_review INT AUTO_INCREMENT PRIMARY KEY,

    id_reserva INT NOT NULL UNIQUE,

    id_cliente INT NOT NULL,
    id_nana INT NOT NULL,

    puntuacion INT NOT NULL,

    comentario TEXT,

    fecha_review DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_reserva)
        REFERENCES reservas(id_reserva)
        ON DELETE CASCADE,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
);

-- =========================================================
-- TABLA: favoritos
-- =========================================================

CREATE TABLE favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,
    id_nana INT NOT NULL,

    fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE,

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: chats
-- =========================================================

CREATE TABLE chats (
    id_chat INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,
    id_nana INT NOT NULL,

    fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
);

-- =========================================================
-- TABLA: mensajes
-- =========================================================

CREATE TABLE mensajes (
    id_mensaje INT AUTO_INCREMENT PRIMARY KEY,

    id_chat INT NOT NULL,

    id_remitente INT NOT NULL,

    mensaje TEXT NOT NULL,

    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,

    leido BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (id_chat)
        REFERENCES chats(id_chat)
        ON DELETE CASCADE,

    FOREIGN KEY (id_remitente)
        REFERENCES usuarios(id_usuario)
);

-- =========================================================
-- TABLA: reportes
-- =========================================================

CREATE TABLE reportes (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario_reporta INT NOT NULL,
    id_usuario_reportado INT NOT NULL,

    motivo ENUM(
        'ACOSO',
        'FRAUDE',
        'INCUMPLIMIENTO',
        'MAL_COMPORTAMIENTO',
        'OTRO'
    ) NOT NULL,

    descripcion TEXT NOT NULL,

    estado ENUM(
        'PENDIENTE',
        'REVISANDO',
        'RESUELTO',
        'RECHAZADO'
    ) DEFAULT 'PENDIENTE',

    fecha_reporte DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario_reporta)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_usuario_reportado)
        REFERENCES usuarios(id_usuario)
);

-- =========================================================
-- TABLA: disponibilidad_horarios
-- =========================================================

CREATE TABLE disponibilidad_horarios (
    id_disponibilidad INT AUTO_INCREMENT PRIMARY KEY,

    id_nana INT NOT NULL,

    dia_semana ENUM(
        'LUNES',
        'MARTES',
        'MIERCOLES',
        'JUEVES',
        'VIERNES',
        'SABADO',
        'DOMINGO'
    ) NOT NULL,

    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    disponible BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_nana)
        REFERENCES nanas(id_nana)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: notificaciones
-- =========================================================

CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    titulo VARCHAR(150) NOT NULL,

    mensaje TEXT NOT NULL,

    tipo ENUM(
        'RESERVA',
        'PAGO',
        'MENSAJE',
        'SISTEMA',
        'MEMBRESIA'
    ) NOT NULL,

    leida BOOLEAN DEFAULT FALSE,

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: ubicaciones_tiempo_real
-- =========================================================

CREATE TABLE ubicaciones_tiempo_real (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    latitud DECIMAL(10,8) NOT NULL,
    longitud DECIMAL(11,8) NOT NULL,

    precision_metros DECIMAL(10,2),

    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: archivos_usuario
-- =========================================================

CREATE TABLE archivos_usuario (
    id_archivo INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    tipo_archivo ENUM(
        'DNI',
        'CERTIFICADO',
        'FOTO_PERFIL',
        'ANTECEDENTES',
        'CARNET_UNIVERSITARIO',
        'OTRO'
    ) NOT NULL,

    nombre_archivo VARCHAR(255) NOT NULL,

    archivo_url VARCHAR(500) NOT NULL,

    fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: soporte_tickets
-- =========================================================

CREATE TABLE soporte_tickets (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    asunto VARCHAR(255) NOT NULL,

    descripcion TEXT NOT NULL,

    estado ENUM(
        'ABIERTO',
        'EN_PROCESO',
        'CERRADO'
    ) DEFAULT 'ABIERTO',

    prioridad ENUM(
        'BAJA',
        'MEDIA',
        'ALTA'
    ) DEFAULT 'MEDIA',

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
);

-- =========================================================
-- TABLA: logs_sistema
-- =========================================================

CREATE TABLE logs_sistema (
    id_log INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT,

    accion VARCHAR(255) NOT NULL,

    descripcion TEXT,

    ip_usuario VARCHAR(45),

    fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE SET NULL
);

-- =========================================================
-- ÍNDICES
-- =========================================================

CREATE INDEX idx_usuarios_correotipo_usuario
ON usuarios(correo);

CREATE INDEX idx_usuarios_dni
ON usuarios(dni);

CREATE INDEX idx_nanas_rating
ON nanas(rating_promedio);

CREATE INDEX idx_reviews_puntuacion
ON reviews(puntuacion);

CREATE INDEX idx_reservas_estado
ON reservas(estado_reserva);

CREATE INDEX idx_direcciones_ubicacion
ON direcciones(latitud, longitud);

-- =========================================================
-- DATOS INICIALES
-- =========================================================

INSERT INTO especialidades (nombre)
VALUES
('Cuidado de bebés'),
('Cuidado de niños'),
('Cuidado de adultos mayores'),
('Apoyo escolar'),
('Primeros auxilios'),
('Niños especiales');

select * from nanas;

INSERT INTO membresias (
    nombre,
    precio,
    duracion_dias,
    beneficios,
    tipo_usuario
)
VALUES
(
    'Premium Cliente',
    29.90,
    30,
    'Contactos ilimitados y prioridad',
    'CLIENTE'
),
(
    'Premium Nana',
    19.90,
    30,
    'Perfil destacado y mayor visibilidad',
    'NANA'
);


ALTER TABLE usuarios 
ADD COLUMN tipo_usuario_new ENUM('CLIENTE','NANA','ADMIN');
SET SQL_SAFE_UPDATES = 0;
UPDATE usuarios 
SET tipo_usuario_new = 'CLIENTE';

ALTER TABLE usuarios 
DROP COLUMN tipo_usuario;

ALTER TABLE usuarios 
CHANGE tipo_usuario_new tipo_usuario ENUM('CLIENTE','NANA','ADMIN') NOT NULL;

SELECT * FROM universidades;
-- =========================
-- 2. ARREGLAR fecha_registro
-- =========================
ALTER TABLE usuarios 
ADD COLUMN fecha_registro_new DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE usuarios 
DROP COLUMN fecha_registro;

ALTER TABLE usuarios 
CHANGE fecha_registro_new fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP;


-- =========================
-- 3. ARREGLAR estado_cuenta (opcional pero recomendado)
-- =========================
ALTER TABLE usuarios 
MODIFY estado_cuenta ENUM('ACTIVA','SUSPENDIDA','PENDIENTE') 
DEFAULT 'PENDIENTE';

ALTER TABLE usuarios
MODIFY fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP;
USE bd_nanas;
SELECT * FROM universidades;
USE bd_nanas;

INSERT INTO universidades
(nombre, siglas, tipo, departamento, provincia)
VALUES
('Universidad Tecnológica del Perú','UTP','Privada','Lima','Lima'),
('Universidad Peruana de Ciencias Aplicadas','UPC','Privada','Lima','Lima'),
('Pontificia Universidad Católica del Perú','PUCP','Privada','Lima','Lima'),
('Universidad Nacional Mayor de San Marcos','UNMSM','Pública','Lima','Lima');
USE bd_nanas;
SELECT id_usuario,
       nombre,
       correo,
       tipo_usuario
FROM usuarios;
SELECT id_nana,
       disponibilidad
FROM nanas;
select*from nanas;
SELECT id_universidad, nombre
FROM universidades;

select*from clientes;