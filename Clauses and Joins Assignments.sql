/*

 Assignment for group by CLAUSE

 */




select * frosys.tables where name like 'Person%'  or name like 'Production%' or  name like 'Sales%'



--1) In the Person.Person table, how many people are associated with each PersonType?
select PersonType ,count(*) as [Number of People associated] from Person.Person group by PersonType


--2) Using only one query, find out how many products in Production.Product are the
 --color “red” and how many are “black”.

 select Color , Count(*) as [Number of Products]  from Production.Product Where Color in ('red', 'black') group by Color 

-- 3) Using Sales.SalesOrderHeader, how many sales occurred in each territory between
--July 1, 2005 and December 31, 2006? Order the results by the sale count in descending order.
Select * from Sales.SalesOrderHeader 

select TerritoryID , count(*) as [sale count ] from Sales.SalesOrderHeader 
where OrderDate Between  '2005-07-01' and '2006-12-31' 
group by TerritoryID 
Order by [sale count ] Desc


--4) Expanding on the previous example, group the results not by the TerritoryID but by
--the name of the territory (found in the Sales.SalesTerritory table).

select * from Sales.SalesTerritory


select  T.name ,count(*) as [sale count ] from Sales.SalesOrderHeader S
Inner Join Sales.SalesTerritory T
on S.TerritoryID  = T.TerritoryID 
where YEAR(S.OrderDate)  Between  YEAR('2005-07-01') and YEAR('2006-12-31') 
group by T.Name
Order by [sale count ] Desc


--5) Using the Book, BookAuthor, Author and/or Publisher tables, identify how many
--books each author either wrote or co-authored.*/





--                 HAVING Clause Practice Problems



/*1) Find the total sales by territory for all rows in the Sales.SalesOrderHeader table.
Return only those territories that have exceeded $10 million in historical sales.
Return the total sales and the TerritoryID column.*/
 
Select Top 10 * from Sales.SalesOrderHeader 

select TerritoryID , Count(TerritoryID) as [Number of sales], SUM(SubTotal) as [total sales Cost]  from Sales.SalesOrderHeader 
group by TerritoryID  having (SUM(SubTotal) > 1000000)
Order by  TerritoryID


/*
2) Using the query from the previous question, join to the Sales.SalesTerritory table
and replace the TerritoryID column with the territory’s name. */
select T.Name  , Count(*) as [Number of sales], SUM(S.SubTotal) as [total sales Cost]  
from Sales.SalesOrderHeader  S
Inner JOIN Sales.SalesTerritory T
on S.TerritoryID = T.TerritoryID
group by T.Name  having (SUM(S.SubTotal) > 1000000)


/*
3) Using the Production.Product table, find how many products are associated with
each color. Ignore all rows where the color has a NULL value. Once grouped, return
to the results only those colors that had at least 20 products with that color.*/

select * from Production.Product

select Color, count(*)  as [Number of Products] 
from Production.Product 
where Color is not null
Group by Color Having (Count(*) >= 20)

/*
4) Starting with the Sales.SalesOrderHeader table, join to the Sales.SalesOrderDetail
table. This table contains the line item details associated with each sale. From
Sales.SalesOrderDetail, join to the Production.Product table. Return the Name
column from Production.Product and assign it the column alias “Product Name”.
For each product, find out how many of each product was ordered for all orders that
occurred in 2006. Only output those products where at least 200 were ordered.*/

select P.Name  as [Product Name] , count(*) [Number of Order] from  Sales.SalesOrderHeader SH 
Inner Join Sales.SalesOrderDetail SD 
on SH.SalesOrderID = SD.SalesOrderID
Inner Join  Production.Product P 
on  SD.ProductID=P.ProductID
group by P.Name , YEAR(SH.OrderDate )
having(count(*) >= 200 and YEAR(SH.OrderDate )=2013)




/*
5) Find the first and last name of each customer who has placed at least 6 orders
between July 1, 2005 and December 31, 2006. Order your results by the number of
orders placed in descending order. (Hint: You will need to join to three tables –
Sales.SalesOrderHeader, Sales.Customer, and Person.Person. You will use every
clause to complete this query).*/


select P.FirstName as [First Name] , P.LastName as [last Name] ,count(*) as [Number of Order]
from Sales.SalesOrderHeader S
Inner JOIN Sales.Customer C
on  S.CustomerID  = C.CustomerID 
Inner JOIN Person.Person P 
on P.BusinessEntityID = C.PersonID
Where S.OrderDate between  '1999-07-01' and '2025-12-31'
Group By S.CustomerID ,[FirstName] , LastName having(count(*) >=6)
Order By [Number of Order] Desc



