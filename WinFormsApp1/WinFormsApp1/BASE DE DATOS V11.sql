-- Eliminar base de datos si existe y crear una nueva
DROP DATABASE IF EXISTS tiendau4;
CREATE DATABASE tiendau4;
USE tiendau4;

-- Crear las tablas necesarias
CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    usuario CHAR(30) NOT NULL,
    pass VARCHAR(256) NOT NULL,
    salario FLOAT(2) NOT NULL,
    foto VARCHAR(1000)
);

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);

CREATE TABLE marca (
    idMarca INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(30) NOT NULL,
    logo VARCHAR(1000)
);

CREATE TABLE Productos (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    codigo CHAR(12) NOT NULL,
    precio DECIMAL(3) NULL,
    descripcion VARCHAR(200) NOT NULL,
    cantidad INT NOT NULL,
    idMarca INT NOT NULL,
    imagen VARCHAR(1000),
    FOREIGN KEY (idMarca) REFERENCES marca(idMarca)
);

CREATE TABLE ventas (
    idVenta INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NULL,
    descripcion VARCHAR(100),
    total FLOAT(2) NOT NULL,
    fecha DATETIME NOT NULL,
    idEmpleado INT NOT NULL,
    FOREIGN KEY (idEmpleado) REFERENCES empleados(idEmpleado),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);
create table auditoria (
idAuditoria int primary key not null auto_increment,
tabla varchar(20) not null,
accion varchar(30) not null,
fecha datetime not null,
usuario varchar(100) not null

);
CREATE TABLE detalles_ventas (
    idProducto INT NOT NULL,
    idVenta INT NOT NULL,
    cantidad INT NOT NULL,
    precioVenta FLOAT(2),
    FOREIGN KEY (idProducto) REFERENCES productos(idProducto),
    FOREIGN KEY (idVenta) REFERENCES ventas(idVenta)
);

-- Crear procedimientos almacenados para insertar ventas y detalles de ventas

DELIMITER $$

-- Procedimiento para insertar una venta
CREATE PROCEDURE insertar_venta(
    IN p_idCliente INT,
    IN p_descripcion VARCHAR(100),
    IN p_total FLOAT(2),
    IN p_fecha DATETIME,
    IN p_idEmpleado INT
)
BEGIN
    -- Insertar la venta en la tabla ventas
    INSERT INTO ventas (idCliente, descripcion, total, fecha, idEmpleado)
    VALUES (p_idCliente, p_descripcion, p_total, p_fecha, p_idEmpleado);
END $$

-- Procedimiento para insertar detalles de la venta
CREATE PROCEDURE insertar_detalles_venta(
    IN p_idVenta INT,
    IN p_idProducto INT,
    IN p_cantidad INT,
    IN p_precioVenta FLOAT(2)
)
BEGIN
    -- Insertar los detalles de la venta en la tabla detalles_ventas
    INSERT INTO detalles_ventas (idVenta, idProducto, cantidad, precioVenta)
    VALUES (p_idVenta, p_idProducto, p_cantidad, p_precioVenta);
END $$

DELIMITER ;

-- Insertar datos iniciales en las tablas de ejemplo

-- Insertar marcas
INSERT INTO marca (Nombre, logo) VALUES ('Coca-Cola', '');
INSERT INTO marca (Nombre, logo) VALUES ('Pepsi', '');
INSERT INTO marca (Nombre, logo) VALUES ('Nestlé', '');
INSERT INTO marca (Nombre, logo) VALUES ('Bimbo', '');
INSERT INTO marca (Nombre, logo) VALUES ('Lala', '');
INSERT INTO marca (Nombre, logo) VALUES ('Colgate', '');
INSERT INTO marca (Nombre, logo) VALUES ('Procter & Gamble', '');
INSERT INTO marca (Nombre, logo) VALUES ('Unilever', '');
INSERT INTO marca (Nombre, logo) VALUES ('Peñafiel', '');
INSERT INTO marca (Nombre, logo) VALUES ('Herdez', '');

-- Insertar productos para Coca-Cola (idMarca = 1)

-- INSERTAR 40 PRODUCTOS COMUNES, ASOCIADOS A LAS MARCAS ANTERIORES (10 MARCAS, 4 PRODUCTOS POR MARCA)
-- Nota: `idMarca` debe corresponder al ID de la marca que se acaba de insertar

