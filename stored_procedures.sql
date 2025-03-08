
use AdventureWorks2022

-- Procedure to Get Department Names
CREATE PROCEDURE getDepartmentNames
AS
BEGIN 
    SELECT Name FROM HumanResources.Department;
END;


Exec getDepartmentNames

drop proc getDepartmentNames

-- Procedure to Get Department by ID

CREATE PROCEDURE getDepartmentByDid
@Dep_id INT
AS
BEGIN
    SELECT Name FROM HumanResources.Department WHERE DepartmentID = @Dep_id;
END;

exec getDepartmentByDid 1 

drop proc getDepartmentByDid
-- Procedure to Get Employee by Department ID and Gender
CREATE PROCEDURE getGenderAndDepartemntId 
@gender VARCHAR(20),
@depId INT 
AS 
BEGIN 
    SELECT * FROM HumanResources.Employee WHERE BusinessEntityID = @depId AND Gender = @gender;
END;

exec getGenderAndDepartemntId  'F', 1 

drop proc getGenderAndDepartemntId 



create Database LearStoreProcedures

use LearStoreProcedures 

-- Create Orders Table
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    OrderDate DATE,
    TotalAmount MONEY,
    OrderStatus VARCHAR(100),
    Address VARCHAR(255)
);

-- Procedure to Get Customer Orders
CREATE PROCEDURE getCustomerOrderDetails
@id INT 
AS
BEGIN 
    SELECT OrderId, UserId, OrderDate, TotalAmount, OrderStatus, Address 
    FROM Orders WHERE UserId = @id;
END;

exec getCustomerOrderDetails 1

Drop proc getCustomerOrderDetails

-- Procedure to Insert Order Values
CREATE PROCEDURE insertValuesToOrders
@UserId INT,
@OrderDate DATETIME,
@TotalAmount MONEY,
@OrderStatus VARCHAR(100),
@Address VARCHAR(100)
AS 
BEGIN 
    INSERT INTO Orders (UserId, OrderDate, TotalAmount, OrderStatus, Address)
    VALUES (@UserId, @OrderDate, @TotalAmount, @OrderStatus, @Address);
END;

exec insertValuesToOrders 1,'2003-02-02',10000,'pending' ,'gotri'

Drop proc insertValuesToOrders

-- Procedure with Output Parameter
CREATE PROCEDURE DoubleNumber
    @InputNumber INT,
    @OutputNumber INT OUTPUT
AS
BEGIN
    SET @OutputNumber = @InputNumber * 2;
END;
 
Declare @Res INT 
exec DoubleNumber 5,@Res OUTPUT 
select @Res


drop proc DoubleNumber



-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    UserName VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100),
    Phone VARCHAR(15),
    DOB DATE
);

-- Procedure to Get Customer Info
CREATE PROCEDURE CustomerInfo
@CustomerID INT
AS 
BEGIN 
    SELECT FirstName, LastName, Email FROM Customers WHERE CustomerID = @CustomerID;
END;

exec CustomerInfo 1

drop proc CustomerInfo 

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(55),
    Description VARCHAR(255),
    Price MONEY
);

-- Procedure to Insert Product
CREATE PROCEDURE newProduct
@pId INT,
@ProductName VARCHAR(55),
@Description VARCHAR(255),
@Price MONEY
AS 
BEGIN 
    INSERT INTO Products (ProductID, ProductName, Description, Price) 
    VALUES (@pId, @ProductName, @Description, @Price);
END;


drop proc newProduct
-- Procedure to Update Product Price
CREATE PROCEDURE UpdatePrice
@pId INT,
@Price MONEY
AS 
BEGIN 
    UPDATE Products SET Price = @Price WHERE ProductID = @pId;
END;

drop proc UpdatePrice

-- Procedure to Get Orders Between Date Range
CREATE PROCEDURE OrdersBetweenTheRange
@startDate DATE,
@endDate DATE
AS 
BEGIN 
    SELECT * FROM Orders WHERE OrderDate BETWEEN @startDate AND @endDate;
END;

Drop proc OrdersBetweenTheRange

-- Procedure to Calculate Total Order Amount
CREATE PROCEDURE CalculateTotalAmountOfOrder
@OrderId INT,
@TotalAmount MONEY OUTPUT
AS 
BEGIN
    SELECT @TotalAmount = SUM(Quantity * UnitPrice) 
    FROM OrderDetails 
    WHERE OrderId = @OrderId;
END;

drop proc CalculateTotalAmountOfOrder
-- Procedure to Get Top N Products by Sales
CREATE PROCEDURE topNProducts
@N INT
AS
BEGIN
    SELECT TOP (@N) p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSold
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName
    ORDER BY TotalSold DESC;
END;

drop proc topNProducts
