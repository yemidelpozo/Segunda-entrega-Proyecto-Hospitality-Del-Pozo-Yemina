USE reservas_actividades_hospitality;

DROP PROCEDURE IF EXISTS actualizar_reserva_cancelada_por_email;
DROP PROCEDURE IF EXISTS actualizar_tipo_reserva_por_email;
DROP PROCEDURE IF EXISTS crear_empleado;

DELIMITER //

CREATE PROCEDURE actualizar_reserva_cancelada_por_email(
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE cliente_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT Id_cliente INTO cliente_id
        FROM CLIENTES
    WHERE Email = p_email;
    
    -- Actualizar la reserva si el cliente existe y tenía una reserva cancelada
    IF cliente_id IS NOT NULL THEN
        UPDATE RESERVAS
        SET Cancelacion = NULL,
            Fecha = NOW()
        WHERE Id_cliente = cliente_id
        AND Cancelacion IS NOT NULL;
        
        SELECT 'La reserva cancelada del cliente con correo electrónico ', p_email, ' ha sido actualizada exitosamente.';
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', p_email, '.';
    END IF;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE actualizar_tipo_reserva_por_email(
    IN p_email VARCHAR(100),
    IN p_nuevo_tipo VARCHAR(50)
)
BEGIN
    DECLARE cliente_id INT;
    DECLARE reserva_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT Id_cliente INTO cliente_id
    FROM CLIENTES
    WHERE Correo = p_email;
    
    -- Si se encontró el cliente, obtener la última reserva hecha
    IF cliente_id IS NOT NULL THEN
        SELECT Id_reserva INTO reserva_id
        FROM RESERVAS
        WHERE Id_cliente = cliente_id
        ORDER BY Fecha DESC
        LIMIT 1;
        
        -- Si se encontró la reserva, actualizar el tipo de reserva
        IF reserva_id IS NOT NULL THEN
            UPDATE RESERVAS
            SET Id_tiporeserva = (
                SELECT Id_tiporeserva FROM TIPO_RESERVA WHERE Tipo = p_nuevo_tipo
            ) , Fecha = NOW()
            WHERE Id_reserva = reserva_id;
            
            SELECT 'Se actualizó el tipo de reserva del cliente con correo electrónico ', p_email, ' a ', p_nuevo_tipo, '.';
        ELSE
            SELECT 'El cliente con correo electrónico ', p_email, ' no tiene reservas.';
        END IF;
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', p_email, '.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE crear_empleado(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_Email VARCHAR(100),
    IN p_id_actividad INT
)
BEGIN
    DECLARE actividad_count INT;
    
    -- Verificar si la actividad existe
    SELECT COUNT(*) INTO actividad_count
    FROM ACTIVIDADES
    WHERE Id_actividad = p_id_actividad;
    
    -- Si la actividad existe, insertar el empleado
    IF actividad_count > 0 THEN
        INSERT INTO EMPLEADOS (Nombre, Telefono, Email, Id_actividad)
        VALUES (p_nombre, p_telefono, p_Email, p_id_actividad);
        
        SELECT 'Empleado creado exitosamente.';
    ELSE
        SELECT 'La actividad especificada no existe. No se puede crear el empleado.';
    END IF;
END //

DELIMITER ;



