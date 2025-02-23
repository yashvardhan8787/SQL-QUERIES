/*SQL Assessment-2
Create a table named Employees with the following columns:
1. EmployeeID: primary key.
2. FirstName:
3. LastName:
4. DepartmentID:
5. Salary: Salary should not be negative.
6. HireDate: this field should not be blank.
(Do at least 10 entry )
*/
create Database Assessment2

use  Assessment2

create table Employees(
 EmployeeId Int  primary key,
 FirstName varchar(55),
 LastName Varchar(55),
 DepartmentID int ,
 Salary Money check(Salary > 0),
 HireDate Date not null )
 




insert into Employees values
(102,' vraj','soni',204,50000, '2020-10-12'),
(104,'vansh' ,'khasia' , 206,55000, '2019-8-12'),
(105,'kapil ' ,'pal' , 208,40000, '2022-7-9'),
(106,'abhinav ' ,'Singh' , 210,52000, '2023-6-2'),
(107,'sankalp ' ,'dhuriya' , 202,30000, '2021-10-2'),
(108,'prinshu ' ,'mishra' , 204,35000, '2020-10-4'),
(109,'nilesh ' ,'mishra' , 206,25000, '2020-10-8'),
(110,'jay' ,'kishor' , 208,60000, '2021-10-7'),
(111,'matin' ,'saikh' , 210,53000, '2023-7-10'),
(112,'qusai ' ,'cuttlery' , 202,22000, '2023-7-10')

 select * from Employees









/*
Perform the below Query:
1. Write a query to find all employees whose salary is greater than the average salary
of all employees.*/

select * from Employees where Salary >(select Avg(Salary) from Employees )


/*
2. Write a query to find the total number of employees hired in each year.
*/
 select year(HireDate) as 'year' ,count(*) as 'emphired' from Employees group by HireDate


/*
3. Write a query to find the average salary of employees in each department, but only
include departments with more than 5 employees.
*/

insert into Employees values   
(17,'padmini','singh',202,62000, '2020-10-12'),
(16,' sachin','singh',202,62000, '2020-10-12'),
(14,'adil','saikh',202,52000, '2020-10-12'),
(15,'shivam' ,'singh' , 202,51000, '2019-8-12')
insert into Employees values
(117,' Rolli','singh',202,62000, '2020-10-12'),
(116,' Rahul','singh',202,62000, '2020-10-12'),
(114,' aman','saikh',202,52000, '2020-10-12'),
(115,'sagar' ,'singh' , 202,51000, '2019-8-12')

select DepartmentID , Avg(Salary) as AverageSalary from Employees group by DepartmentID having(count(*) >  5)

/*
4. Write a query to find all employees who were hired in the last 3 years and have a
salary greater than 50,000.*/

select * from Employees where HireDate between '2021-02-10' and '2025-02-10'

/*
5. Write a query to find the total salary paid to employees in each department, but only
include departments where the total salary is greater than 500,000.
*/

select DepartmentID, sum(salary) from Employees group by DepartmentID  having (sum(salary) > 500000)
 
/*
6. Write a query to find departments with more than 10 employees.
*/

select DepartmentID as department , count(*) as 'numer of Employee'  from Employees group by DepartmentID having( count(*) > 10)

/*
7. Write a query to find employees who have been with the company for more than 10
years and have a salary greater than 60,000.
*/
select * from Employees where HireDate < '2015-10-14' and salary >60000

/*
8. Write a query to find departments with an average salary greater than 70,000. */
select DepartmentID, Avg(salary) as averageSalary from Employees group by DepartmentID  having (avg(salary) > 500000)
/*
9. Write a query to find the total number of employees in each department.
*/
select DepartmentID as Department , count(*) as 'number of employees' from employees group by DepartmentID
/*
10. Write a query to find the highest salary among all employees.*/

select max(salary) as Highest_salary from Employees