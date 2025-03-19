CREATE DATABASE TPCH;
USE TPCH;


-- Creating Region Table
CREATE TABLE Region(
   RegionID INT PRIMARY KEY,
   RegionName VARCHAR(255),
   Comment VARCHAR(255)
);

-- Creating Nation Table with Foreign Key Reference to Region
CREATE TABLE Nation(
   NationID INT PRIMARY KEY,
   Name VARCHAR(255),
   RegionID INT,
   Comment VARCHAR(255),
   FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Creating Customer Table with Foreign Key Reference to Nation
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address TEXT,
    Phone VARCHAR(50),
    NationID INT,
    MarketSegment VARCHAR(100),
    Comment VARCHAR(255),
    Balance DECIMAL(10,2),
    FOREIGN KEY (NationID) REFERENCES Nation(NationID)
);

-- Creating Supplier Table with Foreign Key Reference to Nation
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address TEXT,
    NationID INT,
    Phone VARCHAR(50),
    RegionID INT,
    Balance DECIMAL(10,2),
    FOREIGN KEY (NationID) REFERENCES Nation(NationID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Creating Part Table
CREATE TABLE Part (
    PartID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10,2)
);

-- Creating PartSupplier Table with Composite Primary Key
CREATE TABLE PartSupplier (
    PartID INT,
    SupplierID INT,
    SupplyCost DECIMAL(10,2),
    PRIMARY KEY (PartID, SupplierID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Creating Orders Table with Foreign Key Reference to Customer
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Creating LineItem Table with Foreign Key References
CREATE TABLE LineItem (
    LineItemID INT PRIMARY KEY,
    OrderID INT,
    PartID INT,
    SupplierID INT,
    Quantity INT,
    ExtendedPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Tax DECIMAL(5,2),
    ShipDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Populating Data

-- Inserting into Region
INSERT INTO Region (RegionID, RegionName, Comment) VALUES
(1, 'North America', 'USA, Canada, Mexico'),
(2, 'Europe', 'Germany, France, UK'),
(3, 'Middle East', 'UAE, Saudi Arabia, Qatar');

-- Inserting into Nation
INSERT INTO Nation (NationID, Name, RegionID, Comment) VALUES
(1, 'USA', 1, 'United States of America'),
(2, 'Germany', 2, 'Federal Republic of Germany'),
(3, 'UAE', 3, 'United Arab Emirates');

-- Inserting into Customer
INSERT INTO Customer (CustomerID, Name, Address, Phone, NationID, MarketSegment, Comment, Balance) VALUES
(1, 'Alice Johnson', '123 Main St', '555-1234', 1, 'HOUSEHOLD', 'Regular Customer', 9500.00),
(2, 'Bob Smith', '456 Oak St', '555-5678', 2, 'AUTOMOTIVE', 'Wholesale Buyer', 7200.50),
(3, 'Charlie Brown', '789 Pine St', '555-8765', 3, 'HOUSEHOLD', 'VIP Customer', 12000.75);

-- Inserting into Supplier
INSERT INTO Supplier (SupplierID, Name, Address, Phone, NationID, RegionID, Balance) VALUES
(1, 'Middle East Supplies', 'Dubai, UAE', '555-3456', 3, 3, 15000.00),
(2, 'European Parts Ltd.', 'Berlin, Germany', '555-7890', 2, 2, 18500.00);

-- Inserting into Part
INSERT INTO Part (PartID, Name, Description, Price) VALUES
(1, 'Steel Rod', 'High-quality steel rod', 100.00),
(2, 'Aluminum Sheet', 'Lightweight aluminum sheet', 150.00),
(3, 'Plastic Cover', 'Durable plastic cover', 50.00);

-- Inserting into PartSupplier
INSERT INTO PartSupplier (PartID, SupplierID, SupplyCost) VALUES
(1, 1, 90.00),
(2, 2, 140.00),
(3, 1, 45.00);

-- Inserting into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-03-01'),
(2, 2, '2024-03-02'),
(3, 3, '2024-03-05');

-- Inserting into LineItem
INSERT INTO LineItem (LineItemID, OrderID, PartID, SupplierID, Quantity, ExtendedPrice, Discount, Tax, ShipDate) VALUES
(1, 1, 1, 1, 10, 1000.00, 50.00, 30.00, '2024-03-08'),
(2, 2, 2, 2, 5, 750.00, 25.00, 20.00, '2024-03-10'),
(3, 3, 3, 1, 20, 1000.00, 80.00, 50.00, '2024-03-12');


--Queries 
/*1- What are the names of the customers who have a balance that is greater than $9000 and are in the
“HOUSEHOLD” market segment?*/

select * from Customer where Balance > 9000 and MarketSegment ='HOUSEHOLD'


/*2- Which parts are supplied by at least 1 supplier from the region “MIDDLE EAST”? Include the part
name in your answer along with the part key. Eliminate any duplicates and sort your answer based on
the part key.*/
select Distinct Part.PartID , Part.Name as [Parts ] from Part 
Join PartSupplier on Part.PartID = PartSupplier.PartID
join Supplier on PartSupplier.SupplierID = Supplier.SupplierID
Join Region on Supplier.RegionID = Region.RegionID 
Where Region.RegionName ='Middle East'



/*3- How many distinct parts are supplied by European suppliers? */
select count( Distinct Part.PartID) as [Distinct Part] from Part 
Join PartSupplier on Part.PartID = PartSupplier.PartID
join Supplier on PartSupplier.SupplierID = Supplier.SupplierID
Join Region on Supplier.RegionID = Region.RegionID 
Where Region.RegionName ='Europe'


/*4- Which parts are not supplied by any supplier from EUROPE? Include the part name in your answer.*/
select Distinct Part.Name AS Parts 
from Part 
Where Part.PartID NOT IN (
   select Part.PartID 
   from Part 
   Join PartSupplier on Part.PartID = PartSupplier.PartID
   Join Supplier ON PartSupplier.SupplierID  = Supplier.SupplierID
   JOIN Nation on Supplier.NationID = Nation.NationID
   JOIN Region on Supplier.RegionID = Region.RegionID 
   Where Region.RegionName ='Europe'
);

/*
5- Which customers ordered parts ONLY from suppliers in the same region? Include the customer name,
phone and region in your answer, and remove any duplicates.*/

SELECT DISTINCT Customer.Name, Customer.Phone, Region.RegionName 
FROM Customer
JOIN Nation ON Customer.NationID = Nation.NationID
JOIN Orders ON Customer.CustomerID = Orders.CustomerID
JOIN LineItem ON Orders.OrderID = LineItem.OrderID
JOIN Supplier ON LineItem.SupplierID = Supplier.SupplierID
JOIN Nation AS SuppNation ON Supplier.NationID = SuppNation.NationID
JOIN Region ON Nation.RegionID = Region.RegionID
GROUP BY Customer.CustomerID, Customer.Name, Customer.Phone, Region.RegionName
HAVING COUNT(DISTINCT CASE WHEN Nation.RegionID <>SuppNation.RegionID THEN Supplier.SupplierID END) = 0;

/*
6- What is the highest extended price for parts that had a discount larger than the tax when ordered?*/
select PartID , Max(ExtendedPrice) as [highest Extended Price] from Orders 
join LineItem on Orders.OrderID = LineItem.OrderID
Where LineItem.Discount > LineItem.Tax group by PartID 
/*
7- The number of orders that had all of their items received in at most 2 weeks of shipment.
HINT1: avoid counting duplicates.
HINT2: In SQL Server, you can compute the date difference with the DATEDIFF() function. It takes 3 
parameters: unit, start date, end date.
For example, SELECT DATEDIFF(day, '2013-09-16', '2013-09-23') returns 7 as the answer. You can put
fields in the 2nd and 3rd argument.*/

Select Count(DISTINCT Orders.OrderID) As [Number Of Orders]
From Orders
Join LineItem ON orders.OrderID = LineItem.OrderID 
Where DateDiFF(Day, Orders.OrderDate, LineItem.ShipDate) <= 14

/*
8- The number of (distinct) customers who did not order any part that has some American supplier.*/

SELECT COUNT(DISTINCT Customer.CustomerID) AS [Number of Customers]
FROM Customer
WHERE Customer.CustomerID NOT IN (
    SELECT DISTINCT Orders.CustomerID
    FROM Orders
    JOIN LineItem ON Orders.OrderID = LineItem.OrderID
    JOIN Supplier ON LineItem.SupplierID = Supplier.SupplierID
    JOIN Nation ON Supplier.NationID = Nation.NationID
    WHERE Nation.Name = 'USA'
);

/*
9- Which nation does the customer with the highest balance come from? HINT: you can find the
maximum value with a simple nested select query.*/
select Customer.Name as[Customer] , Nation.Name as[nation] from Customer
join Nation on Customer.NationID = Nation.NationID
Where Customer.Balance =(select Max(Balance) from Customer)
/*
10- List the names of the countries where some parts took more than 29 days to ship, despite being
supplied from a supplier to a customer in this same country.*/


select Nation.Name as [Countries ] from Orders 
Join LineItem on Orders.OrderID = LineItem.OrderID 
Join Supplier On LineItem.SupplierID  = Supplier.SupplierID
Join Customer on Customer.CustomerID = LineItem.SupplierID
join nation on Customer.NationID = Nation.NationID
Where Customer.NationID = Supplier.NationID and DateDiff(Day,OrderDate,ShipDate) > 29