--Sorting using the ORDER BY Clause Practice Problems

/*
1) From the HumanResources.vEmployeeDepartment view, return the FirstName,
LastName and JobTitle columns. Sort the results by the FirstName column in
ascending order.*/

select FirstName , LastName , JobTitle from HumanResources.vEmployeeDepartment Order By FirstName


/*
2) Modify the query from question 1 to sort the results by the FirstName column in
ascending order and then by the LastName column in descending order.*/
select FirstName , LastName , JobTitle from HumanResources.vEmployeeDepartment Order By FirstName , LastName Desc


/*
3) From the Sales.vIndividualCustomer view, return the FirstName, LastName and
CountryRegionName columns. Sort the results by the CountryRegionName column.
Use the column ordinal in the ORDER BY clause.*/

select FirstName, LastName ,CountryRegionName  from Sales.vIndividualCustomer Order BY 3

/*
4) From the Sales.vIndividualCustomer view, return the FirstName, LastName and
CountryRegionName columns for those rows with a CountryRegionName that is
either “United States” or “France”. Sort the results by the CountryRegionName
column in ascending order.*/

select FirstName, LastName ,CountryRegionName  from Sales.vIndividualCustomer Where CountryRegionName in ('United States','France')  Order BY 3


/*
5) From the Sales.vStoreWithDemographics view, return the Name, AnnualSales,
YearOpened, SquareFeet, and NumberEmployees columns. Give the SquareFeet
column the alias “Store Size” and the NumberEmployees column the alias “Total
Employees”. Return only those rows with AnnualSales greater than 1,000,000 and
with NumberEmployees greater than or equal to 45. Order your results by the
“Store Size” alias in descending order and then by the “Total Employees” alias in
descending order.*/


select Name, AnnualSales,
YearOpened, SquareFeet as [store Size], NumberEmployees as [Total Employees] from Sales.vStoreWithDemographics
where AnnualSales > 1000000 and NumberEmployees >45 Order By [store Size] Desc , [Total Employees] Desc 



--                   INNER JOIN Practice Problems


/*
1) Using the Person.Person and Person.Password tables, INNER JOIN the two tables
using the BusinessEntityID column and return the FirstName and LastName
columns from Person.Person and then PasswordHash column from
Person.Password*/

select person.FirstName ,person.LastName ,pasword.PasswordHash from Person.Person person
Inner Join Person.Password pasword
on Person.BusinessEntityID = pasword.BusinessEntityID




/*
2) Join the HumanResources.Employee and the
HumanResources.EmployeeDepartmentHistory tables together via an INNER JOIN
using the BusinessEntityID column. Return the BusinessEntityID,
NationalIDNumber and JobTitle columns from HumanResources.Employee and the
DepartmentID, StartDate, and EndDate columns from
HumanResources.EmployeeDepartmentHistory. Notice the number of rows
returned. Why is the row count what it is?*/

select * from HumanResources.Employee
select * from HumanResources.EmployeeDepartmentHistory

select E.BusinessEntityID,
E.NationalIDNumber, E.JobTitle, 
H.DepartmentID, H.StartDate, H.EndDate   from HumanResources.Employee E Inner Join HumanResources.EmployeeDepartmentHistory H
on E.BusinessEntityID = H.BusinessEntityID



/*
3) Expand upon the query used in question 1. Using the existing query, add another
INNER JOIN to the Person.EmailAddress table and include the EmailAddress column
in your select statement.*/

select top 3  person.FirstName ,person.LastName ,pasword.PasswordHash ,E.EmailAddress from Person.Person person
Inner Join Person.Password pasword
on Person.BusinessEntityID = pasword.BusinessEntityID
Join Person.EmailAddress E on E.BusinessEntityID = person.BusinessEntityID 




/*
4) Using the Book, BookAuthor and Author tables, join them together so that you
return the Title and ISBN columns from Book and the AuthorName column from
Author. (Hint: You must start with the BookAuthor table in your FROM clause even
though we will not be returning any columns from this table)*/







/*
5) Using the query from example 4, add another INNER JOIN that joins the Publisher
table with your query. Return the PublisherName column from this table. So, you
should return the Title and ISBN columns from Book, the AuthorName column from
Author, and the PublisherName column from Publisher. (Hint: this will require
three separate INNER JOINs).*/