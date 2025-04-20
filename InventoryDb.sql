Create Database InventoryDB;


use InventoryDB;

CREATE TABLE SALESMAN(
SALESMAN_ID NUMERIC(5),
NAME VARCHAR(30),
CITY VARCHAR(15),
COMMISSION DECIMAL(5,2),
CONSTRAINT PK_SALESMAN PRIMARY KEY (SALESMAN_ID) 
);



CREATE TABLE CUSTOMER(
CUSTOMER_ID NUMERIC(5),
CUST_NAME VARCHAR(30),
CITY VARCHAR(15),
GRADE NUMERIC(3),
SALESMAN_ID NUMERIC(5),
CONSTRAINT FK_CUSTOMER FOREIGN KEY (SALESMAN_ID) REFERENCES salesman(SALESMAN_ID),
CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUSTOMER_ID));


CREATE TABLE ORDERS(
ORDR_ID NUMERIC(5),
PURCH_AMT DECIMAL(8,2),
ORDR_DATE DATE,
CUSTOMER_ID NUMERIC(5),
SALESMAN_ID NUMERIC(5),
CONSTRAINT FK_ORDERS_CUSTOMER FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
CONSTRAINT FK_ORDERS_SALESMAN FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID));


INSERT INTO SALESMAN (SALESMAN_ID, NAME, CITY, COMMISSION) VALUES
(10001, 'John Smith', 'New York', 0.15),
(10002, 'Emily Davis', 'Los Angeles', 0.13),
(10003, 'Michael Brown', 'Chicago', 0.14),
(10004, 'Sarah Johnson', 'Houston', 0.12),
(10005, 'David Wilson', 'Phoenix', 0.10),
(10006, 'Emma Taylor', 'Dallas', 0.17),
(10007, 'Chris Lee', 'San Diego', 0.11),
(10008, 'Olivia Martin', 'San Jose', 0.09),
(10009, 'James Clark', 'Austin', 0.16),
(10010, 'Sophia Lewis', 'Philadelphia', 0.18);



INSERT INTO CUSTOMER (CUSTOMER_ID, CUST_NAME, CITY, GRADE, SALESMAN_ID) VALUES
(20001, 'Alice Walker', 'New York', 100, 10001),
(20002, 'Brian Hall', 'Los Angeles', 200, 10002),
(20003, 'Catherine Adams', 'Chicago', 150, 10003),
(20004, 'Daniel Moore', 'Houston', 300, 10004),
(20005, 'Evelyn Allen', 'Phoenix', 250, 10005),
(20006, 'Frank White', 'Dallas', 180, 10006),
(20007, 'Grace Harris', 'San Diego', 190, 10007),
(20008, 'Henry Young', 'San Jose', 210, 10008),
(20009, 'Isabella King', 'Austin', 170, 10009),
(20010, 'Jack Wright', 'Philadelphia', 220, 10010);




INSERT INTO ORDERS (ORDR_ID, PURCH_AMT, ORDR_DATE, CUSTOMER_ID, SALESMAN_ID) VALUES
(30001, 1200.50, '2024-11-01', 20001, 10001),
(30002, 340.00,  '2024-11-02', 20002, 10002),
(30003, 560.75,  '2024-11-03', 20003, 10003),
(30004, 780.20,  '2024-11-04', 20004, 10004),
(30005, 450.00,  '2024-11-05', 20005, 10005),
(30006, 999.99,  '2024-11-06', 20006, 10006),
(30007, 880.10,  '2024-11-07', 20007, 10007),
(30008, 610.45,  '2024-11-08', 20008, 10008),
(30009, 720.30,  '2024-11-09', 20009, 10009),
(30010, 1500.00, '2024-11-10', 20010, 10010);

SELECT * FROM SALESMAN 
SELECT * FROM CUSTOMER
SELECT * FROM ORDERS


-----------------------QUESTIIONS

--Display all the details of the salesman.

SELECT * FROM SALESMAN

--Show the names of customers who live in 'Chicago'.

SELECT * FROM CUSTOMER WHERE CITY='CHICAGO'

--Retrieve the names and commission of all salesmen with a commission greater than 0.12.

SELECT * FROM SALESMAN WHERE COMMISSION > .12

--List all customers sorted by their grade in descending order.

SELECT * FROM CUSTOMER ORDER BY GRADE

--Display only those customers whose grade is between 150 and 250.
SELECT * FROM CUSTOMER WHERE GRADE BETWEEN 150 AND 250 ;


--List customer names that start with 'A'

SELECT * FROM CUSTOMER WHERE CUST_NAME LIKE 'A%'

--Show all orders placed after '2024-11-05'

SELECT * FROM ORDERS WHERE ORDR_DATE > '2024-11-05'

--Display the top 5 orders with the highest purchase amount.

SELECT TOP 5 * FROM ORDERS ORDER BY PURCH_AMT DESC

--Find the city and name of all salesmen whose commission is not equal to 0.10.
SELECT CITY ,NAME FROM SALESMAN WHERE COMMISSION  <> 0.10

--Show all customers who are handled by the salesman from 'Houston'.

