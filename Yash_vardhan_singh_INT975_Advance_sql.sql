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

Create proc spGetProductPriceById
@Pid int 
as 
Begin
  Return(select Price from Products Where ProductID=@Pid) 
End 

Declare @ProductPrice Money 
exec @ProductPrice = spGetProductPriceById 1
select @ProductPrice as [price of product]

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

Create proc spGetAllProductsOfPrice
@Pprice Money
As 
Begin
	select ProductID, ProductName from Products Where Price=@Pprice
End

exec spGetAllProductsOfPrice 1000
/*
6. Create a trigger that fires after an UPDATE on the Products table. If the Price is
changed, insert a record into the ProductLogs table with the ProductID, OldPrice,
NewPrice, and current LogDate.*/


Create Table ProductLogs (
LogID int Primary Key Identity,
ProductID int foreign Key references Products(ProductID),
OldPrice Money,
NewPrice Money,
LogDate DateTime)


Create Trigger tr_logProductsPrizeUpdate
on Products
For Update
As 
Begin
	 Declare @Pid int 
	 Declare @oldPrice Money
	 Declare @newPrice Money 

	 select @oldPrice=Price from Deleted
	 select @Pid = ProductID,@newPrice=Price from inserted 

	 If(Update(Price))
	 Begin
	    Insert into ProductLogs( ProductID, OldPrice,
        NewPrice,LogDate) Values( @Pid, @oldPrice, @newPrice, GetDate() );
	 End 
End 


Update Products set Price=900 Where ProductID=1

select * from ProductLogs





/*
7. Create a trigger that fires before an UPDATE on the Products table. If the
StockQuantity is being updated to a negative value, prevent the update and display a
message.*/
Create Trigger tr_PreventStockQuanityToBeNegative
on Products
Instead of  Update
As 
Begin
	 Declare @Pid int 
	 Declare @Stockquantity Int 

	 select @Pid = ProductID,@Stockquantity=StockQuantity from inserted 

	 If(Update(StockQuantity))
	 Begin
	   if(Not Exists(select 1 from inserted where StockQuantity < 0))
		   Begin
		     Update Products set StockQuantity=@Stockquantity Where ProductID=@Pid
		   End
		   Else
		   Begin
			  raiserror('Stock Quantity cannot  be in Negative',16,1);
		   End
	 End 
End 

Update Products set StockQuantity=-10 Where ProductID=1

Update Products set StockQuantity=10 Where ProductID=1





/*
8. Create a trigger that fires before an INSERT on the Products table. If the StockQuantity
is not provided, set its default value to 0.*/


Create Trigger tr_SetDefaultProductStockQunatity
on Products
Instead of  Insert
As 
Begin

	 Declare @Stockquantity Int 
	 Declare @Pname varchar(55)
	 Declare @price Money

	 select @Stockquantity=StockQuantity,@Pname=ProductName,@price=Price  from inserted 

     if(@Stockquantity is null)
	 Begin
        Insert into Products(ProductName,Price ,StockQuantity) values(@Pname,@price,0);
	 End

End 

 Insert into Products(ProductName,Price) values('helmet',1500);

 select * from Products

/*
9. Create a trigger that fires after an UPDATE on the Products table. If the ProductName
is changed, print a message stating that the product name was altered.*/

Create Trigger tr_OnUpdateProductName
on Products
For Update
As 
Begin
	 Declare @Pid int 
	 Declare @oldName Varchar(55)
	 Declare @newName Varchar(55)

	 select @oldName=ProductName from Deleted
	 select @Pid = ProductID,@newName=ProductName from inserted 

	 If(Update(ProductName ))
	 Begin
	    print('product name was altered form '+@oldName +' to '+@newName); 
	 End 
End 


Update Products set ProductName='crirket ' Where ProductID=1

select * from ProductLogs

/*
10.Create a trigger that fires before an UPDATE on the Products table. If the Price is being
increased by more than 50%, prevent the update and display a message.*/

Create Trigger tr_preventPriceUpdateBy50percent
on Products
after Update
As 
Begin
   declare @oldprice money 
   declare @newprice money

   select @oldprice = Price from deleted
   select @newprice = Price from inserted 
   if(@newprice >( 50 * (@oldprice / 100)))
   Begin
     raiserror('cannot increase price of product by 50 % ',16,1);
   End 
End 


Update Products set Price=2000 Where ProductID=1