-- Productos de Coca-Cola
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Coca-Cola 600ml', '000000000001', 'Refresco Coca-Cola 600ml', 100, 1, 'https://supermode.com.mx/cdn/shop/products/100001337_4be2fa42-a15d-4539-a584-385823b5cfce.jpg?v=1698797211', 15.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Coca-Cola 2L', '000000000002', 'Refresco Coca-Cola 2L', 50, 1, 'https://www.movil.farmaciasguadalajara.com/wcsstore/FGCAS/wcs/products/302546_A_1280_AL.jpg', 30.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Fanta 600ml', '000000000003', 'Refresco sabor naranja Fanta 600ml', 60, 1, 'https://chedrauimx.vtexassets.com/arquivos/ids/38985772/7501055303779_00.jpg?v=638671328414530000', 14.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Sprite 600ml', '000000000004', 'Refresco sabor lima-limón Sprite 600ml', 80, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8CY4RU-g37r_RxS3_2gL1nq8GeYg3Tt6kiA&s', 15.00);

-- Productos de Pepsi
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pepsi 600ml', '000000000005', 'Refresco Pepsi 600ml', 100, 2, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750103131001L.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 14.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pepsi 2L', '000000000006', 'Refresco Pepsi 2L', 50, 2, 'https://www.movil.farmaciasguadalajara.com/wcsstore/FGCAS/wcs/products/302279_A_1280_AL.jpg', 28.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('7Up 600ml', '000000000007', 'Refresco sabor lima-limón 7Up 600ml', 70, 2, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750102201458L.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 14.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Mirinda 600ml', '000000000008', 'Refresco sabor naranja Mirinda 600ml', 60, 2, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750102201491L.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 14.00);

-- Productos de Nestlé
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Leche en polvo', '000000000009', 'Leche en polvo entera Nestlé', 30, 3, 'https://www.nestleprofessional.com.mx/sites/default/files/styles/np_product_detail/public/2022-11/leche_en_polvo_nestle_35_kg.png?itok=-J1kWc0z', 120.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Chocolates KitKat', '000000000010', 'Chocolates KitKat barra', 120, 3, 'https://m.media-amazon.com/images/I/61pH5H4s9yL._AC_UF894,1000_QL80_.jpg', 18.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Cereal Nesquik', '000000000011', 'Cereal Nesquik 300g', 40, 3, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00761328739241L.jpg', 50.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Helado de vainilla', '000000000012', 'Helado de vainilla Nestlé', 25, 3, 'https://chedrauimx.vtexassets.com/arquivos/ids/38942073-800-auto?v=638670789141100000&width=800&height=auto&aspect=true', 40.00);

-- Productos de Bimbo
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pan blanco Bimbo', '000000000013', 'Pan blanco Bimbo paquete', 200, 4, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750100011120L.jpg', 30.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pan integral Bimbo', '000000000014', 'Pan integral Bimbo paquete', 150, 4, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750081002206L.jpg', 35.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Roles de canela', '000000000015', 'Roles de canela Bimbo', 100, 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-6BvvBZID4thxaJFhxtWbfckzwuprYtm9Eg&s', 45.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pan molido', '000000000016', 'Pan molido Bimbo', 80, 4, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750100011185L.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 15.00);

-- Productos de Lala
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Leche entera Lala', '000000000017', 'Leche entera Lala 1L', 300, 5, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750102052606L.jpg', 25.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Leche deslactosada', '000000000018', 'Leche deslactosada Lala 1L', 200, 5, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750102051539L.jpg', 28.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Crema Lala', '000000000019', 'Crema de leche Lala', 100, 5, 'https://www.soriana.com/on/demandware.static/-/Sites-soriana-grocery-master-catalog/default/dwc1c6de45/images/product/7501020513134_A.jpg', 35.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Queso manchego', '000000000020', 'Queso manchego Lala', 90, 5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2XG7AN5FB1cN_813uN1-2Rg5mPd7csJg8ag&s', 85.00);

-- Productos de Colgate
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Pasta dental Colgate', '000000000021', 'Pasta dental Colgate Total', 200, 6, 'https://chedrauimx.vtexassets.com/arquivos/ids/37983150/7501035911376_00.jpg?v=638653273218000000', 30.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Cepillo dental Colgate', '000000000022', 'Cepillo dental Colgate', 150, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHNjlOCjrHUdOQ1WY3lJNxkb-TcKCwu9QF5Q&s', 45.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Enjuague bucal Colgate', '000000000023', 'Enjuague bucal Colgate Plax', 120, 6, 'https://www.fahorro.com/media/catalog/product/7/8/7891024025406_4_1.jpg?optimize=medium&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700', 40.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Hilo dental Colgate', '000000000024', 'Hilo dental Colgate', 50, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAIgY_XoAOQ3ePErrpHrTLgKZlFkxx5O1-AQ&s', 20.00);

-- Productos de Procter & Gamble
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Detergente Ariel', '000000000025', 'Detergente en polvo Ariel', 300, 7, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750043515073L.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 50.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Jabón Zest', '000000000026', 'Jabón de tocador Zest', 180, 7, 'https://www.mayoreototal.mx/cdn/shop/products/7506306245990_700x.webp?v=1669652997', 15.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Suavizante Downy', '000000000027', 'Suavizante para ropa Downy', 150, 7, 'https://m.media-amazon.com/images/I/819mKQGw5pL.jpg', 35.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Shampoo Head & Shoulders', '000000000028', 'Shampoo anticaspa H&S', 120, 7, 'https://static.beautytocare.com/cdn-cgi/image/width=1600,height=1600,f=auto/media/catalog/product//h/-/h-s-classic-clean-shampoo-600ml.jpg', 60.00);

-- Productos de Unilever
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Helado Magnum', '000000000029', 'Helado Magnum paleta', 80, 8, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750630641577L.jpg', 40.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Shampoo Dove', '000000000030', 'Shampoo hidratante Dove', 100, 8, 'https://m.media-amazon.com/images/I/51cUe1AmSwL.jpg', 80.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Desodorante Axe', '000000000031', 'Desodorante en aerosol Axe', 150, 8, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750630622672L1.jpg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 40.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Mayonesa Hellmanns', '000000000032', 'Mayonesa Hellmanns', 90, 8, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750630631757L.jpg', 50.00);

-- Productos de Peñafiel
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Agua mineral Peñafiel', '000000000033', 'Agua mineral embotellada', 100, 9, 'https://cdn.shopify.com/s/files/1/0566/4391/1854/products/7501055379811.png?v=1668297029', 10.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Refresco Peñafiel limón', '000000000034', 'Refresco sabor limón Peñafiel', 80, 9, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750107383989L.jpg', 14.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Refresco Peñafiel naranja', '000000000035', 'Refresco sabor naranja Peñafiel', 70, 9, 'https://oneiconn.vtexassets.com/arquivos/ids/189795/100111406_1.jpg?v=638430892806770000', 14.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Agua saborizada Peñafiel', '000000000036', 'Agua con sabor Peñafiel', 90, 9 , 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750107383988L.jpg', 12.00);

-- Productos de Herdez 
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Salsa verde Herdez', '000000000037', 'Salsa verde Herdez', 110, 10, 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750100312738L.jpg', 30.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Salsa roja Herdez', '000000000038', 'Salsa roja Herdez', 120, 10, 'https://www.barriocampo.com/cdn/shop/products/herdezcasera_700x.jpg?v=1593277466', 32.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Guacamole Herdez', '000000000039', 'Guacamole envasado Herdez', 60, 10, 'https://res.cloudinary.com/oita/image/upload/w_656,h_656,c_limit,q_auto,f_auto/v1688064185/Merco/Parte%206/7501003105448_SALSA_HERDEZ_GUACAMOLE_445_GR_3_Mediana_ncyzco.jpg', 45.00);
INSERT INTO productos (nombre, codigo, descripcion, cantidad, idMarca, imagen, precio) VALUES ('Frijoles Herdez', '000000000040', 'Frijoles en lata Herdez', 90, 10, 'https://www.cocinamexicana.es/wp-content/uploads/frijoles_negros_enteros_410g-1.jpg', 25.00);


-- Insertar empleados
INSERT INTO empleados (nombre, apellido, usuario, pass, salario, foto) 
VALUES 
("Alexander", "Lopez Mora", "root", SHA2('root', 256), 3260, "https://www.ngenespanol.com/wp-content/uploads/2024/08/cual-es-la-diferencia-entre-un-dinosaurio-y-un-reptil-prehistorico-770x431.jpg");
INSERT INTO empleados (nombre, apellido, usuario, pass, salario, foto) 
VALUES 
("Brenda Catalina", "Niño Leon", "1234", SHA2('1234', 256), 3260, "");
INSERT INTO empleados (nombre, apellido, usuario, pass, salario, foto) 
VALUES 
("Abril Montserrat", "Peñaloza Tenorio", "123", SHA2('123', 256), 3260, "");
-- Insertar cliente
INSERT INTO clientes (nombre, apellido, direccion) 
VALUES ('MOSTRADOR', '', '');
INSERT INTO clientes (nombre, apellido, direccion) 
VALUES ('Alexander', 'Lopez Mora', 'Diego Lopez #418');
DELIMITER $$
CREATE PROCEDURE insertar_ventas_aleatoria(in numVentas INT , fecha varchar(20))
BEGIN
DECLARE i INT DEFAULT 0;
		declare s int;
		declare numDetalles Int;
		DECLARE aidProducto INT;
		DECLARE cantidad INT;
		DECLARE aprecioVenta float(2);
		DECLARE aidVenta INT ;
		DECLARE aidCliente INT;
		DECLARE adescripcion varchar(100);
		declare aidEmpleado int;
		DECLARE atotal float(2);
        set s= 0;
WHILE s < numVentas DO
	set aidVenta = (select count(*) from ventas) + 1;
	set atotal = 0.0;
	SET aidCliente = FLOOR(1 + (RAND() * (SELECT COUNT(*) FROM clientes)));
	set adescripcion = "";
	set aidEmpleado = FLOOR(1 + (RAND() * (SELECT COUNT(*) FROM EMPLEADOS)));
	set numDetalles = FLOOR (1 + (RAND() * 11));
	insert into ventas (idVenta, idCliente, descripcion, total, fecha, idEmpleado) VALUES
	(aidVenta, aidCliente , adescripcion ,atotal, fecha, aidempleado);
WHILE i < numDetalles DO
	set aidProducto = floor(1 + (rand() * (select count(*) from productos)));
	SET cantidad = FLOOR(1 + (RAND() * 10));
	set aprecioVenta = (select precio from productos where idproducto = aidproducto);
	INSERT INTO detalles_ventas (idVenta, idProducto, cantidad, precioVenta)
	VALUES (aidVenta, aidProducto, cantidad, aprecioVenta);
	set i = i +1;
	set atotal = atotal + (cantidad* aprecioVenta);
END WHILE;
	set i = 0;
    UPDATE ventas
	SET total = atotal
	WHERE idVenta = aidventa; set s = s+1;
END WHILE;
END $$
delimiter ;
call insertar_ventas_aleatoria(200 , "24-11-28");
call insertar_ventas_aleatoria(200 , "24-10-28");
call insertar_ventas_aleatoria(200 , "24-9-28");
call insertar_ventas_aleatoria(200 , "24-8-28");
call insertar_ventas_aleatoria(200 , "24-7-28");
call insertar_ventas_aleatoria(200 , "24-6-28");
call insertar_ventas_aleatoria(200 , "24-5-28");
call insertar_ventas_aleatoria(200 , "24-4-28");
call insertar_ventas_aleatoria(200 , "24-3-28");
call insertar_ventas_aleatoria(200 , "24-2-28");
call insertar_ventas_aleatoria(200 , "24-1-28");
call insertar_ventas_aleatoria(200 , "24-12-28");
-- PUNTO 3 PROCEDIMIENTOS ALMACENADOS insertar_venta
-- 3. Ejecución del procedimiento almacenado para insertar ventas (se asume que ya tienes un procedimiento almacenado creado)
-- Aquí se ejecuta el stored procedure para insertar ventas, realizando pruebas con diferentes cantidades de ventas.
-- 4. Reporte de ventas por mes: Usaremos una vista para generar el reporte de ventas por mes

CREATE VIEW reporte_ventas_mes AS
SELECT
    v.idVenta AS Folio,
    v.fecha AS FechaCompleta, -- Fecha sin formatear
    DATE_FORMAT(v.fecha, '%d/%m/%Y') AS Fecha,
    c.nombre AS Cliente,
    e.nombre AS Empleado,
    v.total AS Total,
    COUNT(d.idProducto) AS Cantidad
FROM ventas v
JOIN clientes c ON v.idCliente = c.idCliente
JOIN empleados e ON v.idEmpleado = e.idEmpleado
JOIN detalles_ventas d ON v.idVenta = d.idVenta
GROUP BY v.idVenta;



SELECT * FROM reporte_ventas_mes
WHERE MONTH(FechaCompleta) = 11 AND YEAR(FechaCompleta) = 2024;






-- Reporte de ventas por mes en noviembre 2024 (lo puedes consultar con un SELECT)
SELECT * FROM reporte_ventas_mes;

-- 5. Reporte de ventas por empleado: Usaremos una vista para generar el reporte de ventas por empleado

CREATE VIEW reporte_ventas_empleado AS
SELECT
    e.nombre AS Empleado,
    DATE_FORMAT(v.fecha, '%Y-%m') AS Periodo, -- Formatear la fecha para obtener el mes y año
    SUM(v.total) AS TotalVentas,
    COUNT(v.idVenta) AS CantidadVentas
FROM ventas v
JOIN empleados e ON v.idEmpleado = e.idEmpleado
GROUP BY e.nombre, Periodo;

SELECT * FROM reporte_ventas_empleado;
SELECT * FROM reporte_ventas_empleado
WHERE Periodo = '2024-11';


-- Reporte de ventas por empleado en noviembre 2024 (lo puedes consultar con un SELECT)
SELECT * FROM reporte_ventas_empleado;
DELIMITER //

-- Trigger de Auditoría para INSERT
CREATE TRIGGER auditoria_ventas_insert
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    -- Insertar en la tabla de auditoría
    INSERT INTO auditoria (tabla, accion, fecha, usuario)
    VALUES ('ventas', 'INSERT', NOW(), 'usuario_ejemplo');  -- Aquí 'usuario_ejemplo' debe ser el usuario real o variable
END;
//
-- Trigger de Auditoría para UPDATE
CREATE TRIGGER auditoria_ventas_update
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
    -- Insertar en la tabla de auditoría
    INSERT INTO auditoria (tabla, accion, fecha, usuario)
    VALUES ('ventas', 'UPDATE', NOW(), 'usuario_ejemplo');  -- Aquí 'usuario_ejemplo' debe ser el usuario real o variable
END;
//

-- Trigger de Auditoría para DELETE
CREATE TRIGGER auditoria_ventas_delete
AFTER DELETE ON ventas
FOR EACH ROW
BEGIN
    -- Insertar en la tabla de auditoría
    INSERT INTO auditoria (tabla, accion, fecha, usuario)
    VALUES ('ventas', 'DELETE', NOW(), 'usuario_ejemplo');  -- Aquí 'usuario_ejemplo' debe ser el usuario real o variable
END;
//

-- Trigger de Validación para INSERT en productos
CREATE TRIGGER validar_producto_insert
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    -- Validar que el precio no sea negativo
    IF NEW.precio < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio del producto no puede ser negativo';
    END IF;

    -- Validar que el nombre no esté vacío (no solo espacios en blanco)
    IF TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del producto no puede estar vacío';
    END IF;

    -- Validar que el código de barras tenga entre 8 y 20 caracteres
    IF NEW.codigo IS NOT NULL AND (LENGTH(NEW.codigo) < 8 OR LENGTH(NEW.codigo) > 20) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El código de barras debe tener entre 8 y 20 caracteres';
    END IF;
END;
//

-- Trigger de Validación para UPDATE en productos
CREATE TRIGGER validar_producto_update
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    -- Validar que el precio no sea negativo
    IF NEW.precio < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio del producto no puede ser negativo';
    END IF;

    -- Validar que el nombre no esté vacío (no solo espacios en blanco)
    IF TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del producto no puede estar vacío';
    END IF;

    -- Validar que el código de barras tenga entre 8 y 20 caracteres
    IF NEW.codigo IS NOT NULL AND (LENGTH(NEW.codigo) < 8 OR LENGTH(NEW.codigo) > 20) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El código de barras debe tener entre 8 y 20 caracteres';
    END IF;
END;
//

DELIMITER ;

-- 6. Reporte comparativo de ventas por un determinado producto a lo largo de cada uno de los trimestres de un año

CREATE VIEW reporte_ventas_trimestrales AS
SELECT
    p.nombre AS Producto,
    YEAR(v.fecha) AS Año, -- Incluir la columna Año para el filtro
    SUM(CASE WHEN QUARTER(v.fecha) = 1 THEN d.cantidad ELSE 0 END) AS Trimestre1,
    SUM(CASE WHEN QUARTER(v.fecha) = 2 THEN d.cantidad ELSE 0 END) AS Trimestre2,
    SUM(CASE WHEN QUARTER(v.fecha) = 3 THEN d.cantidad ELSE 0 END) AS Trimestre3,
    SUM(CASE WHEN QUARTER(v.fecha) = 4 THEN d.cantidad ELSE 0 END) AS Trimestre4
FROM detalles_ventas d
JOIN productos p ON d.idProducto = p.idProducto
JOIN ventas v ON d.idVenta = v.idVenta
GROUP BY p.nombre, Año;


SELECT * FROM reporte_ventas_trimestrales
WHERE Año = 2024;

-- Reporte comparativo de ventas trimestrales por producto (lo puedes consultar con un SELECT)
SELECT * FROM reporte_ventas_trimestrales;



-- procedimientos almacenados para los crud
-- crear -------------------- clientes<--------------------------------------------------

DELIMITER $$

CREATE PROCEDURE insertar_cliente(
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(45),
    IN p_direccion VARCHAR(100)
)
BEGIN
    INSERT INTO Clientes (nombre, apellido, direccion)
    VALUES (p_nombre, p_apellido, p_direccion);
END $$

DELIMITER ;

CALL insertar_cliente('Juan2', 'Pérez', 'Calle Falsa 123');

-- consultar cliente

DELIMITER $$

CREATE PROCEDURE obtener_clientes()
BEGIN
    SELECT * FROM Clientes;
END $$

DELIMITER ;

CALL obtener_clientes();

-- actualizar

DELIMITER $$

CREATE PROCEDURE actualizar_cliente(
    IN p_idCliente INT,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(45),
    IN p_direccion VARCHAR(100)
)
BEGIN
    UPDATE Clientes
    SET nombre = p_nombre,
        apellido = p_apellido,
        direccion = p_direccion
    WHERE idCliente = p_idCliente;
END $$

DELIMITER ;
-- CALL actualizar_cliente(1, 'Juan', 'Pérez', 'Avenida Siempreviva 742');


-- eliminar (no deja)

DELIMITER $$

CREATE PROCEDURE eliminar_cliente(
    IN p_idCliente INT
)
BEGIN
    DELETE FROM Clientes WHERE idCliente = p_idCliente;
END $$

DELIMITER ;

ALTER TABLE ventas DROP FOREIGN KEY ventas_ibfk_2;
ALTER TABLE ventas
ADD CONSTRAINT ventas_ibfk_2
FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
ON DELETE CASCADE;


-- CALL eliminar_cliente(2);

ALTER TABLE detalles_ventas DROP FOREIGN KEY detalles_ventas_ibfk_2;
ALTER TABLE detalles_ventas
ADD CONSTRAINT detalles_ventas_ibfk_2
FOREIGN KEY (idVenta) REFERENCES ventas(idVenta)
ON DELETE CASCADE;

-- productos ---------------------------------------------------------------

-- crear

DELIMITER $$

CREATE PROCEDURE insertar_producto(
    IN p_nombre VARCHAR(30),
    IN p_codigo CHAR(12),
    IN p_precio DECIMAL(10, 2),
    IN p_descripcion VARCHAR(200),
    IN p_cantidad INT,
    IN p_idMarca INT,
    IN p_imagen VARCHAR(1000)
)
BEGIN
    INSERT INTO Productos (nombre, codigo, precio, descripcion, cantidad, idMarca, imagen)
    VALUES (p_nombre, p_codigo, p_precio, p_descripcion, p_cantidad, p_idMarca, p_imagen);
END $$

DELIMITER ;

-- consultar

DELIMITER $$

CREATE PROCEDURE obtener_productos()
BEGIN
    SELECT * FROM Productos;
END $$

DELIMITER ;

-- actualizar

DELIMITER $$

CREATE PROCEDURE actualizar_producto(
    IN p_idProducto INT,
    IN p_nombre VARCHAR(30),
    IN p_codigo CHAR(12),
    IN p_precio DECIMAL(10, 2),
    IN p_descripcion VARCHAR(200),
    IN p_cantidad INT,
    IN p_idMarca INT,
    IN p_imagen VARCHAR(1000)
)
BEGIN
    UPDATE Productos
    SET nombre = p_nombre,
        codigo = p_codigo,
        precio = p_precio,
        descripcion = p_descripcion,
        cantidad = p_cantidad,
        idMarca = p_idMarca,
        imagen = p_imagen
    WHERE idProducto = p_idProducto;
END $$

DELIMITER ;


-- eliminar

DELIMITER $$

CREATE PROCEDURE eliminar_producto(
    IN p_idProducto INT
)
BEGIN
    DELETE FROM Productos WHERE idProducto = p_idProducto;
END $$

DELIMITER ;

ALTER TABLE detalles_ventas DROP FOREIGN KEY detalles_ventas_ibfk_1;

ALTER TABLE detalles_ventas
ADD CONSTRAINT detalles_ventas_ibfk_1 FOREIGN KEY (idProducto)
REFERENCES Productos (idProducto)
ON DELETE CASCADE;


-- CALL eliminar_producto(1);

-- ---------------Empleadoss ------------------------------------------------

-- crear
-- drop procedure insertar_empleado;
DELIMITER $$

CREATE PROCEDURE insertar_empleado(
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(45),
    IN p_usuario CHAR(30),
    IN p_pass VARCHAR(256),
    IN p_salario FLOAT(2),
    IN p_foto VARCHAR(1000)
)
BEGIN
    INSERT INTO Empleados (nombre, apellido, usuario, pass, salario, foto)
    VALUES (p_nombre, p_apellido, p_usuario, p_pass, p_salario, p_foto);
END $$

DELIMITER ;


-- consultar

DELIMITER $$

CREATE PROCEDURE obtener_empleados()
BEGIN
    SELECT * FROM Empleados;
END $$

DELIMITER ;

-- actualizar 

DELIMITER $$

CREATE PROCEDURE actualizar_empleado(
    IN p_idEmpleado INT,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(45),
    IN p_usuario CHAR(30),
    IN p_pass VARCHAR(256),
    IN p_salario FLOAT(2),
    IN p_foto VARCHAR(1000)
)
BEGIN
    UPDATE Empleados
    SET nombre = p_nombre,
        apellido = p_apellido,
        usuario = p_usuario,
        pass = p_pass,
        salario = p_salario,
        foto = p_foto
    WHERE idEmpleado = p_idEmpleado;
END $$

DELIMITER ;


-- eliminar

DELIMITER $$

CREATE PROCEDURE eliminar_empleado(
    IN p_idEmpleado INT
)
BEGIN
    DELETE FROM Empleados WHERE idEmpleado = p_idEmpleado;
END $$

DELIMITER ;

ALTER TABLE ventas DROP FOREIGN KEY ventas_ibfk_1;
ALTER TABLE ventas
ADD CONSTRAINT ventas_ibfk_1 FOREIGN KEY (idEmpleado)
REFERENCES empleados (idEmpleado)
ON DELETE CASCADE;



DELIMITER $$

CREATE PROCEDURE buscar_empleados(
    IN p_texto VARCHAR(50)
)
BEGIN
    SELECT * FROM Empleados
    WHERE nombre LIKE CONCAT('%', p_texto, '%')
    OR apellido LIKE CONCAT('%', p_texto, '%');
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE buscar_clientes(
    IN p_texto VARCHAR(50)
)
BEGIN
    SELECT * FROM Clientes
    WHERE nombre LIKE CONCAT('%', p_texto, '%')
    OR apellido LIKE CONCAT('%', p_texto, '%');
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE buscar_productos(
    IN p_texto VARCHAR(50)
)
BEGIN
    SELECT * FROM Productos
    WHERE nombre LIKE CONCAT('%', p_texto, '%')
    OR descripcion LIKE CONCAT('%', p_texto, '%');
END $$

DELIMITER ;



