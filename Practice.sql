Create Database Practice
use practice

exec sys.sp_rename 'Practice', 'practiceCommonModule','database'
-- SQL NOTES WITH QUERIES FOR SQL SERVER

-- 1. DATA TYPES
-- Common SQL Server Data Types
SELECT SQL_VARIANT_PROPERTY(CAST(123 AS INT), 'BaseType') AS DataType;
SELECT SQL_VARIANT_PROPERTY(CAST('Hello' AS VARCHAR(50)), 'BaseType') AS DataType;
SELECT SQL_VARIANT_PROPERTY(CAST(GETDATE() AS DATETIME), 'BaseType') AS DataType;

-- 2. OPERATORS & SPECIAL OPERATORS
-- Arithmetic Operators
SELECT 10 + 5 AS Addition, 10 - 5 AS Subtraction, 10 * 5 AS Multiplication, 10 / 5 AS Division;

-- Logical Operators
SELECT CASE WHEN 1 = 1 AND 2 > 1 THEN 'True' ELSE 'False' END AS AND_Operator;

-- Special Operators
SELECT * FROM Employees WHERE Salary BETWEEN 30000 AND 70000;
SELECT * FROM Employees WHERE FirstName LIKE 'A%';

-- Compound Operators
DECLARE @a INT = 10;
SET @a += 5; -- Equivalent to @a = @a + 5
SELECT @a AS Addition;
SET @a -= 2; -- Equivalent to @a = @a - 2
SELECT @a AS Subtraction;

-- 3. CREATE TABLE
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 4. INSERT DATA
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES (1, 'John', 'Doe', 50000, 1);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES (1, 'IT');

-- 5. UPDATE DATA
UPDATE Employees SET Salary = 55000 WHERE EmployeeID = 1;

-- 6. ALTER STATEMENTS
-- Alter Table
ALTER TABLE Employees ADD Age INT;
ALTER TABLE Employees DROP COLUMN Age;
ALTER TABLE Employees ALTER COLUMN Salary DECIMAL(12,2);
-- Alter Database
ALTER DATABASE TestDB MODIFY NAME = NewTestDB;
-- Alter Row-Level Data (Using UPDATE)
UPDATE Employees SET Salary = Salary * 1.1 WHERE DepartmentID = 1;
--create View 
Create View EmployeeView as( select * from Employees);
-- Alter View
ALTER VIEW EmployeeView AS SELECT EmployeeID, FirstName, Salary FROM Employees WHERE Salary > 50000;
-- Alter Index
CREATE INDEX idx_EmployeeSalary ON Employees(Salary);
ALTER INDEX idx_EmployeeSalary ON Employees REBUILD;
-- Alter Constraints
ALTER TABLE Employees ADD CONSTRAINT DF_Salary DEFAULT 30000 FOR Salary;
ALTER TABLE Employees DROP CONSTRAINT DF_Salary;

-- 7. DELETE DATA
DELETE FROM Employees WHERE EmployeeID = 1;

-- 8. DROP TABLE
DROP TABLE Employees;

-- 9. TRUNCATE TABLE
TRUNCATE TABLE Employees;

-- 10. SELECT STATEMENTS
SELECT * FROM Employees;
SELECT FirstName, Salary FROM Employees;

-- 11. AGGREGATE FUNCTIONS
SELECT COUNT(*) AS TotalEmployees FROM Employees;
SELECT AVG(Salary) AS AvgSalary FROM Employees;

-- 12. CLAUSES
SELECT * FROM Employees WHERE Salary > 50000 ORDER BY Salary DESC;
SELECT DepartmentID, COUNT(*) AS DeptCount FROM Employees GROUP BY DepartmentID;

-- 13. GROUP BY, ORDER BY, HAVING
SELECT DepartmentID, COUNT(*) AS DeptCount FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 1
ORDER BY DeptCount DESC;

-- 14. FILTERING DATA
SELECT * FROM Employees WHERE FirstName LIKE 'J%';
SELECT * FROM Employees WHERE Salary BETWEEN 40000 AND 70000;

-- 15. DATE FUNCTIONS
SELECT GETDATE() AS CurrentDate;
SELECT YEAR(GETDATE()) AS CurrentYear, MONTH(GETDATE()) AS CurrentMonth;

-- 16. CONSTRAINTS
ALTER TABLE Employees ADD CONSTRAINT FK_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- 17. INDEXES & VIEWS
CREATE INDEX idx_EmployeeSalary ON Employees(Salary);
CREATE VIEW EmployeeView AS SELECT EmployeeID, FirstName, Salary FROM Employees;
SELECT * FROM EmployeeView;

-- 18. SUBQUERIES
-- Subquery in WHERE clause
SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Subquery in SELECT clause
SELECT EmployeeID, FirstName, (SELECT MAX(Salary) FROM Employees) AS MaxSalary FROM Employees;

-- Subquery in FROM clause
SELECT e.FirstName, avgSal.AvgSalary FROM Employees e
JOIN (SELECT DepartmentID, AVG(Salary) AS AvgSalary FROM Employees GROUP BY DepartmentID) avgSal
ON e.DepartmentID = avgSal.DepartmentID;

-- Subquery with EXISTS
SELECT FirstName, LastName FROM Employees e
WHERE EXISTS (SELECT 1 FROM Departments d WHERE d.DepartmentID = e.DepartmentID);

-- Correlated Subquery
SELECT EmployeeID, FirstName, Salary FROM Employees e1
WHERE Salary > (SELECT AVG(Salary) FROM Employees e2 WHERE e1.DepartmentID = e2.DepartmentID);

-- 19. JOINS
-- INNER JOIN
SELECT e.FirstName, d.DepartmentName FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- LEFT JOIN
SELECT e.FirstName, d.DepartmentName FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- RIGHT JOIN
SELECT e.FirstName, d.DepartmentName FROM Employees e
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- FULL OUTER JOIN
SELECT e.FirstName, d.DepartmentName FROM Employees e
FULL OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- CROSS JOIN
SELECT e.FirstName, d.DepartmentName FROM Employees e
CROSS JOIN Departments d;

-- SELF JOIN
SELECT a.FirstName AS Employee1, b.FirstName AS Employee2 FROM Employees a
JOIN Employees b ON a.EmployeeID <> b.EmployeeID;

-- 20. SYSTEM STORED PROCEDURES (Renaming table, viewing details)
EXEC sp_rename 'EmployeeRecords','Employees'
EXEC sp_help 'EmployeeRecords';
Exec sp_helpindex 'Employees'
Exec sp_helpconstraint 'Employees'