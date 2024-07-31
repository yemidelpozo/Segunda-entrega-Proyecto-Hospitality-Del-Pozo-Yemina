USE reservas_actividades_hospitality;

DROP FUNCTION IF EXISTS contar_reservas_cliente;
DROP FUNCTION IF EXISTS reservas_por_empleado;
DROP FUNCTION IF EXISTS actividad_cancelada;

-- Función para contar las reservas de un cliente entre determinadas fechas:

DELIMITER //

CREATE FUNCTION contar_reservas_cliente(cliente_id INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE reservas_count INT;
    
    SELECT COUNT(*) INTO reservas_count
    FROM RESERVAS
    WHERE Id_cliente = cliente_id
    AND Fecha >= fecha_inicio
    AND Fecha <= fecha_fin;
    
    RETURN reservas_count;
END //

DELIMITER ;

-- Función para contar la cantidad de reservas en las que está involucrado un empleado, dentro de un período de tiempo:

DELIMITER //

CREATE FUNCTION reservas_por_empleado (empleado_id INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE reservas_count INT;
    
    SELECT COUNT(*) INTO reservas_count
    FROM RESERVAS
    WHERE Id_empleado = empleado_id
    AND Fecha >= fecha_inicio
    AND Fecha <= fecha_fin;
    
    RETURN reservas_count;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION actividad_cancelada(actividad_id INT) RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cancelacion_date DATETIME;
    DECLARE is_cancelada BOOLEAN;
    
    SELECT Cancelacion INTO cancelacion_date
        FROM RESERVAS
        WHERE Id_actividad = actividad_id
        AND Cancelacion IS NOT NULL
        LIMIT 1;
	
    
    IF cancelacion_date IS NOT NULL THEN
        SET is_cancelada = TRUE;
    ELSE
        SET is_cancelada = FALSE;
    END IF;

    RETURN is_cancelada;
END //

DELIMITER ;