SELECT * FROM CUSTOMER WHERE SALESMAN_ID IN (SELECT SALESMAN_ID FROM SALESMAN WHERE CITY ='HOUSTON');



--------------------------------------------------------------JOINS

--Write a query to list all customers with their respective salesman's name (use INNER JOIN).

SELECT C.CUST_NAME AS [CUSTOMER NAME], S.NAME AS [SALESMAN] FROM  CUSTOMER C JOIN  SALESMAN S ON C.SALESMAN_ID = S.SALESMAN_ID

--List all orders along with customer name and salesman name (use JOINs).
SELECT O.CUSTOMER_ID,C.CUST_NAME AS [CUSTOMER NAME],O.ORDR_DATE,O.ORDR_ID,O.PURCH_AMT,O.SALESMAN_ID,S.NAME AS [SALESMAN] FROM ORDERS O
JOIN customer C ON  C.CUSTOMER_ID = O.CUSTOMER_ID
JOIN salesman S ON  S.SALESMAN_ID = O.SALESMAN_ID

--Retrieve all customers and their orders (even if no orders placed).

SELECT O.CUSTOMER_ID,C.CUST_NAME AS [CUSTOMER NAME],O.ORDR_DATE,O.ORDR_ID,O.PURCH_AMT,O.SALESMAN_ID FROM CUSTOMER  C LEFT JOIN ORDERS  O ON C.CUSTOMER_ID=O.CUSTOMER_ID 


--Show all salesmen and the customers they serve (even if no customers).
SELECT * FROM SALESMAN S LEFT JOIN ORDERS O  
ON S.SALESMAN_ID = O.SALESMAN_ID
JOIN CUSTOMER C ON O.CUSTOMER_ID =C.CUSTOMER_ID


--Show all salesmen along with total number of customers each has (use GROUP BY and JOIN).

SELECT S.NAME ,COUNT(DISTINCT C.CUSTOMER_ID) AS CUSTOMERS FROM SALESMAN S LEFT JOIN  ORDERS O ON S.SALESMAN_ID= O.SALESMAN_ID
JOIN CUSTOMER C ON O.CUSTOMER_ID= C.CUSTOMER_ID GROUP BY (S.NAME)

--Retrieve names of customers and salesmen who belong to the same city

