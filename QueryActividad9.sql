CREATE DATABASE Actividad9;

--Consulta 1: Traer el FirstName y LastName de Person.Person cuando el FirstName sea 
--Mark:
SELECT Employee_Name, Employee_LastName 
FROM HRDataset
WHERE Employee_LastName LIKE '%Mark%';

--Consulta 2: ¿Cuántas filas hay?:
SELECT COUNT(*) AS 'Cantidad Filas'
FROM HRDataset;

--Consulta 3: Primeras 100 filas donde las ausencias no sean 1:
SELECT TOP 100 *
FROM HRDataset
WHERE NOT (Absences = 1);

--Consulta 4: Todas las filas donde los apellidos empiecen con letra inferior a D:
SELECT *
FROM HRDataset
WHERE (Employee_Name LIKE 'A%') OR (Employee_Name LIKE 'B%') OR (Employee_Name LIKE 'C%');

--Consulta 5: 

--Consulta 6: ¿Cuántas personas están asociadas con cada id de departamento
SELECT DeptID, COUNT(*) AS 'Cantidad'
FROM HRDataset
GROUP BY DeptID;

--Consulta 7: Todas las filas y columnas donde Department es IT/IS:
SELECT *
FROM HRDataset
WHERE Department = 'IT/IS';

--Consulta 8: ¿Cuántas personas en RaceDesc con White y con Black:
SELECT RaceDesc, COUNT(*) AS 'Cantidad'
FROM HRDataset
WHERE (RaceDesc = 'White') OR (RaceDesc = 'Black or African American')
GROUP BY RaceDesc;

--Consulta 9: Cuál es el promedio de salario de los empleados en el departamento de Production:
SELECT Department, AVG(Salary) AS 'Promedio Salario'
FROM HRDataset
WHERE Department = 'Production'
GROUP BY Department;

--Consulta 10: Todos los empleados cuyo apellido sea Becker, Miller o Robinson y su nombre empiece con cualquier letra entre C y L
SELECT *
FROM HRDataset
WHERE (Employee_Name = 'Becker' OR Employee_Name = 'Miller' OR Employee_Name = 'Robinson') AND (Employee_LastName LIKE '[C-L]%');

--Consulta 11: Nombre y apellido donde el apellido sea Smith con los nombres de las columnas en español
SELECT Employee_LastName AS 'Nombre', Employee_Name AS 'Apellido'
FROM HRDataset
WHERE Employee_Name = 'Smith';

--Consulta 12: Todos los empleados que tengan PositionID "19" o tengan sexo "M"
SELECT *
FROM HRDataset
WHERE PositionID = 19 OR Sex = 'M';

--Consulta 13: Cuál es el mayor salario entre los empleados
SELECT MAX(Salary) AS 'Maximo'
FROM HRDataset;

--Consulta 14: ...

--Consulta 15: NO POSIBLE JOINS

--Consulta 16: Todos los empleados de Executive Office, Sales, Admin Offices. Dos formas de hacerlo.
SELECT *
FROM HRDataset
WHERE Department = 'Executive Office' OR Department = 'Sales' OR Department = 'Admin Offices';