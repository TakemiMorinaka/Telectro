-- 1. Insertar la encuesta principal
INSERT INTO encuestas (nombre, descripcion, usuario_creador_id, estado)
VALUES (
    'Ficha de Recojo de Información sobre Necesidades de Cuidados',
    'En julio del presente año se presento el Plan local de Cuidados 2024-2026 a la Municipalidad distrital de Villa el Salvador, con el objetivo de impulsar políticas y servicios de cuidado en Cerro Papa, entre otros territorios. Por eso, estamos entrevistando a la persona que cuida a niños, niñas, personas adultas mayores, personas con discapacidad para conocer las necesidades de cuidado que tienen. La información que nos brinde se mantendrá en reserva',
    NULL,	
    'activo'
);

-- 2. Insertar preguntas en banco_preguntas (solo preguntas clave como ejemplo)
INSERT INTO banco_preguntas (pregunta_id,texto, tipo) VALUES
(1,'Fecha de la entrevista:', 'abierta'),
(2,'Nombres y apellidos de la persona que encuesta:', 'abierta'),
(3,'Nombre del asentamiento humano:', 'abierta'),
(4,'Sector:', 'abierta'),
(5,'Nombres y apellidos:', 'abierta'),
(6,'Edad:', 'numerica'),
(7,'Dirección:', 'abierta'),
(8,'Celular (opcional):', 'abierta'),
(9,'¿Hay niños/niñas de 0 a 5 años en el hogar?', 'opcion_unica'),	   
(10,'¿Asisten a una guardería o preescolar? (Marcar solo una opción)', 'opcion_unica'),
(11,'¿Cuántos niños/niñas de 0 a 5 años hay en el hogar?', 'opcion_unica'),
(12,'¿Por qué no usa guarderías o centros de cuidado?', 'opcion_multiple'),
(13,'¿Hay personas adultas mayores en el hogar?', 'opcion_unica'),
(14,'¿Padecen alguna enfermedad?', 'abierta'), -- No especifica si es responder sí o no nada más.
(15,'¿Cuántas personas adultas mayores hay en el hogar?', 'abierta'),
(16,'¿Usan apoyos para movilizarse como sillas de rueda, bastón, muletas?', 'opcion_unica'),
(17,'¿Hay personas con discapacidad o enfermedad crónica en el hogar? (Marcar solo una opción)', 'opcion_unica'),
(18,'¿Qué tipo de discapacidad o enfermedad tienen?', 'abierta'),
(19,'¿Tienen carnet CONADIS? (Marcar solo una opción)', 'opcion_unica'),
(20,'¿Hay personas con discapacidad o enfermedad crónica en el hogar? (Marcar solo una opción)', 'opcion_unica');

-- 3. Insertar opciones para preguntas de selección múltiple (Ejemplo para pregunta 3)
INSERT INTO pregunta_opciones (pregunta_id, texto_opcion, orden) VALUES
(12, 'A. No hay una cerca a su casa', 1),
(12, 'B. Prefiere cuidar personalmente', 2),
(12, 'C. No puedo pagar', 3),
(12, 'D. No confío en las guarderías', 4),
(12, 'E. Pago a alguien para que cuide dentro de mi casa', 5),
(12, 'F. Otro motivo', 6);

-- 4. Relacionar preguntas con la encuesta y establecer orden
INSERT INTO preguntas_encuesta (encuesta_id, pregunta_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20);


-- 6. Ejemplo de insert para una respuesta
INSERT INTO respuestas (encuesta_id, encuestador_id, dni_encuestado, estado) 
VALUES (1, 26, '73456789', 'borrador');