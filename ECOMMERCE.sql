CREATE DATABASE ECOMMERCE
USE ECOMMERCE


CREATE TABLE ECOMMERCE_USER (
EID INT,
ENAME VARCHAR(20),
ADDRESS VARCHAR(255) , 
PHONE_NUMBER INT ,
EMAIL VARCHAR(22),
ROLE VARCHAR(12),
PASSWORD VARCHAR(24));


create TABLE PRODUCTS (
PID INT,
PNAME VARCHAR(20),
PRICE INT,
CATEGORY VARCHAR(20),
SUBCATEGORY VARCHAR(20),
CREATED_BY VARCHAR(20),
CREATED_AT datetime,
UPDATED_AT DATETIME,
QUANTITY INT)

CREATE TABLE CUSTOMERS_ORDER (
ODERE_ID INT,
BUYER_ID INT,
PRODUCT_NAME VARCHAR(20),
CUSTOMER_NAME VARCHAR(20),
ORDER_DATE DATETIME,
PAYMENT_AMOUNT INT ,
MODE_OF_PAYEMENT VARCHAR(20),
PAYMENT_STATUS VARCHAR(20),
DELIVERY_DATE DATETIME,
DELIVERY_STATUS VARCHAR(20))


CREATE TABLE CATEGORY (
CID INT,
CNAME VARCHAR (20),
NUMBER_OF_PRODUCTS INT,
CREATE_AT DATETIME)


select * from ECOMMERCE_USER
SELECT * FROM PRODUCTS
SELECT * FROM CUSTOMERS_ORDER
SELECT * FROM CATEGORY

INSERT INTO ECOMMERCE_USER (EID, ENAME, ADDRESS, PHONE_NUMBER, EMAIL, ROLE, PASSWORD) VALUES
(1, 'Raj Kumar', '123 gotri vadodara', 9876543, 'raj@email.com', 'Admin', 'pass123'),
(2, 'Priya Sharma', '456 vasna bhayli', 8765432, 'priya@email.com', 'Customer', 'pass456'),
(3, 'Amit Patel', '789 up prayagraj', 7654321, 'amit@email.com', 'Seller', 'pass789');


INSERT INTO PRODUCTS (PID, PNAME, PRICE, CATEGORY, SUBCATEGORY, CREATED_BY, CREATED_AT, UPDATED_AT, QUANTITY) VALUES 
(1, 'OnePlus Phone', 35000, 'Electronics', 'Phones', 'Raj Kumar', '2023-01-01', '2023-01-01', 50),
(2, 'Kurta Set', 1999, 'Clothing', 'Traditional', 'Amit Patel', '2023-01-02', '2023-01-02', 100),
(3, 'Pressure Cooker', 1500, 'Appliances', 'Kitchen', 'Amit Patel', '2023-01-03', '2023-01-03', 75);


INSERT INTO CUSTOMERS_ORDER (ODERE_ID, BUYER_ID, PRODUCT_NAME, CUSTOMER_NAME, ORDER_DATE, PAYMENT_AMOUNT, MODE_OF_PAYEMENT, PAYMENT_STATUS, DELIVERY_DATE, DELIVERY_STATUS) VALUES
(1, 2, 'OnePlus Phone', 'Priya Sharma', '2023-02-01', 35000, 'UPI', 'Completed', '2023-02-05', 'Delivered'),
(2, 2, 'Kurta Set', 'Priya Sharma', '2023-02-02', 1999, 'Net Banking', 'Completed', '2023-02-06', 'Delivered'),
(3, 2, 'Pressure Cooker', 'Priya Sharma', '2023-02-03', 1500, 'Cash on Delivery', 'Pending', '2023-02-07', 'In Transit');

INSERT INTO CATEGORY (CID, CNAME, NUMBER_OF_PRODUCTS, CREATE_AT) VALUES
(1, 'Electronics', 1, '2023-01-01'),
(2, 'Clothing', 1, '2023-01-01'),
(3, 'Appliances', 1, '2023-01-01');


ALTER TABLE CUSTOMERS_ORDER RENAME COLUMN 'ODERE_ID' TO 'ORDER_ID' --NOT WORKING

EXEC sp_rename 'CUSTOMERS_ORDER.ODERE_ID',  'ORDER_ID', 'COLUMN';


ALTER TABLE PRODUCTS ADD DESCRIPTION VARCHAR(500);
ALTER TABLE PRODUCTS DROP COLUMN DESCRIPTION; 

UPDATE PRODUCTS SET PRICE = 32000 WHERE PID = 1;
UPDATE CATEGORY SET NUMBER_OF_PRODUCTS = 2 WHERE CID = 2;


DELETE FROM PRODUCTS WHERE PID = 3;
DELETE FROM CATEGORY WHERE NUMBER_OF_PRODUCTS = 0;


SELECT * FROM PRODUCTS WHERE PRICE > 2000;
SELECT * FROM CUSTOMERS_ORDER WHERE DELIVERY_STATUS = 'Delivered';


SELECT * FROM CUSTOMERS_ORDER 
WHERE BUYER_ID IN (SELECT EID FROM ECOMMERCE_USER WHERE ROLE = 'Customer');


select name from sys.tables
exec sp_help PRODUCTS