SELECT S.NAME AS SALESMAN , C.CUST_NAME AS  CUSTOMER , C.CITY AS [CUTOMER'S CITY] , S.CITY
AS [SALESMAN'S CITY] FROM SALESMAN S JOIN CUSTOMER C ON S.CITY=C.CITY


--List orders with the salesman’s city for each order.
SELECT
     O.ORDR_ID,
    O.PURCH_AMT,
    O.ORDR_DATE,
    C.CUST_NAME AS CUSTOMER,
    S.NAME AS SALESMAN,
    S.CITY AS CITY FROM ORDERS O 
JOIN SALESMAN S ON O.SALESMAN_ID=S.SALESMAN_ID 
JOIN CUSTOMER C ON O.CUSTOMER_ID =C.CUSTOMER_ID
WHERE C.CITY = S.CITY


--Write a query to find customers who did not place any orders.
SELECT * FROM CUSTOMER C LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.ORDR_ID IS NULL

--Find salesmen who do not serve any customers.
SELECT S.*
FROM SALESMAN S
LEFT JOIN CUSTOMER C ON S.SALESMAN_ID = C.SALESMAN_ID
WHERE C.CUSTOMER_ID IS NULL;


--List orders along with purchase amount and their corresponding customer city and grade.

SELECT C.* , O.ORDR_ID  FROM ORDERS O JOIN CUSTOMER C 
ON O.CUSTOMER_ID = C.CUSTOMER_ID

/*
🔹 Section C: Aggregate Functions, GROUP BY, HAVING – (10 Questions)
Find the total number of orders.*/

--Get the average purchase amount for each salesman.

select o.SALESMAN_ID , avg(PURCH_AMT) as [Average Pasrchase Amount] from salesman s join orders o on s.SALESMAN_ID = o.SALESMAN_ID group by o.SALESMAN_ID



--Find the maximum and minimum grade among all customers.

select min(GRADE) As [MIN Grade],max(GRADE) as[MAX Grade] from customer

--Count the number of customers in each city.


select CITY , count(*) from customer group by CITY



--Show the total purchase amount for each customer.

select o.CUSTOMER_ID , SUM(PURCH_AMT) from orders o join customer c 
on o.CUSTOMER_ID = c.CUSTOMER_ID 
group By o.CUSTOMER_ID



--List all cities having more than 1 customer.

select CITY , count(*) as[count of customer] from customer group by CITY having COUNT(*) > 1



--Retrieve total number of orders for each salesman.
select o.SALESMAN_ID , count(*) as [Number of IDs] from  orders o join salesman s
on o.SALESMAN_ID = s.SALESMAN_ID group by o.SALESMAN_ID

--Find the average commission of salesmen in each city.
select CITY , AVG(COMMISSION) AS [Average Commision] from salesman Group by CITY



--Get the total sales value grouped by salesman city.
select  s.CITY, Sum(o.PURCH_AMT) as [total SAles value ] from orders o join salesman s 
on o.SALESMAN_ID =s.SALESMAN_ID group by s.CITY



--List customers having more than one order and order them by total purchase amount.

select o.CUSTOMER_ID , sum(o.PURCH_AMT) from orders o 
join customer c on o.CUSTOMER_ID = c.CUSTOMER_ID
group by o.CUSTOMER_ID having Count(*) > 1
ORDER BY SUM(o.PURCH_AMT) DESC;





/*🔹 Section D: Subqueries – (5 Questions)*/
--Find customers who have placed orders greater than the average order amount.

select DISTINCT CUST_NAME from customer c , Orders o Where c.CUSTOMER_ID = o.CUSTOMER_ID and o.PURCH_AMT >(select AVG(PURCH_AMT) from orders)

--Show salesmen who serve customers with grade above the average.

select Name from salesman where SALESMAN_ID IN (
select o.SALESMAN_ID from Orders o join customer c 
on c.CUSTOMER_ID= o.CUSTOMER_ID where c.GRADE > (select AVG(GRADE) from customer))


--Display the names of customers who have placed the maximum order.

select CUST_NAME from customer Where CUSTOMER_ID IN (
select CUSTOMER_ID from orders Group By CUSTOMER_ID Having COUNT(*) = ( 
select MAX(ordr_count) from (select CUSTOMER_ID ,count(*) as [ordr_count] from orders Group By CUSTOMER_ID) as c))



--List salesmen who are not handling any customers (use NOT IN or NOT EXISTS).

select NAME from salesman WHERE SALESMAN_ID  NOT IN (select DISTINCT SALESMAN_ID  from Orders)

select NAME from salesman s WHERE  NOT EXISTS ( select 1 from orders o where o.SALESMAN_ID = s.SALESMAN_ID )


--Get names of customers who placed orders on the latest order date.

select CUST_NAME from customer where CUSTOMER_ID IN (select CUSTOMER_ID From ORDERS where ORDR_DATE = (select MAX(ORDR_DATE) from orders) )


/*🔹 Section E: Data Manipulation Language (DML) – (5 Questions)*/


--Insert a new customer into the CUSTOMER table.
select * from CUSTOMER

INSERT INTO CUSTOMER(CUSTOMER_ID, CUST_NAME,CITY,GRADE,SALESMAN_ID) Values( 20011,'yash','Gujarat',350,10003)

--Update commission of salesman with ID 10005 to 0.20.

Update salesman set COMMISSION=0.20 where SALESMAN_ID=10005


--Delete all orders placed before '2024-11-05'.

Delete FROM ORDERS Where ORDR_DATE < '2024-11-05'

--Increase grade of all customers in 'Dallas' by 10.
UPDATE CUSTOMER set GRADE = GRADE+10 
--Change the city of customer 'Henry Young' to 'Houston'.*

Update customer set CITY ='GUJARAT' Where CUST_NAME='Henry Young'

/*
🔹 Section F: Views – (3 Questions)*/



--Create a view named TopSalesmen showing all salesmen with commission above 0.15.

CREATE VIEW TopSalesmen As select * from salesman where COMMISSION > 0.15

select * from TopSalesmen

--Create a view CustomerOrders showing customer name, city, and their total order amount.

Create View CustomerOrders as (Select c.CUST_NAME ,CITY ,SUM(PURCH_AMT) as [Total Order Amount] from orders o join customer c on o.CUSTOMER_ID=c.CUSTOMER_ID GRoup by c.CUST_NAME,c.CITY)

select * from CustomerOrders

--Create a view SalesmanPerformance that shows each salesman with the number of customers and total orders handled.

Create view SalesmanPerformance as 
SELECT NAME , p.* From salesman s Join 
(select SALESMAN_ID , count(Distinct CUSTOMER_ID ) as [totalCustomer] , count(*) as [Total Orders] from Orders  Group by SALESMAN_ID) as p
on p.SALESMAN_ID = s.SALESMAN_ID 


select * from SalesmanPerformance

/*
🔹 Section G: Constraints and Data Definition – (3 Questions)*/


--Add a NOT NULL constraint to CITY column in the SALESMAN table.
Alter table salesman Alter column CITY VARCHAR(50) NOT null


--Alter the CUSTOMER table to add a column EMAIL of type VARCHAR(50).
ALter table customer Add  EMAIL varchar(50)

--Drop the GRADE column from the CUSTOMER table.
Alter Table customer DROP column EMAIL

/*🔹 Section H: Set Operators – (2 Questions)*/



--List all cities from both SALESMAN and CUSTOMER tables (use UNION).

select CITY from SALESMAN 
UNION 
SELECT CITY FROM  CUSTOMER 

--Find all customer cities that are not salesman cities (use EXCEPT or NOT IN).
SELECT  CITY from customer EXCEPT select CITY FROM SALESMAN

--🔹 Section I: Miscellaneous & Pattern Matching – (2 Questions)
--Find all customers whose names contain the letter 'e' in the second position.

select * from CUSTOMER where CUST_NAME LIKE '_e%'

--Display all customers whose names end with 'n'.*/

select * from CUSTOMER where CUST_NAME LIKE '%n'