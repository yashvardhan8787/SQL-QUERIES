--command to create database
CREATE DATABASE JAN
--command to use database
USE JAN
--command to chnage the name of a database.
ALTER DATABASE JAN MODIFY NAME=JAN2025

--command to drop(DELETE) a database.
DROP DATABASE JAN2025
--sql in case insensitive --
--query for creating tabels , 
--EID ENAME EAGE DEPARTMENT SALARY CITY these are attributes(colounm) of tables,
CREATE TABLE EMPLOYEEDETAILS (
EID INT, 
ENAME VARCHAR(20),
EAGE INT,
DEPARTMENT VARCHAR(20),
SALARY MONEY,
CITY VARCHAR(20))

--select is a literal , "SELECT *" is a bad habit alawys select what u need.
select 4+3
--"" is invalid becuse it only supports single '' qoutes.
-- beacuse when u use "" it search that in table.
select 'beacuse of thala' 

select 'MSD' as WK ,'GG' as BATSMAN
select 'MSD' as 'CAPTAIN'

--query to list all the databases ,sp satads for stored procedures
execute sp_databases


--select or diaplay the names of all the tables in the working database.
select name from sys.tables 
select name, create_date from sys.tables
select name, create_date,modify_date from sys.tables

--to insert values in a table.
INSERT INTO EMPLOYEEDETAILS VALUES (1,'yash',20,'FS',100000,'vadodara')
--supplied values does not match tables definations ,bescues values u r passing to 
--insert either its is not in current order or every values are not present 
INSERT INTO EMPLOYEEDETAILS VALUES (2,'harsh',20,'FS','vadodara')--not allowed
--right snytax to run above query.
INSERT INTO EMPLOYEEDETAILS 
(EID , ENAME ,EAGE ,DEPARTMENT,CITY )  VALUES 
(2,'harsh',20,'FS','vadodara')

--query to insert multiple rows in once .
INSERT INTO EMPLOYEEDETAILS VALUES 
(3,'vraj',20,'FS',100000,'vadodara'),
(4,'vansh',20,'DA',100000,'surat'),
(5,'matin',20,'QA',100000,'anand'),
(6,'jay',20,'DE',100000,'surat'),
(7,'kuldip',20,'FS',100000,'ahemdabad')

--query for inserting  multiple rows for specific attributes
INSERT INTO EMPLOYEEDETAILS 
(EID , ENAME ,DEPARTMENT,CITY )  VALUES 
(8,'suresh','DA','vadodara'),
(9,'pratham','DS','dahod')

--UPDATES QUERRIES----
--method -1 -using where clause
update EMPLOYEEDETAILS SET EAGE =22 where EID = 1

--method -2
update EMPLOYEEDETAILS SET EAGE=18 where EAGE is Null

--method -3 without filter 
update EMPLOYEEDETAILS set SALARY=25000 where SALARY is NOT NULL

--method -4 filtering with two conditons 
update EMPLOYEEDETAILS set SALARY=30000 where SALARY is NOT NULL AND CITY='vadodara'


--- DETELE methods --
--method 1 
DELETE from EMPLOYEEDETAILS where EID=8
--mehtod 2 
delete from EMPLOYEEDETAILS where SALARY is Null
--mehtod 3 to delete all records 
delete from EMPLOYEEDETAILS



--     DELETE            vs          DROP            vs           TRUNCATE
--can delete all the         it deletes all the            it deletes all the records 
--records individually       records along with the        from the tables ,but does not 
--or all in once with        table schema.                 deletes the table schema, and we 
--or without condition.                                    do not put conditon on it , its 
--                                                         purpose is to delete all record in once.



--where clause (used for filtering )
select * from EMPLOYEEDETAILS where DEPARTMENT= 'QA'
select * from EMPLOYEEDETAILS where DEPARTMENT= 'QA' or DEPARTMENT= 'DA'
select * from EMPLOYEEDETAILS where DEPARTMENT= 'QA' and EAGE=22
select * from EMPLOYEEDETAILS where (DEPARTMENT= 'QA' and EAGE=22) or EAGE=20
select * from EMPLOYEEDETAILS where DEPARTMENT= 'QA' and (EAGE=22 or EAGE=20)