INSERT INTO ECOMMERCE_USER (EID, ENAME, ADDRESS, PHONE_NUMBER, EMAIL, ROLE, PASSWORD) VALUES
(4, 'Meera Singh', '234 Race Course, Mumbai', 6543210, 'meera@email.com', 'Customer', 'pass321'),
(5, 'Rahul Verma', '567 MG Road, Delhi', 5432109, 'rahul@email.com', 'Customer', 'pass654'),
(6, 'Neha Gupta', '890 Park Street, Kolkata', 4321098, 'neha@email.com', 'Seller', 'pass987'),
(7, 'Karan Shah', '123 Ring Road, Surat', 3210987, 'karan@email.com', 'Seller', 'pass147'),
(8, 'Anita Roy', '456 Lake Road, Bangalore', 2109876, 'anita@email.com', 'Customer', 'pass258'),
(9, 'Suresh Kumar', '789 Hill Road, Chennai', 1098765, 'suresh@email.com', 'Customer', 'pass369'),
(10, 'Pooja Mehta', '321 Beach Road, Goa', 9087654, 'pooja@email.com', 'Seller', 'pass741'),
(11, 'Vikram Malhotra', '654 Garden Street, Pune', 8976543, 'vikram@email.com', 'Customer', 'pass852'),
(12, 'Deepa Reddy', '987 Market Road, Hyderabad', 7865432, 'deepa@email.com', 'Seller', 'pass963'),
(13, 'Arun Joshi', '147 Mall Road, Jaipur', 6754321, 'arun@email.com', 'Customer', 'pass159');


INSERT INTO PRODUCTS (PID, PNAME, PRICE, CATEGORY, SUBCATEGORY, CREATED_BY, CREATED_AT, UPDATED_AT, QUANTITY) VALUES 
(4, 'Samsung TV', 45000, 'Electronics', 'Television', 'Neha Gupta', '2023-01-04', '2023-01-04', 30),
(5, 'Running Shoes', 2999, 'Clothing', 'Footwear', 'Karan Shah', '2023-01-05', '2023-01-05', 200),
(6, 'Laptop', 65000, 'Electronics', 'Computers', 'Neha Gupta', '2023-01-06', '2023-01-06', 25),
(7, 'Jeans', 1499, 'Clothing', 'Casual', 'Amit Patel', '2023-01-07', '2023-01-07', 150),



INSERT INTO CUSTOMERS_ORDER VALUES
(4, 4, 'Samsung TV', 'Meera Singh', '2023-02-10', 45000, 'Credit Card', 'Completed', '2023-02-15', 'Delivered'),
(5, 5, 'Running Shoes', 'Rahul Verma', '2023-02-11', 2999, 'Debit Card', 'Completed', '2023-02-16', 'Delivered'),
(6, 4, 'Laptop', 'Meera Singh', '2023-02-12', 65000, 'EMI', 'Completed', '2023-02-17', 'Delivered'),
(7, 5, 'Jeans', 'Rahul Verma', '2023-02-13', 1499, 'UPI', 'Completed', '2023-02-18', 'In Transit'),
(8, 2, 'Microwave', 'Priya Sharma', '2023-02-14', 8999, 'Net Banking', 'Pending', '2023-02-19', 'Processing'),
(9, 4, 'Coffee Maker', 'Meera Singh', '2023-02-15', 3999, 'UPI', 'Completed', '2023-02-20', 'Delivered'),



INSERT INTO CATEGORY (CID, CNAME, NUMBER_OF_PRODUCTS, CREATE_AT) VALUES
(4, 'Footwear', 1, '2023-01-05'),
(5, 'Kitchen Appliances', 3, '2023-01-08');


select * from ECOMMERCE_USER
select * from PRODUCTS
select * from CUSTOMERS_ORDER
select * from CATEGORY


select BUYER_ID,
SUM(case when PAYMENT_AMOUNT is null then PAYMENT_AMOUNT  else 0 end )as 
Payments from CUSTOMERS_ORDER group by BUYER_ID

select COUNT(ORDER_ID) from CUSTOMERS_ORDER 
select COUNT(BUYER_ID) from CUSTOMERS_ORDER 
select MIN(BUYER_ID) as minID from CUSTOMERS_ORDER 
select MAX(BUYER_ID) as maxID from CUSTOMERS_ORDER 
select BUYER_ID,Max( PAYMENT_AMOUNT ) AS HIGHESTPAYMENT FROM CUSTOMERS_ORDER GROUP BY BUYER_ID
select BUYER_ID,min( PAYMENT_AMOUNT ) AS LOWESTTPAYMENT FROM CUSTOMERS_ORDER GROUP BY BUYER_ID
select BUYER_ID,sum( PAYMENT_AMOUNT ) AS TOTALTPAYMENT FROM CUSTOMERS_ORDER GROUP BY BUYER_ID
SELECT BUYER_ID , COUNT(BUYER_ID) AS ITEMS_PURCHASED FROM CUSTOMERS_ORDER GROUP BY BUYER_ID ORDER BY BUYER_ID

SELECT PRODUCT_NAME,COUNT(PRODUCT_NAME) AS 
SOLD_QUANTITY FROM CUSTOMERS_ORDER 
GROUP BY PRODUCT_NAME 
ORDER BY SOLD_QUANTITY DESC

SELECT BUYER_ID ,SUM(PAYMENT_AMOUNT) AS PAYED
FROM CUSTOMERS_ORDER GROUP BY 
BUYER_ID HAVING SUM(PAYMENT_AMOUNT) < 10000 
ORDER BY PAYED desc


select * from sys.tables 

select * from ECOMMERCE_USER
select * from PRODUCTS


select SUM(PRICE) AS TOTAL_AMT from PRODUCTS WHERE CATEGORY='Electronics'
select SUM(PRICE) AS TOTAL_AMT from PRODUCTS WHERE CATEGORY='Electronics' GROUP BY CATEGORY

