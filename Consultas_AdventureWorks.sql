--Consulta 1: Todas las personas que se llaman Mark
SELECT FirstName, LastName 
FROM Person.Person 
WHERE FirstName = 'Mark';

--Consulta 2: Cantidad de filas dentro de Person.Person
SELECT count(*) AS 'Cantidad Personas' 
FROM Person.Person;

--Consulta 3: Primeras 100 filas de Production.Product con List.Price diferente de 0.00
SELECT top(100)* 
FROM Production.Product 
WHERE ListPrice > 0.00;

--Consulta 4: Todas las filas de vEmployee donde el apellido de los empleados empieza con una letra inferior a la D
SELECT * 
FROM HumanResources.vEmployee 
WHERE LastName like '[a-c]%';

--Consulta 5: Promedio de Standarcost
SELECT AVG(StandardCost) AS 'Promedio StandardCost' 
FROM Production.Product 
WHERE StandardCost > 0.00;

--Consulta 6: Cantidad de personas asociadas con cada tipo de persona en Person.Person
SELECT PersonType, count(*) AS 'Cantidad PersonType'
FROM Person.Person 
GROUP BY PersonType;

--Consulta 7: Todos los registros donde Person.StateProvince tenga CountryRegionCode sea CA
SELECT * 
FROM Person.StateProvince 
WHERE CountryRegionCode = 'CA';

--Consulta 8: Cantidad de productos en Production.Product con colores rojo o negro
SELECT Color, count(*) AS 'Cantidad Color'
FROM Production.Product
WHERE color = 'black' or color = 'red'
GROUP BY color;

--Consulta 9: Promedio de Freight en SalesOrderHeader con TerritoryID 4
SELECT AVG(Freight) AS 'Promedio Freight'
FROM Sales.SalesOrderHeader
WHERE TerritoryID = '4';

--Consulta 10: Clientes con apellidos como Martin, Lopez o Wood y cuyo nombre empieza con una letra entre C y L
SELECT *
FROM Sales.vIndividualCustomer
WHERE (LastName = 'Lopez' or LastName = 'Martin' or LastName = 'Wood') and FirstName like '[C-L]%';

--Consulta 11: Nombres y apellidos de Sales.vIndividualCustomer
SELECT FirstName AS 'Primer Nombre', LastName AS 'Apellido'
FROM Sales.vIndividualCustomer
WHERE LastName = 'Smith';

--Consulta 12: Todos los clientes de Sales.vIndividualCustomer con código de Australia y que tengan Cel y 0 en EmailPromotion
SELECT *
FROM Sales.vIndividualCustomer
WHERE (CountryRegionName = 'Australia') or (PhoneNumberType = 'Cell' and EmailPromotion = '0');

--Consulta 13: Producto más caro por ListPrice en Production.Product
SELECT MAX(ListPrice) AS 'Mayor Precio'
FROM Production.Product;

--Consulta 14: Ventas por territorio de Sales.SalesOrderHeader
SELECT TerritoryID, SUM(TotalDue) AS 'Total Territorio'
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
HAVING SUM(TotalDue) > 10000000
ORDER BY TerritoryID;

--Consulta 15: Aplicar JOIN sobre la consulta anterior
SELECT B.Name, SUM(TotalDue) AS 'Total Territorio'
FROM Sales.SalesOrderHeader AS A INNER JOIN Sales.SalesTerritory AS B
ON A.TerritoryID = B.TerritoryID
GROUP BY B.Name
HAVING SUM(TotalDue) > 10000000
ORDER BY B.Name;

--Consulta 16: Todos los empleados que sean de los departamentos "Executive", "Tool Design" y "Engineering".
--Forma 1:
SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department = 'Executive' or Department = 'Tool Design' or Department = 'Engineering';

--Consulta 17: Empleados contratados en un determinado rango de fechas
--Forma 1:
SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate BETWEEN '2000-07-01' AND '2002-06-30';

--Forma 2:
SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate > '2000-07-01' AND StartDate < '2002-06-30';

--Consulta 18: Todas las filas de Sales.SalesOrderHeader donde exista un vendedor
SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID is not null;

--Consulta 19: Cantidad de personas en Person.Person que no tienen NULL en MiddleName
SELECT COUNT(*) AS 'Cantidad'
FROM Person.Person
WHERE MiddleName is not null;

--Consulta 20: SalesPersonID y TotalDue donde SalesPersonID no está vacío y TotalDue excede 70000
SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID is not null AND TotalDue > 70000;

--Consulta 21: Todos los clientes cuyo apellido empieza con R
SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName like '[r]%';

--Consulta 22: Todos los clientes cuyo apellido termina con R
SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName like '%[r]';

--Consulta 23: Cantidad de productos por cada color que no sea null y cuya cantidad sea más de 20
SELECT Color, COUNT(*) AS 'Cantidad Color'
FROM Production.Product
WHERE Color is not null
GROUP BY Color
HAVING COUNT(*) > 20;

--Consulta 24: Join de Production.Product y Production.ProductInventory
SELECT A.Name, A.ListPrice, B.Quantity, A.ListPrice * B.Quantity AS 'Ventas'
FROM Production.Product AS A INNER JOIN Production.ProductInventory AS B
ON A.ProductID = B.ProductID
WHERE A.ListPrice > 0.00;

--Consulta 25: FirstName y LastName de Person.Person y creación de tercera columna con Promo
--Crear tabla para la correspondencia entre el codigo dde Email y la promoción:
CREATE TABLE Sales.SalesEmailPromotion (
EmailCode int,
Promotion varchar (10),
primary key (EmailCode))

INSERT INTO Sales.SalesEmailPromotion 
	VALUES (0, 'Promo 1')
INSERT INTO Sales.SalesEmailPromotion 
	VALUES (1, 'Promo 2')
INSERT INTO Sales.SalesEmailPromotion 
	VALUES (2, 'Promo 3')

--Solución:
SELECT FirstName, LastName, B.Promotion
FROM Person.Person AS A INNER JOIN Sales.SalesEmailPromotion AS B
ON A.EmailPromotion = B.EmailCode;

--Consulta 26: 
--Consulta 27:

--Consulta 28: Unión de Person.Person y Person.Password
SELECT FirstName, LastName, B.PasswordHash
FROM Person.Person AS A INNER JOIN Person.Password AS B
ON A.BusinessEntityID = B.BusinessEntityID; 

--Consulta 29: Título de Person.Person si es null "no hay título":
SELECT CASE
WHEN Title is NULL THEN 'No hay título'
ELSE Title
END AS 'Título'
FROM Person.Person;

--Consulta 30: Concatenaciones de nombres en Person.Person:
SELECT FirstName, MiddleName, LastName, CASE
WHEN MiddleName is null THEN FirstName + ' ' + LastName
ELSE FirstName + ' ' + MiddleName + ' ' + LastName
END AS 'Nombre Completo'
FROM Person.Person;

--Consulta 31: Si las columnas MakeFlag y FinishedGoodFlags son iguales, devolver null
SELECT MakeFlag, FinishedGoodsFlag, CASE
WHEN MakeFlag = FinishedGoodsFlag THEN null
ELSE 'Diferente'
END AS 'Comparación'
FROM Production.Product;

--Consulta 32: Existencia de color en Production.Product
--Forma 1:
SELECT CASE
WHEN Color is null THEN 'Sin color'
ELSE Color
END AS 'Color'
FROM Production.Product;