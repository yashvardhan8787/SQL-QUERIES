
-- Creating database amazon
CREATE DATABASE amazon;

-- Using database amazon
USE amazon;

-- Creating Users table
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(55) NOT NULL,
    LastName VARCHAR(55) NOT NULL,
    UserName VARCHAR(55) NOT NULL UNIQUE,
    Email VARCHAR(55) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL, 
    Phone BIGINT NOT NULL,
    DOB DATE NOT NULL,
);

-- Creating Login History table
CREATE TABLE Login (
    LoginId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
	Email VARCHAR(55) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL, 
    CONSTRAINT FK_Login_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Creating Category Table
CREATE TABLE Category (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
);

-- Creating SubCategory Table
CREATE TABLE SubCategory (
    SubCategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryId INT NOT NULL,
    SubCategoryName VARCHAR(100) NOT NULL,
    Description TEXT,
    CONSTRAINT FK_SubCategory_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- Creating Product Table
CREATE TABLE Product (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    SubCategoryId INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Model VARCHAR(55),
    Brand VARCHAR(55),
    Color VARCHAR(55),
    CONSTRAINT FK_Product_SubCategory FOREIGN KEY (SubCategoryId) REFERENCES SubCategory(SubCategoryId)
);

-- Creating Order Table
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount > 0),
    OrderStatus VARCHAR(20) DEFAULT 'Pending',
    Address TEXT NOT NULL,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Creating OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Product FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Creating Cart Table
CREATE TABLE Cart (
    CartId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Cart_Product FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Creating Payment Table
CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    UserId INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    PaymentStatus VARCHAR(20) DEFAULT 'Pending',
    PaymentType VARCHAR(50) NOT NULL,
    TransactionId VARCHAR(100),
    PaymentDate DATETIME,
    CONSTRAINT FK_Payment_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_Payment_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Creating Wishlist Table
CREATE TABLE Wishlist (
    WishlistId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    CONSTRAINT FK_Wishlist_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Wishlist_Product FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
    CONSTRAINT UQ_Wishlist UNIQUE (UserId, ProductId)
);


--Index  
--creating clustered index 
-
--CReate CLUSTERED INDEX idx_employeeId ON Employees(ID);
--single Index
--CReate INDEX index_salary on employees (salary) ;

--unique index
--create UNiQue Index ind_unique_name ON Employees(Name);

--multiple --composite 
--Create INDEX indx_Dept_salary ON employees(Department ,salary);

--Exec sp_rename "table.indexname" ,"newINdexName","INDEX" --change name 

--creating index on usertable using its primary key bcoz clustered Index is only created with primary key 
CREATE CLUSTERED INDEX  idx_usersId ON Users(UserId)

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Users');
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Cart');