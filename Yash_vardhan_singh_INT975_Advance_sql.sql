Create Database YashVardhan_Singh_INT975

use YashVardhan_Singh_INT975 

/*
Create a table named Products with the following columns:
ProductID
ProductName
Price
StockQuantity*/

Create Table Products
(ProductID INT Primary Key Identity  ,
ProductName Varchar(100),
Price Money ,
StockQuantity Int )

Insert into Products(ProductName,Price ,StockQuantity) values('Bat',1000,100)


/*
1. Create a stored procedure that takes a ProductID as input and returns the Price of the
product.*/

Alter proc spGetProductPriceById
@Pid int 
as 
Begin
   select * from Products Where ProductID=@Pid
End 

spGetProductPriceById 1


/*
2. Create a stored procedure that takes a ProductID and a Quantity as input and updates 
the StockQuantity of the product.*/


Create proc spUpdateProductQuantityById
@Pid int ,
@Pquantity int 
as 
Begin
  if(Exists(select 1 from Products Where ProductID = @Pid))
  Begin
     Update Products set StockQuantity=@Pquantity Where ProductID=@Pid;
  End 
  Else
  Begin
     raiserror('Product with the Id %d Does not Exists in Products Table',16,1,@Pid);
  End 
End 

spUpdateProductQuantityById 1,1000

select * from Products


/*
3. Create a stored procedure that takes ProductName, Price, and StockQuantity as
input and inserts a new product into the Products table.*/

Create proc spInsertProductInProducts
@Pname varchar(55),
@Pprice Money,
@Squantity Int
as 
Begin
   Insert into Products(ProductName,Price ,StockQuantity) values(@Pname,@Pprice,@Squantity);
End 

execute spInsertProductInProducts 'Tenis Ball',75,600 

select * from Products

/*
4. Create a stored procedure to find minimum and maximum price of the product. */

Create Proc spGetMinAndMaxPriceProducts
As 
Begin
  select Min(Price) as [Minimum Price ] ,max(Price) as [maximum price] from Products;
End 

exec spGetMinAndMaxPriceProducts 

/*
5. Create a stored procedure that takes a Price as input and returns all products with a
price less than the given value.  */

Alter proc spGetAllProductsOfPrice
@Pprice Money
As 
Begin
	select ProductID, ProductName from Products Where Price < @Pprice
End

exec spGetAllProductsOfPrice 1000
/*
6. Create a trigger that fires after an UPDATE on the Products table. If the Price is
changed, insert a record into the ProductLogs table with the ProductID, OldPrice,
NewPrice, and current LogDate.*/



/*
7. Create a trigger that fires before an UPDATE on the Products table. If the
StockQuantity is being updated to a negative value, prevent the update and display a
message.*/


/*
8. Create a trigger that fires before an INSERT on the Products table. If the StockQuantity
is not provided, set its default value to 0.*/


/*
9. Create a trigger that fires after an UPDATE on the Products table. If the ProductName
is changed, print a message stating that the product name was altered.*/



/*
10.Create a trigger that fires before an UPDATE on the Products table. If the Price is being
increased by more than 50%, prevent the update and display a message.*/
