CREATE DATABASE prueba_transacciones;
USE prueba_transacciones;

CREATE TABLE Deudores (
    cedula INT PRIMARY KEY,  -- Cédula como clave primaria
    clave VARCHAR(255) NOT NULL,  
    nombre VARCHAR(100) NOT NULL,  
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL  
);

CREATE TABLE Creditos (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único
    fecha DATE NOT NULL,  
    valor DECIMAL(10,2) NOT NULL, 
    cuotas INT NOT NULL,  
    interes DECIMAL(5,2) NOT NULL,  
    estado ENUM('Activo', 'Pagado', 'Cancelado') DEFAULT 'Activo',  
    deudor_id INT NOT NULL,  
    FOREIGN KEY (deudor_id) REFERENCES Deudores(cc)  
);

CREATE TABLE Pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,  
    fecha DATE NOT NULL,  -- Se validará con un TRIGGER
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),  
    credito_id INT NOT NULL,  
    FOREIGN KEY (credito_id) REFERENCES Creditos(id)
);

DELIMITER $$
CREATE TRIGGER before_insert_pagos
BEFORE INSERT ON Pagos
FOR EACH ROW
BEGIN
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La fecha del pago no puede ser mayor a la fecha actual.';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER before_update_pagos
BEFORE UPDATE ON Pagos
FOR EACH ROW
BEGIN
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede actualizar la fecha del pago a una fecha futura.';
    END IF;
END $$

DELIMITER ;

INSERT INTO Deudores (cc, clave, nombre, apellido, email) 
VALUES (123, 'Abc', 'Fulanito', 'De tal', 'fulanito1@gmail.com');

SELECT * FROM Deudores;

INSERT INTO Creditos (id, fecha, valor, cuotas, interes, deudor_id) 
VALUES (1, CURDATE() - INTERVAL 1 YEAR, 100000, 5, 40, 123);

SELECT * FROM Creditos;

-- Pago 1: Un mes después del crédito
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (1, DATE_ADD((SELECT fecha FROM Creditos WHERE id = 1), INTERVAL 1 MONTH), 28000, 1);

-- Pago 2: Un mes después de la fecha actual
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (2, DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 28000, 1);

SET @fecha_pago1 = (SELECT fecha FROM Pagos WHERE id = 1);

-- Pago 3: Un mes después del primer pago
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (3, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), 28000, 1);

-- Pago 4: Un mes después del primer pago
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (4, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), 28000, 1);

-- Pago 5: Un mes después del primer pago (ERROR: Valor negativo)
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (5, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), -28000, 1);

UPDATE Creditos 
SET estado = 'Pagado' 
WHERE id = 1;

SELECT * FROM Creditos WHERE id = 1;

SELECT * FROM Pagos WHERE credito_id = 1;

SELECT CONCAT('TOTAL PAGOS: $', FORMAT(SUM(valor), 2)) AS total_pagos
FROM Pagos
WHERE credito_id = 1;

DELETE FROM Pagos WHERE credito_id = 1;

SELECT * FROM Pagos WHERE credito_id = 1;

START TRANSACTION;

-- Guardar la fecha del crédito en una variable
SET @fecha_credito = (SELECT fecha FROM Creditos WHERE id = 1);

-- Pago 1: Un mes después del crédito
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (1, DATE_ADD(@fecha_credito, INTERVAL 1 MONTH), 28000, 1);

-- Pago 2: Un mes después de la fecha actual
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (2, DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 28000, 1);

-- Obtener la fecha del primer pago para los siguientes pagos
SET @fecha_pago1 = (SELECT fecha FROM Pagos WHERE id = 1);

-- Pago 3: Un mes después del primer pago
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (3, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), 28000, 1);

-- Pago 4: Un mes después del primer pago
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (4, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), 28000, 1);

-- Pago 5: (Este dará error por ser negativo)
INSERT INTO Pagos (id, fecha, valor, credito_id) 
VALUES (5, DATE_ADD(@fecha_pago1, INTERVAL 1 MONTH), -28000, 1);

UPDATE Creditos SET estado = 'Pagado' WHERE id = 1;

SELECT * FROM Creditos WHERE id = 1;

SELECT * FROM Pagos WHERE credito_id = 1;

SELECT CONCAT('TOTAL PAGOS: $', FORMAT(SUM(valor), 2)) AS total_pagos
FROM Pagos
WHERE credito_id = 1;

ROLLBACK;

SELECT * FROM Pagos WHERE credito_id = 1;