--using comaprisson operators <>, <, >, = , <= , >=,!= , and "between" and LIKE keyword 
select * from EMPLOYEEDETAILS where  EAGE=22
select * from EMPLOYEEDETAILS where  EAGE>22
select * from EMPLOYEEDETAILS where  EAGE<22
select * from EMPLOYEEDETAILS where  EAGE<=22
select * from EMPLOYEEDETAILS where  EAGE>=22
select * from EMPLOYEEDETAILS where  EAGE BETWEEN 20 and 22 --includes border values also .
select * from EMPLOYEEDETAILS  where ENAME like 'y%'
select * from EMPLOYEEDETAILS  where ENAME like '%y'
select * from EMPLOYEEDETAILS  where ENAME like '%y%'


select * from EMPLOYEEDETAILS



/*

1) Return the Name column from Employeedetails where the Name column is equal to
"Suresh".*/
select * from EMPLOYEEDETAILS where ENAME='suresh'


/*
2) Find the top 100 rows from Employeedetails where the Salary is not equal to 0.*/
select TOP 10  * from EMPLOYEEDETAILS where SALARY != 0

/*
3) Return all rows and columns from Employeedetails where the employee�s Name starts with a
letter less than �D�.*/

select * from EMPLOYEEDETAILS where ENAME like '%a' or ENAME like '%b' or ENAME like '%c'

/*
4) Return all rows and columns from Employeedetails where the City column is equal to "New
York".*/

select * from EMPLOYEEDETAILS where CITY='New York'

/*
5) Return the Name column from Employeedetails where the Name is equal to "Suresh". Give
the column alias "Employee Name".*/
select ENAME as'EMPLOYEE NAME' from EMPLOYEEDETAILS where ENAME='suresh'

/*
6) Using the Employeedetails table, find all employees with a Department equal to "QA" or all
employees who have an Age greater than 23 and a Salary less than 50000.*/
select * from EMPLOYEEDETAILS where (DEPARTMENT='QA' or EAGE>23) and SALARY < 50000

/*
7) Find all employees from Employeedetails who have a Department in the list of: "DA", "FS",
and "DE". Complete this query twice � once using the IN operator in the WHERE clause and a
second time using multiple OR operators.*/
select * from EMPLOYEEDETAILS where DEPARTMENT='DA' or DEPARTMENT='FS' or DEPARTMENT='DE'
select * from EMPLOYEEDETAILS where DEPARTMENT in ('DA','FS','DE')

/*
8) Find all employees from Employeedetails whose Name starts with the letter �A�.*/
select * from EMPLOYEEDETAILS where ENAME like 'A%' 
/*
9) Find all employees from Employeedetails whose Name ends with the letter �a�.*/
select * from EMPLOYEEDETAILS where ENAME like '%a' 
/*
10) Return all columns from the Employeedetails table for all employees who have a
Department. That is, return all rows where the Department column does not contain a NULL
value.*/
SELECT * FROM EMPLOYEEDETAILS WHERE DEPARTMENT is not null
/*
11) Return the EID and Salary columns from Employeedetails for all employees who have a
Department and whose Salary exceeds 20,000.
*/
select EID ,SALARY from EMPLOYEEDETAILS where DEPARTMENT is not null and SALARY>20000

/* for chnaging table name   */
execute sp_rename 'EMPLOYEEDETAILS' ,'emp'

/* for chnaging column name order table    */
EXEC sp_rename 'CUSTOMERS_ORDER.ODERE_ID',  'ORDER_ID', 'COLUMN';

-- it is a default stored procedure , and it gives structre of table along with constrains aplied on  it 
exec sp_help emp



