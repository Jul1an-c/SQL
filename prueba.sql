-- Crear una base de datos
CREATE DATABASE EjemploDB;

-- Usar la base de datos creada
USE EjemploDB;

-- Crear tabla de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email VARCHAR(100)
);

-- Crear tabla de órdenes
CREATE TABLE Ordenes (
    OrdenID INT PRIMARY KEY,
    ClienteID INT,
    FechaOrden DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Insertar datos en la tabla de clientes
INSERT INTO Clientes (ClienteID, Nombre, Apellido, Email) VALUES
(1, 'Juan', 'Perez', 'juan@example.com'),
(2, 'María', 'González', 'maria@example.com');

-- Insertar datos en la tabla de órdenes
INSERT INTO Ordenes (OrdenID, ClienteID, FechaOrden, Total) VALUES
(1, 1, '2024-02-27', 100.00),
(2, 1, '2024-02-28', 150.00),
(3, 2, '2024-02-28', 200.00);

-- Consulta para mostrar órdenes y los nombres de los clientes que las realizaron
SELECT Ordenes.OrdenID, Clientes.Nombre, Clientes.Apellido, Ordenes.FechaOrden, Ordenes.Total
FROM Ordenes
INNER JOIN Clientes ON Ordenes.ClienteID = Clientes.ClienteID;

-- Consulta para mostrar la suma total de todas las órdenes
SELECT SUM(Total) AS TotalOrdenes
FROM Ordenes;

-- Consulta para mostrar las órdenes realizadas por Juan
SELECT OrdenID, FechaOrden, Total
FROM Ordenes
INNER JOIN Clientes ON Ordenes.ClienteID = Clientes.ClienteID
WHERE Clientes.Nombre = 'Juan';

-- Consulta para mostrar el número de órdenes realizadas por cada cliente
SELECT Clientes.Nombre, COUNT(Ordenes.OrdenID) AS NumeroOrdenes
FROM Clientes
LEFT JOIN Ordenes ON Clientes.ClienteID = Ordenes.ClienteID
GROUP BY Clientes.ClienteID;

-- Consulta para mostrar el cliente con el mayor número de órdenes
SELECT Clientes.Nombre, COUNT(Ordenes.OrdenID) AS NumeroOrdenes
FROM Clientes
LEFT JOIN Ordenes ON Clientes.ClienteID = Ordenes.ClienteID
GROUP BY Clientes.ClienteID
ORDER BY NumeroOrdenes DESC
LIMIT 1;

-- Consulta para mostrar el total gastado por cada cliente
SELECT Clientes.Nombre, SUM(Ordenes.Total) AS TotalGastado
FROM Clientes
LEFT JOIN Ordenes ON Clientes.ClienteID = Ordenes.ClienteID
GROUP BY Clientes.ClienteID;

-- Consulta para mostrar la suma total de las órdenes de febrero de 2024
SELECT SUM(Total) AS TotalMes
FROM Ordenes
WHERE MONTH(FechaOrden) = 2 AND YEAR(FechaOrden) = 2024;

-- Consulta para concatenar el Nombre y Apellido de los clientes
SELECT CONCAT(Nombre, ' ', Apellido) AS NombreCompleto
FROM Clientes;

-- Consulta para mostrar la longitud del campo Nombre de los clientes
SELECT Nombre, LENGTH(Nombre) AS LongitudNombre
FROM Clientes;

-- Consulta para mostrar el Nombre del cliente en mayúsculas
SELECT Ordenes.OrdenID, UPPER(Clientes.Nombre) AS NombreCliente
FROM Ordenes
INNER JOIN Clientes ON Ordenes.ClienteID = Clientes.ClienteID;

-- Consulta para aplicar un descuento del 10% al total de las órdenes
SELECT OrdenID, Total * 0.9 AS TotalConDescuento
FROM Ordenes;

-- Consulta para mostrar la fecha actual
SELECT CURDATE() AS FechaActual;
