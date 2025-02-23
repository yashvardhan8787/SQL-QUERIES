/* 
Assignment

| EMPLOYEE_ID | FIRST_NAME | LAST_NAME | EMAIL | PHONE_NUMBER | HIRE_DATE | JOB_ID
| SALARY | COMMISSION_PCT | MANAGER_ID | DEPARTMENT_ID |

Use the above column name and create a schema and perform below Queries.

1. Write a query to display the names (first_name, last_name) using alias name “First Name&quot;, &quot;Last
Name&quot;
2. Write a query to get unique department ID from employee table
3. Write a query to get all employee details from the employee table order by first name,
descending
4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is
calculated as 15% of salary)
5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order
of salary
6. Write a query to get the total salaries payable to employees
7. Write a query to get the maximum and minimum salary from employees table.
8. Write a query to get the average salary and number of employees in the employees table.
9. Write a query to get the number of employees working with the company.
10. Write a query to get the number of jobs available in the employees table
*/

create database assginment1 ;

use assginment1 ;


create table Employee(
 EMPLOYEE_ID int primary key identity(1,1),
 FIRST_NAME varchar(55)not null,
 LAST_NAME  varchar(55),
 EMAIL      varchar(55) unique not null ,
 PHONE_NUMBER bigint unique not null , 
 HIRE_DATE date not null , 
 JOB_ID int not null,
 SALARY  money , 
 COMMISSION_PCT float,
 MANAGER_ID int not null,
 DEPARTMENT_ID int not null , 
)

  
INSERT INTO Employee
(FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)  
VALUES  
('yash', 'singh', 'yash@gmail.com', '8787021710', '2002-10-12', '1234', 40000, 15, 123, 1111),  
('vansh', 'khasia', 'vansh@gmail.com', '8787021787', '2003-10-09', '1230', 45000, 12, 122, 1112),  
('vraj', 'soni', 'vraj@gmail.com', '8737384767', '2006-05-10', '1235', 30000, 12, 120, 1110),  
('jay', 'kishor', 'jay@gmail.com', '9984108302', '2008-04-04', '1234', 45000, 15, 123, 1111),  
('matin', 'saikh', 'matin@gmail.com', '8888888888', '2010-10-10', '1234', 33000, 15, 123, 1111);


select * from Employee;

/*
1. Write a query to display the names (first_name, last_name) using alias name “First Name&quot;, &quot;Last
Name&quot;*/

select FIRST_NAME as First_Name ,LAST_NAME as Last_NAME from Employee


select FIRST_NAME, LAST_NAME , concat( FIRST_NAME, LAST_NAME) as NAMES from Employee

/*

2. Write a query to get unique department ID from employee table
*/

select Distinct (DEPARTMENT_ID) as Department from Employee  

/*
3. Write a query to get all employee details from the employee table order by first name,
descending  */

Select * from Employee ORDER BY FIRST_NAME DESC


/*
4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is
calculated as 15% of salary)  */

select FIRST_NAME , LAST_NAME , SALARY , (SALARY * 0.15 ) as PF from Employee

/* 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order
of salary  */
Select Employee_ID ,FIRST_NAME , LAST_NAME , SALARY from Employee ORDER BY SALARY 


/*6. Write a query to get the total salaries payable to employees*/

SELECT SUM(SALARY) AS TOTAL_PAYABLE_AMOUNT FROM Employee

/*
7. Write a query to get the maximum and minimum salary from employees table. */
SELECT MIN(SALARY) AS MIN_SALARY , MAX(SALARY) AS MAX_SALARY FROM Employee


/*  8. Write a query to get the average salary and number of employees in the employees table. */
SELECT AVG(SALARY)AS AVERAGE_SALARY ,COUNT(*) as NO_OF_EMPLOYEES FROM Employee

/*9. Write a query to get the number of employees working with the company. */
SELECT COUNT(EMPLOYEE_ID ) as NO_OF_EMPLOYEES FROM Employee

/*  10. Write a query to get the number of jobs available in the employees table  */
select DISTINCT (JOB_ID) from Employee