--Alter commands for renaming
ALTER DATABASE database_name MODIFY NAME = new_database_name  --change database name
EXEC sp_rename 'old_table_name', 'new_table_name'  --change table name 
EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN'  --change column name

--Alter - modify existing column
ALTER TABLE emp ALTER COLUMN SALARY INT  --change datatype
ALTER TABLE emp ALTER COLUMN ENAME VARCHAR(50)  --change size

--Alter - add new column
ALTER TABLE emp 
ADD EMAIL VARCHAR(50)

ALTER TABLE emp
ADD PHONE_NUMBER VARCHAR(15), ADDRESS VARCHAR(100)  --add multiple columns

--Alter - drop column
ALTER TABLE emp
DROP COLUMN EMAIL

ALTER TABLE emp 
DROP COLUMN PHONE_NUMBER, ADDRESS  --drop multiple columns

drop table EMPLOYEEDETAILS;
----------------constraints 

CREATE TABLE EMPLOYEEDETAILS (
EID INT primary key , 
ENAME VARCHAR(20),
EAGE INT check(EAGE >= 18 ),
DEPARTMENT VARCHAR(20),
SALARY MONEY Check(salary >= 5000),
CITY VARCHAR(20))

--query to insert multiple rows in once .
INSERT INTO EMPLOYEEDETAILS VALUES 
(3,'vraj',18,'FS',100000,'vadodara'),
(4,'vansh',20,'DA',100000,'surat'),
(5,'matin',20,'QA',5000,'anand'),
(6,'jay',20,'DE',100000,'surat'),
(7,'kuldip',20,'FS',100000,'ahemdabad')


select * from EMPLOYEEDETAILS



create table Department(
DID int primary key ,
Dname Varchar(40),
location varchar(40))


Insert into Department values(30 ,'QA','GROUNDFLOOR')

Insert into Department values(1,'QA','FIRSTFLOOR')

Insert into Department values(5 ,'QA','GROUNDFLOOR')

Insert into Department values(7 ,'QA','SECONDFLOOR')


CREATE TABLE EMP_DEPERTAMENT(
EmpID int PRIMARY key ,
Ename VARCHAR(50) ,
DepID int ,
constraint Emp_id_FK foreign key (EmpID)  references EMPLOYEEDETAILS(EID),
constraint dep_id_FK foreign key (DepID)  references Department(DID),
)


insert into EMP_DEPERTAMENT values
(3,'vraj',30),
(4,'vansh',1),
(5,'matin',5),
(6,'jay',7)


select * from EMP_DEPERTAMENT
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('EMP_DEPERTAMENT')-- to see the Indexes on table .

-- SET OPERATORS (UNION, INTERSECT, EXCEPT)
CREATE TABLE BANK_BRD
(BID INT, BANME VARCHAR(20), LOCATION VARCHAR(20))

INSERT INTO BANK_BRD VALUES
(10,'SBI','ATLADRA'),
(20,'HDFC','AKOTA'),
(30,'ICICI','ALKAPURI')

CREATE TABLE BANK_AMD
(ID INT, BNAME  VARCHAR(20), LOCATION VARCHAR(20))

INSERT INTO BANK_AMD VALUES
(10,'SBI','ATLADRA'),
(40,'AXIX','CTM'),
(50,'KOTAK','AMBAWADI')

SELECT * FROM BANK_BRD
SELECT * FROM BANK_AMD
Drop table BANK_AMD


--unioun --removes common values in both tables .
--umber of columns must be same.







--ordr of the columns must be same .
--datatype of the columns must be same .
select * from BANK_AMD
UNION 
select * from BANK_BRD
-- gives all values including common values .
select * from BANK_AMD
UNION ALL
select * from BANK_BRD

--intersection gives only a common values from both the tables.
select * from BANK_AMD
INTERSECT
select * from BANK_BRD

-- IT gives all the values that are in first table but not in second  table .
select * from BANK_AMD
except 
select * from BANK_BRD
--