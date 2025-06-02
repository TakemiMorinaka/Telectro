-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema onu_mujeres
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema onu_mujeres
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `onu_mujeres` DEFAULT CHARACTER SET utf8mb4 ;
USE `onu_mujeres` ;

use onu_mujeres;
DROP TABLE IF EXISTS `token_generado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_generado` (
  `id_tokens` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `token` varchar(6) NOT NULL,
  PRIMARY KEY (`id_tokens`),
  KEY `fk_Tokens generados_Usuarios1_idx` (`usuario_id`),
  CONSTRAINT `fk_Tokens generados_Usuarios1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- -----------------------------------------------------
-- Table `onu_mujeres`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`roles` (
  `rol_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`zonas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`zonas` (
  `zona_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`zona_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`distritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`distritos` (
  `distrito_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `zona_id` INT NOT NULL,
  PRIMARY KEY (`distrito_id`),
  UNIQUE INDEX `nombre` (`nombre` ASC) VISIBLE,
  INDEX `zona_id` (`zona_id` ASC) VISIBLE,
  CONSTRAINT `distritos_ibfk_1`
    FOREIGN KEY (`zona_id`)
    REFERENCES `onu_mujeres`.`zonas` (`zona_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`usuarios` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `rol_id` INT NULL DEFAULT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `apellido_paterno` VARCHAR(100) NULL DEFAULT NULL,
  `apellido_materno` VARCHAR(100) NULL DEFAULT NULL,
  `dni` CHAR(8) NULL DEFAULT NULL,
  `correo` VARCHAR(150) NULL DEFAULT NULL,
  `contrasena_hash` TEXT NULL DEFAULT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  `distrito_id` INT NULL DEFAULT NULL,
  `zona_id` INT NULL DEFAULT NULL,
  `codigo_unico_encuestador` VARCHAR(50) NULL DEFAULT NULL,
  `estado` ENUM('activo', 'baneado') NULL DEFAULT 'activo',
  `correo_verificado` TINYINT(1) NULL DEFAULT '0',
  `fecha_registro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_conexion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `profile_photo_url` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE INDEX `dni` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `correo` (`correo` ASC) VISIBLE,
  INDEX `rol_id` (`rol_id` ASC) VISIBLE,
  INDEX `distrito_id` (`distrito_id` ASC) VISIBLE,
  INDEX `zona_id` (`zona_id` ASC) VISIBLE,
  CONSTRAINT `usuarios_ibfk_1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `onu_mujeres`.`roles` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_2`
    FOREIGN KEY (`distrito_id`)
    REFERENCES `onu_mujeres`.`distritos` (`distrito_id`),
  CONSTRAINT `usuarios_ibfk_3`
    FOREIGN KEY (`zona_id`)
    REFERENCES `onu_mujeres`.`zonas` (`zona_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`banco_preguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`banco_preguntas` (
  `pregunta_id` INT NOT NULL AUTO_INCREMENT,
  `texto` TEXT NULL DEFAULT NULL,
  `tipo` ENUM('abierta', 'numerica', 'opcion_unica', 'opcion_multiple') NULL DEFAULT NULL,
  `usuario_creador_id` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pregunta_id`),
  INDEX `usuario_creador_id` (`usuario_creador_id` ASC) VISIBLE,
  CONSTRAINT `banco_preguntas_ibfk_1`
    FOREIGN KEY (`usuario_creador_id`)
    REFERENCES `onu_mujeres`.`usuarios` (`usuario_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`encuestas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`encuestas` (
  `encuesta_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `carpeta` VARCHAR(100) NULL DEFAULT NULL,
  `usuario_creador_id` INT NULL DEFAULT NULL,
  `estado` ENUM('activo', 'inactivo') NULL DEFAULT 'activo',
  `fecha_creacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`encuesta_id`),
  INDEX `usuario_creador_id` (`usuario_creador_id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `encuestas_ibfk_1`
    FOREIGN KEY (`usuario_creador_id`)
    REFERENCES `onu_mujeres`.`usuarios` (`usuario_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`encuestas_asignadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`encuestas_asignadas` (
  `asignacion_id` INT NOT NULL AUTO_INCREMENT,
  `encuesta_id` INT NOT NULL,
  `encuestador_id` INT NOT NULL,
  `coordinador_id` INT NOT NULL,
  `estado` ENUM('asignada', 'en_progreso', 'completada', 'cancelada') NULL DEFAULT NULL,
  `fecha_asignacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_completado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`asignacion_id`),
  INDEX `encuesta_id` (`encuesta_id` ASC) VISIBLE,
  INDEX `encuestador_id` (`encuestador_id` ASC) VISIBLE,
  INDEX `coordinador_id` (`coordinador_id` ASC) VISIBLE,
  CONSTRAINT `encuestas_asignadas_ibfk_1`
    FOREIGN KEY (`encuesta_id`)
    REFERENCES `onu_mujeres`.`encuestas` (`encuesta_id`),
  CONSTRAINT `encuestas_asignadas_ibfk_2`
    FOREIGN KEY (`encuestador_id`)
    REFERENCES `onu_mujeres`.`usuarios` (`usuario_id`),
  CONSTRAINT `encuestas_asignadas_ibfk_3`
    FOREIGN KEY (`coordinador_id`)
    REFERENCES `onu_mujeres`.`usuarios` (`usuario_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`logs_actividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`logs_actividades` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `accion` VARCHAR(100) NULL DEFAULT NULL,
  `entidad` VARCHAR(50) NULL DEFAULT NULL,
  `detalle` TEXT NULL DEFAULT NULL,
  `fecha_log` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  INDEX `usuario_id` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `logs_actividades_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `onu_mujeres`.`usuarios` (`usuario_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 55
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`pregunta_opciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`pregunta_opciones` (
  `opcion_id` INT NOT NULL AUTO_INCREMENT,
  `pregunta_id` INT NOT NULL,
  `texto_opcion` VARCHAR(255) NULL DEFAULT NULL,
  `valor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`opcion_id`),
  INDEX `pregunta_id` (`pregunta_id` ASC) VISIBLE,
  CONSTRAINT `pregunta_opciones_ibfk_1`
    FOREIGN KEY (`pregunta_id`)
    REFERENCES `onu_mujeres`.`banco_preguntas` (`pregunta_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`preguntas_encuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`preguntas_encuesta` (
  `encuesta_id` INT NOT NULL,
  `pregunta_id` INT NOT NULL,
  PRIMARY KEY (`encuesta_id`, `pregunta_id`),
  INDEX `pregunta_id` (`pregunta_id` ASC) VISIBLE,
  CONSTRAINT `preguntas_encuesta_ibfk_1`
    FOREIGN KEY (`encuesta_id`)
    REFERENCES `onu_mujeres`.`encuestas` (`encuesta_id`),
  CONSTRAINT `preguntas_encuesta_ibfk_2`
    FOREIGN KEY (`pregunta_id`)
    REFERENCES `onu_mujeres`.`banco_preguntas` (`pregunta_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`respuestas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`respuestas` (
  `respuesta_id` INT NOT NULL AUTO_INCREMENT,
  `asignacion_id` INT NULL DEFAULT NULL,
  `dni_encuestado` CHAR(8) NULL,
  `fecha_inicio` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_edicion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`respuesta_id`),
  INDEX `asignacion_id` (`asignacion_id` ASC) VISIBLE,
  UNIQUE INDEX `dni_encuestado_UNIQUE` (`dni_encuestado` ASC) VISIBLE,
  CONSTRAINT `respuestas_ibfk_3`
    FOREIGN KEY (`asignacion_id`)
    REFERENCES `onu_mujeres`.`encuestas_asignadas` (`asignacion_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `onu_mujeres`.`respuestas_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onu_mujeres`.`respuestas_detalle` (
  `detalle_id` INT NOT NULL AUTO_INCREMENT,
  `respuesta_id` INT NOT NULL,
  `pregunta_id` INT NOT NULL,
  `opcion_id` INT NULL DEFAULT NULL,
  `respuesta_texto` TEXT NULL DEFAULT NULL,
  `fecha_contestacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`detalle_id`),
  INDEX `respuesta_id` (`respuesta_id` ASC) VISIBLE,
  INDEX `pregunta_id` (`pregunta_id` ASC) VISIBLE,
  INDEX `opcion_id` (`opcion_id` ASC) VISIBLE,
  CONSTRAINT `respuestas_detalle_ibfk_1`
    FOREIGN KEY (`respuesta_id`)
    REFERENCES `onu_mujeres`.`respuestas` (`respuesta_id`),
  CONSTRAINT `respuestas_detalle_ibfk_2`
    FOREIGN KEY (`pregunta_id`)
    REFERENCES `onu_mujeres`.`banco_preguntas` (`pregunta_id`),
  CONSTRAINT `respuestas_detalle_ibfk_3`
    FOREIGN KEY (`opcion_id`)
    REFERENCES `onu_mujeres`.`pregunta_opciones` (`opcion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- USAR PARA LIMPIAR LOS REGISTROS DE LAS TABLAS, NO EJECUTAR 
 SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE roles;
TRUNCATE TABLE usuarios;
TRUNCATE TABLE banco_preguntas;
TRUNCATE TABLE distritos;
TRUNCATE TABLE encuestas;
TRUNCATE TABLE encuestas_asignadas;
TRUNCATE TABLE logs_actividades;
TRUNCATE TABLE zonas;
TRUNCATE TABLE respuestas;
TRUNCATE TABLE respuestas_detalle;
TRUNCATE TABLE preguntas_encuesta;
TRUNCATE TABLE pregunta_opciones;

-- ALGUNOS INSERTS DE PRUEBA

INSERT INTO roles (nombre) VALUES
('encuestador'),
('coordinador'),
('administrador');

INSERT INTO zonas (nombre) VALUES
('Norte'), ('Sur'), ('Este'), ('Oeste');

INSERT INTO distritos (nombre, zona_id) VALUES 
-- Zona Norte (zona_id = 1)
('Ancon', 1),
('Santa Rosa', 1),
('Carabayllo', 1),
('Puente Piedra', 1),
('Comas', 1),
('Los Olivos', 1),
('San Martín de Porres', 1),
('Independencia', 1),

-- Zona Sur (zona_id = 2)
('San Juan de Miraflores', 2),
('Villa María del Triunfo', 2),
('Villa el Salvador', 2),
('Pachacamac', 2),
('Lurin', 2),
('Punta Hermosa', 2),
('Punta Negra', 2),
('San Bartolo', 2),
('Santa María del Mar', 2),
('Pucusana', 2),

-- Zona Este (zona_id = 3)
('San Juan de Lurigancho', 3),
('Lurigancho/Chosica', 3),
('Ate', 3),
('El Agustino', 3),
('Santa Anita', 3),
('La Molina', 3),
('Cieneguilla', 3),

-- Zona Oeste (zona_id = 4)
('Rimac', 4),
('Cercado de Lima', 4),
('Breña', 4),
('Pueblo Libre', 4),
('Magdalena', 4),
('Jesus María', 4),
('La Victoria', 4),
('Lince', 4),
('San Isidro', 4),
('San Miguel', 4),
('Surquillo', 4),
('San Borja', 4),
('Santiago de Surco', 4),
('Barranco', 4),
('Chorrillos', 4),
('San Luis', 4),
('Miraflores', 4);


-- LLENADO DE DATA PARA USUARIOS
-- Administradores (2)
INSERT INTO usuarios (rol_id, nombre, apellido_paterno, apellido_materno, dni, correo, contrasena_hash, direccion, distrito_id, zona_id, codigo_unico_encuestador, estado, correo_verificado, fecha_registro, ultima_conexion) VALUES
(3, 'Ana', 'García', 'López', '12345678', 'admin1@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Universitaria 1801', 22, 4, NULL, 'activo', 1, '2025-01-10 09:00:00', '2025-04-29 10:30:00'),
(3, 'Carlos', 'Martínez', 'Rodríguez', '87654321', 'admin2@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Salaverry 1234', 30, 4, NULL, 'activo', 1, '2025-01-10 09:05:00', '2025-04-29 11:45:00');

-- Coordinadores (1 por distrito - 44 en total)
INSERT INTO usuarios (rol_id, nombre, apellido_paterno, apellido_materno, dni, correo, contrasena_hash, direccion, distrito_id, zona_id, codigo_unico_encuestador, estado, correo_verificado, fecha_registro, ultima_conexion) VALUES
-- Zona Norte (distritos 1-8)
(2, 'Luis', 'Torres', 'Mendoza', '23456781', 'coor.ancon@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Ancón 456', 1, 1, NULL, 'activo', 1, '2025-02-01 08:00:00', '2025-04-28 17:00:00'),
(2, 'María', 'Silva', 'Vega', '23456782', 'coor.santarosa@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Las Palmeras 123', 2, 1, NULL, 'activo', 1, '2025-02-01 08:05:00', '2025-04-28 16:30:00'),
(2, 'Jorge', 'Quispe', 'Huamán', '23456783', 'coor.carabayllo@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. Carabayllo 789', 3, 1, NULL, 'activo', 1, '2025-02-01 08:10:00', '2025-04-28 16:45:00'),
(2, 'Rosa', 'Díaz', 'Peralta', '23456784', 'coor.puentepiedra@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Puente Piedra 321', 4, 1, NULL, 'activo', 1, '2025-02-01 08:15:00', '2025-04-28 17:15:00'),
(2, 'Pedro', 'Castillo', 'Rojas', '23456785', 'coor.comas@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Los Olivos 654', 5, 1, NULL, 'activo', 1, '2025-02-01 08:20:00', '2025-04-28 16:20:00'),
(2, 'Lucía', 'Fernández', 'Gómez', '23456786', 'coor.losolivos@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Los Pinos 456', 6, 1, NULL, 'activo', 1, '2025-02-01 08:25:00', '2025-04-28 17:30:00'),
(2, 'Juan', 'Pérez', 'Sánchez', '23456787', 'coor.sanmartin@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. San Martín 789', 7, 1, NULL, 'activo', 1, '2025-02-01 08:30:00', '2025-04-28 16:50:00'),
(2, 'Carmen', 'Vargas', 'Ruiz', '23456788', 'coor.independencia@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Túpac Amaru 321', 8, 1, NULL, 'activo', 1, '2025-02-01 08:35:00', '2025-04-28 17:10:00'),

-- Ejemplo para 2 distritos más:
(2, 'Sofía', 'López', 'Hernández', '23456789', 'coor.sanjuanmiraflores@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Primavera 987', 9, 2, NULL, 'activo', 1, '2025-02-01 08:40:00', '2025-04-28 16:40:00'),
(2, 'Miguel', 'González', 'Díaz', '23456790', 'coor.villamaria@onumujeres.org', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Las Flores 654', 10, 2, NULL, 'activo', 1, '2025-02-01 08:45:00', '2025-04-28 17:20:00'),

-- Encuestadores (14 - variando estados)
(1, 'Roberto', 'Castro', 'Mendoza', '34567891', 'encuestador1@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. Lima 123', 1, 1, 'ENC-2025-001', 'activo', 1, '2025-03-01 08:00:00', '2025-04-29 09:30:00'),
(1, 'Patricia', 'Salazar', 'Vega', '34567892', 'encuestador2@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Brasil 456', 5, 1, 'ENC-2025-002', 'activo', 1, '2025-03-01 08:05:00', '2025-04-29 10:15:00'),
(1, 'Javier', 'Ríos', 'Paredes', '34567893', 'encuestador3@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Los Girasoles 789', 9, 2, 'ENC-2025-003', 'activo', 1, '2025-03-01 08:10:00', '2025-04-20 11:00:00'),
(1, 'Luisa', 'Morales', 'Quispe', '34567894', 'encuestador4@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Los Jardines 321', 15, 2, 'ENC-2025-004', 'baneado', 1, '2025-03-01 08:15:00', '2025-04-15 14:30:00'),
(1, 'Oscar', 'Delgado', 'Fuentes', '34567895', 'encuestador5@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. Las Orquídeas 654', 22, 4, 'ENC-2025-005', 'activo', 1, '2025-03-01 08:20:00', '2025-04-29 08:45:00'),
(1, 'Gabriela', 'Valdivia', 'Zapata', '34567896', 'encuestador6@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Los Pinos 987', 26, 3, 'ENC-2025-006', 'activo', 0, '2025-03-01 08:25:00', '2025-04-28 12:20:00'),
(1, 'Fernando', 'Paredes', 'Rojas', '34567897', 'encuestador7@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Las Margaritas 123', 30, 4, 'ENC-2025-007', 'baneado', 1, '2025-03-01 08:30:00', '2025-04-18 10:15:00'),
(1, 'Daniela', 'Córdova', 'Silva', '34567898', 'encuestador8@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Los Alamos 456', 5, 1, 'ENC-2025-008', 'activo', 1, '2025-03-01 08:35:00', '2025-04-29 11:30:00'),
(1, 'Ricardo', 'Mendoza', 'López', '34567899', 'encuestador9@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. Las Azucenas 789', 10, 2, 'ENC-2025-009', 'baneado', 1, '2025-03-01 08:40:00', '2025-04-10 15:45:00'),
(1, 'Silvia', 'Aguilar', 'Torres', '34567900', 'encuestador10@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Las Camelias 321', 15, 2, 'ENC-2025-010', 'activo', 1, '2025-03-01 08:45:00', '2025-04-29 09:15:00'),
(1, 'Hugo', 'Vera', 'Gutiérrez', '34567901', 'encuestador11@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Calle Los Tulipanes 654', 22, 4, 'ENC-2025-011', 'activo', 1, '2025-03-01 08:50:00', '2025-04-22 16:20:00'),
(1, 'Valeria', 'Rivas', 'Castro', '34567902', 'encuestador12@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Las Rosas 987', 26, 3, 'ENC-2025-012', 'activo', 1, '2025-03-01 08:55:00', '2025-04-29 10:45:00'),
(1, 'Eduardo', 'Salas', 'Méndez', '34567903', 'encuestador13@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Jr. Las Hortensias 123', 30, 4, 'ENC-2025-013', 'baneado', 0, '2025-03-01 09:00:00', '2025-04-05 11:30:00'),
(1, 'Camila', 'Tello', 'Paz', '34567904', 'encuestador14@example.com', '$2a$10$xJwL5v5z5U6U5U6U5U6U5e', 'Av. Las Gardenias 456', 5, 1, 'ENC-2025-014', 'activo', 1, '2025-03-01 09:05:00', '2025-04-29 09:45:00');




-- -----------------------------------------
-- LLENADO DE DATA PARA LOGS
INSERT INTO logs_actividades (usuario_id, accion, entidad, detalle, fecha_log) VALUES
-- Actividades de administradores (usuarios 1-2)
(1, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-01 08:15:23'),
(1, 'crear_usuario', 'usuarios', 'Creó nuevo coordinador: Luis Torres', '2025-04-01 09:30:45'),
(2, 'login', 'sistema','Inicio de sesión exitoso', '2025-04-01 10:05:12'),
(2, 'actualizar_rol', 'usuarios', 'Cambió rol de usuario ID 15 a encuestador', '2025-04-01 11:20:33'),

-- Actividades de coordinadores (usuarios 3-26)
(3, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-02 07:45:11'),
(3, 'asignar_formulario', 'formularios', 'Asignó formulario ID 5 a encuestador ID 15', '2025-04-02 09:15:22'),
(4, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-02 08:30:09'),
(4, 'subir_csv', 'formularios', 'Carga masiva de 25 respuestas vía CSV', '2025-04-02 10:45:17'),
(5, 'login', 'sistema', 'Inicio de sesión fallido - contraseña incorrecta', '2025-04-03 07:50:33'),
(5, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-03 07:51:45'),
(6, 'banear_usuario', 'usuarios', 'Baneó al encuestador ID 18 por incumplimiento', '2025-04-03 14:20:08'),
(7, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-04 08:10:55'),
(7, 'crear_formulario', 'formularios', 'Creó nuevo formulario para encuesta de violencia', '2025-04-04 10:30:42'),
(8, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-04 09:05:27'),
(9, 'actualizar_perfil', 'usuarios', 'Actualizó su foto de perfil', '2025-04-05 11:15:38'),
(10, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-05 13:25:19'),
(10, 'generar_reporte', 'reportes', 'Generó reporte de respuestas por distrito', '2025-04-05 14:40:05'),

-- Actividades de encuestadores (usuarios 15-26)
(15, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-06 06:30:47'),
(15, 'completar_formulario', 'respuestas', 'Completó formulario ID 5 para encuestado DNI 87654321', '2025-04-06 07:45:12'),
(16, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-06 08:20:33'),
(16, 'guardar_borrador', 'respuestas', 'Guardó borrador de formulario ID 7 (50% completado)', '2025-04-06 09:35:44'),
(17, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-07 10:15:28'),
(17, 'completar_formulario', 'respuestas', 'Completó formulario ID 3 para encuestado DNI 76543210', '2025-04-07 11:30:19'),
(18, 'login', 'sistema','Intento de acceso denegado (usuario baneado)', '2025-04-07 12:45:37'),
(19, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-08 07:25:14'),
(19, 'actualizar_perfil', 'usuarios', 'Cambió su dirección y distrito', '2025-04-08 08:40:22'),
(20, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-08 13:15:08'),
(20, 'completar_formulario', 'respuestas', 'Completó formulario ID 8 para encuestado DNI 65432109', '2025-04-08 14:30:45'),

-- Más actividades variadas
(3, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-09 08:05:33'),
(3, 'revisar_respuestas', 'respuestas', 'Revisó 15 respuestas del distrito', '2025-04-09 10:20:17'),
(12, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-09 09:15:42'),
(12, 'exportar_datos', 'reportes','Exportó datos a Excel (250 registros)', '2025-04-09 11:30:28'),
(21, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-10 06:40:19'),
(21, 'completar_formulario', 'respuestas', 'Completó formulario ID 2 para encuestado DNI 54321098', '2025-04-10 07:55:37'),
(4, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-10 08:30:11'),
(4, 'actualizar_formulario', 'formularios', 'Actualizó preguntas del formulario ID 5', '2025-04-10 10:45:23'),
(22, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-11 12:20:54'),
(22, 'guardar_borrador', 'respuestas', 'Guardó borrador de formulario ID 4 (30% completado)', '2025-04-11 13:35:42'),
(5, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-11 14:10:28'),
(5, 'activar_formulario', 'formularios', 'Activó formulario ID 9 para su distrito', '2025-04-11 15:25:17'),
(23, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-12 07:15:39'),
(23, 'completar_formulario', 'respuestas', 'Completó formulario ID 6 para encuestado DNI 43210987', '2025-04-12 08:30:45'),
(6, 'login', 'sistema','Inicio de sesión exitoso', '2025-04-12 09:05:22'),
(6, 'desactivar_usuario', 'usuarios', 'Desactivó temporalmente al encuestador ID 20', '2025-04-12 11:20:33'),
(24, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-13 10:40:18'),
(24, 'completar_formulario', 'respuestas', 'Completó formulario ID 1 para encuestado DNI 32109876', '2025-04-13 11:55:27'),
(7, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-13 13:30:44'),
(7, 'crear_carpeta', 'formularios', 'Creó carpeta "Encuestas Q2-2025"', '2025-04-13 14:45:39'),
(25, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-14 08:20:15'),
(25, 'actualizar_perfil', 'usuarios', 'Cambió su foto de perfil', '2025-04-14 09:35:24'),
(8, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-14 10:10:33'),
(8, 'revisar_encuestadores', 'usuarios', 'Revisó listado de encuestadores activos', '2025-04-14 12:25:41'),
(26, 'login', 'sistema', 'Inicio de sesión exitoso', '2025-04-15 07:45:29'),
(26, 'completar_formulario', 'respuestas', 'Completó formulario ID 10 para encuestado DNI 21098765', '2025-04-15 09:00:38');


-- Insertar la encuesta principal
INSERT INTO encuestas (nombre, descripcion, carpeta, estado, fecha_creacion) VALUES 
('Ficha de Recojo de Información sobre Necesidades de Cuidados', 'En julio del presente año se presento el Plan local de Cuidados 2024-2026 a la Municipalidad distrital de Villa el Salvador, con el objetivo de impulsar políticas y servicios de cuidado en Cerro Papa, entre otros territorios. Por eso, estamos entrevistando a la persona que cuida a niños, niñas, personas adultas mayores, personas con discapacidad para conocer las necesidades de cuidado que tienen. La información que nos brinde se mantendrá en reserva', NULL, 'activo', '2024-03-01 11:00:00'),
('Bienestar de la Mujer Rural', 'Encuesta sobre acceso a recursos y oportunidades para mujeres en zonas rurales.', 'rural', 'activo', '2024-04-01 10:00:00'),
('Participación Política Femenina', 'Análisis de la involucración de mujeres en procesos políticos locales.', 'politica', 'activo', '2024-04-15 11:30:00'),
('Educación y Género', 'Percepción sobre igualdad de género en el ámbito educativo.', 'educacion', 'activo', '2024-04-20 09:45:00'),
('Violencia de Género', 'Estudio sobre la prevalencia y tipos de violencia que enfrentan las mujeres.', 'violencia', 'activo', '2024-05-01 14:00:00'),
('Emprendimiento Femenino', 'Encuesta a mujeres emprendedoras sobre desafíos y éxitos.', 'emprendimiento', 'activo', '2024-05-05 16:20:00');

INSERT INTO banco_preguntas (texto, tipo) VALUES
-- A
('Fecha de la entrevista', 'abierta'),
('Nombres y apellidos de la persona que encuesta', 'abierta'),

-- B
('Nombre del asentamiento humano', 'abierta'),
('Sector', 'abierta'),

-- C
('Nombres y apellidos', 'abierta'),
('Dirección', 'abierta'),
('Celular (opcional)', 'abierta'),
('Edad', 'numerica'),

-- D
-- 9
('¿Hay niños/niñas de 0 a 5 años en el hogar?', 'opcion_unica'),
('¿Cuántos niños/niñas de 0 a 5 años hay en el hogar?', 'numerica'),
-- 11
('¿Asisten a una guardería o preescolar?', 'opcion_unica'),
-- 12
('¿Por qué no usa guarderías o centros de cuidado?', 'opcion_unica'),


-- E
-- 13
('¿Hay personas adultas mayores en el hogar?', 'opcion_unica'),
('¿Cuántas personas adultas mayores hay en el hogar?', 'numerica'),
('¿Padecen alguna enfermedad?', 'abierta'),
-- 16
('¿Usan apoyos para movilizarse como sillas de rueda, bastón, muletas?', 'opcion_unica'),

-- F
-- 17
('¿Hay personas con discapacidad o enfermedad crónica en el hogar?', 'opcion_unica'),
('¿Cuántas personas con discapacidad o con enfermedad crónica hay en el hogar?', 'numerica'),
('¿Qué tipo de discapacidad o enfermedad tienen?', 'abierta'),
-- 20
('¿Tienen carnet CONADIS?', 'opcion_unica'),

-- G
-- 21
('¿Alguna persona integrante de su hogar se dedica al trabajo doméstico remunerado?', 'opcion_unica'),
('¿Qué edad tiene?', 'numerica'),
-- 23
('¿Actualmente está contratada (tiene contrato formal) en la casa donde trabaja?', 'opcion_unica'),
-- 24
('¿Participa en algún sindicato u organización?', 'opcion_unica'),

-- H
('¿Cuánto tiempo al día le dedica al cuidado (lavar, planchar, cocinar, criar, cuidar enfermos/as, etc.)?', 'numerica'),
-- 26
('¿Conoce los servicios de cuidados: cuna más, OMAPED, CIAM, etc.?', 'opcion_unica'),
-- 27
('¿Usted realiza algún trabajo remunerado fuera de casa?', 'opcion_unica'),
-- 28
('¿Usted tiene algún emprendimiento (negocio)?', 'opcion_unica'),

-- OBS
('Registrar todas las incidencias en la aplicación de la ficha o información complementaria. Enumere las preguntas si recurre a esta opción.', 'abierta');

-- Insertar opciones para preguntas de selección múltiple (Ejemplo para pregunta 4)
INSERT INTO pregunta_opciones (pregunta_id, texto_opcion) VALUES
(9, 'Sí'),
(9, 'No'),
(11, 'Sí'),
(11, 'No'),
(12, 'A. No hay una cerca a su casa'),
(12, 'B. Prefiere cuidar personalmente'),
(12, 'C. No puedo pagar'),
(12, 'D. No confío en las guarderías'),
(12, 'E. Pago a alguien para que cuide dentro de mi casa'),
(12, 'F. Otro motivo'),
(13, 'Sí'),
(13, 'No'),
(16, 'Sí'),
(16, 'No'),
(17, 'Sí'),
(17, 'No'),
(20, 'Sí'),
(20, 'No'),
(21, 'Sí'),
(21, 'No'),
(23, 'Sí'),
(23, 'No'),
(24, 'Sí'),
(24, 'No'),
(26, 'Sí'),
(26, 'No'),
(27, 'Sí'),
(27, 'No'),
(28, 'Sí'),
(28, 'No');


INSERT INTO preguntas_encuesta (encuesta_id, pregunta_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29);

-- hasta enc_id = 26
INSERT INTO encuestas_asignadas (encuesta_id, encuestador_id, coordinador_id, estado, fecha_asignacion, fecha_completado) VALUES
(1, 15, 6, 'completada', '2024-04-02 10:00:00', '2024-04-25 15:30:00'),
(1, 16, 6,'en_progreso', '2024-04-16 12:00:00', NULL),
(1, 17, 7,'en_progreso', '2024-04-22 09:00:00', NULL),
(1, 15, 5,'asignada', '2024-05-02 14:30:00', '2024-05-18 11:00:00'),
(1, 15, 6,'asignada', '2024-05-06 17:00:00', NULL);




SET FOREIGN_KEY_CHECKS = 1;