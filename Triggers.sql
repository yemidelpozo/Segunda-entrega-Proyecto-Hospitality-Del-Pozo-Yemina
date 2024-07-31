USE reservas_actividades_hospitality;

-- Trigger para registrar la inserción de un nuevo cliente en la tabla LOG_CAMBIOS.

CREATE TABLE LOG_CAMBIOS (
        Id_log          INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    ,   Tabla_afectada  VARCHAR (50)
    ,   Accion          VARCHAR(50)
    ,   Fecha           DATETIME
    ,   Id_cliente       INT
    ,   Usuario         VARCHAR(50)
    );

DELIMITER //

CREATE TRIGGER after_insert_trigger
AFTER INSERT ON CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CAMBIOS (Tabla_afectada, Accion, Fecha, Id_cliente, Usuario)
    VALUES ('CLIENTES', 'INSERT', NOW() , NEW.Id_cliente,USER());
END //

DELIMITER ;

--  Trigger para almacenar registros modificados si la reserva se cancela

DELIMITER //

CREATE TRIGGER after_update_cancelacion_trigger
AFTER UPDATE ON RESERVAS
FOR EACH ROW
BEGIN
    IF OLD.Cancelacion IS NULL AND NEW.Cancelacion IS NOT NULL THEN
        INSERT INTO LOG_CAMBIOS (Tabla_afectada, Accion, Fecha, Id_cliente, Usuario)
        VALUES ('RESERVAS', 'Cancelacion', NOW());
    END IF;
END //

DELIMITER ;

-- Trigger para verificar si el correo electrónico de un cliente ya existe al insertar un nuevo cliente

DELIMITER //

CREATE TRIGGER before_insert_cliente_trigger
BEFORE INSERT ON CLIENTES
FOR EACH ROW
BEGIN
    DECLARE Email_count INT;
    
    SELECT COUNT(*) INTO Email_count
        FROM CLIENTES
    WHERE Email = NEW.Email;
    
    IF Email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico ya está en uso.';
    END IF;
END //

DELIMITER ;

-- Trigger para verificar si un cliente ya tiene una reserva hecha en la misma hora y actividad, y que no esté cancelada:


DELIMITER //

CREATE TRIGGER before_insert_reserva_trigger
BEFORE INSERT ON RESERVAS
FOR EACH ROW
BEGIN
    DECLARE reserva_count INT;
    
    SELECT COUNT(*) INTO reserva_count
        FROM RESERVAS
    WHERE Id_cliente = NEW.Id_cliente
        AND Id_actividad = NEW.Id_actividad
        AND Fecha = NEW.Fecha
        AND Cancelacion IS NULL;
        
    IF reserva_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente ya tiene una reserva en la misma hora y actividad.';
    END IF;
END //

DELIMITER ;


