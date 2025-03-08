CREATE DATABASE YASHVARDHAN;

USE YASHVARDHAN;

create table Employee(
EmployeeID int,
EmployeeName varchar(100),
Department varchar(50),
DOJ date,
ProjectName varchar(100),
ProjectID int
)

insert into Employee 

values
(101,'yash vardhan' , 'IT' , '2003-10-11','E-commerce' ,501),
(102,'vraj soni' , 'ME' , '2004-01-01','Electric Engine' ,502),
(103,'vansh khasia ' , 'EE' , '2002-01-01','Fiber Optics' ,503),
(104,'jay kishor' , 'IT' , '2022-09-11','Social Media App' ,504),
(105,'matin saikh' , 'IT' , '2022-08-11','Weather App' ,505),
(105,'kuldip sinh' , 'IT' , '2022-07-11','OTT Application' ,506)


select * from Employee
--question 2
Alter table Employee Alter Column EmployeeName varchar(150)

--question 3 
exec sp_rename 'Employee' ,'EmployeeDetails'

--question 4 
 Update EmployeeDetails set Department='HR' where EmployeeID=101

--question 5 
Delete from EmployeeDetails where DOJ > '2022-01-01'


--question 6 
insert into EmployeeDetails
values
(101,'yash vardhan' , 'IT' , '2003-10-11','E-commerce' ,501),
(102,'vraj soni' , 'ME' , '2004-01-01','Electric Engine' ,502),
(103,'vansh khasia ' , 'EE' , '2002-01-01','Fiber Optics' ,503),
(106,'jay shah' , 'DA' , '2022-09-11','weather forcast' ,511),
(107,'matin cuttlery' , 'BA' , '2022-08-11','Web App' ,512),
(108,'kuldip rathod' , 'HR' , '2022-07-11','ERP' ,513)


--question 7 
select * from EmployeeDetails where Department='HR' or Department='IT'


--question 8 
select * from EmployeeDetails where  Department !='Marketing'

--question 9 
select * from EmployeeDetails where  EmployeeName like 'A%'

--question 10 
select * from EmployeeDetails where DOJ >'2022-01-01' and  DOJ < '2023-01-01'

--question 11
select * from EmployeeDetails where  ProjectName like '%Finance%'

--question 12 
select * from EmployeeDetails where ProjectID is null


--question 13 
select * from EmployeeDetails where  EmployeeName like 'J%';

--question -14 
select * from EmployeeDetails where Department='IT' and ProjectID > 500;

--question 15 
select * from EmployeeDetails where EmployeeID >= 500;


select * from Employees

select name,modify_date ,create_date from sys.tables

exec sp_help 'employees'
