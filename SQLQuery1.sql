Create Database practice27may;

Use  practice27may;


/*1. Create a table named Department with the following fields:
   - dept_id (INT, Primary Key)
   - dept_name (VARCHAR, Not Null, Unique)
*/

Create Table Dep(
dept_Id INT ,
dept_Name varchar(55),
Constraint pk_deptTable primary key  (dept_Id)  );

/*2. Create a table named Employee with the following fields:
   - emp_id (INT, Primary Key)
   - emp_name (VARCHAR, Not Null)
   - email (VARCHAR, Unique)
   - salary (DECIMAL)
   - hire_date (DATE, default current date)
   - dept_id (INT, Foreign Key referencing Department)
*/
CREATE TABLE Emp (
    emp_Id INT,
    emp_Name VARCHAR(55) NOT NULL,
    email VARCHAR(55),
    salary DECIMAL(10, 2),
    hire_Date DATE DEFAULT GETDATE(),
    dept_Id INT,
    CONSTRAINT pk_emp PRIMARY KEY (emp_Id),
    CONSTRAINT uk_emp UNIQUE (email),
    CONSTRAINT fk_emp FOREIGN KEY (dept_Id) REFERENCES Dep(dept_Id)
);

--3. Add a CHECK constraint to ensure that salary is greater than 5000.
Alter Table Emp
Add Constraint ck_emp Check (salary > 5000);

--4. Add an INDEX on the emp_name column in the Employee table.
CREATE INDEX idx_empname ON Emp(emp_Name);

--5. Write a SQL query to retrieve all employee records with aliases for columns (e.g., “Name” for emp_name).
Select emp_Id , emp_Name as Name , email from Emp ;


--6. Write a query using DISTINCT to list unique department IDs from the Employee table.
Select DISTINCT dept_Id from Emp ;

--7. Use CAST() or CONVERT() to convert salary to integer in the result set.
Select cast(salary as INT) as SALARY from Emp ;

select convert(Int , salary ) as Salary from Emp;

--8. Use CONCAT() to merge employee name and email as "Contact Info".

select CONCAT(emp_Name ,email) as contact from Emp

--9. Write a query that uses COALESCE() to handle null values in the email field.


/*10. Use a CASE expression to categorize employees as:
    - 'High' if salary > 70000
    - 'Medium' if between 40000–70000
    - 'Low' otherwise*/

SELECT 
    emp_Id,
    salary,
    CASE 
        WHEN salary > 70000 THEN 'High'
        WHEN salary BETWEEN 40000 AND 70000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Emp;


/*11. Use an INNER JOIN to get employee names with their department names.*/
Select emp_Name , dept_Name  from Emp e inner join Dep d on e.dept_Id=d.dept_Id

--12. Use a LEFT JOIN to list all employees including those without departments.
Select emp_Name , dept_Name  from Emp e left join Dep d on e.dept_Id=d.dept_Id

--13. Write a subquery to fetch employees who earn more than the average salary.
select emp_Id,salary from Emp where salary > ( select Avg(salary) from Emp);

--14. Write a correlated subquery to find employees whose salary is above the average of their own department.
select emp_Id ,salary from Emp e where  salary > ( select Avg(salary) from Emp where dept_Id = e.dept_Id)

--15. Use GROUP BY to get the total number of employees per department.

select count(*) as Employees , dept_Id from Emp  group by dept_Id Order by Employees;

--16. Use HAVING to filter groups where the number of employees > 2

select dept_Id from Emp group by dept_Id Having count(*) > 2 ;

--17. Sort employees by hire_date in ascending order and salary in descending order.
select * from Emp Order by hire_Date asc ,salary Desc

/*18. Use LIMIT and OFFSET to retrieve the second page of 3 records per page.
19. Use UNION to combine the names from Employee and another table Interns.
20. Use EXISTS to check if any employees exist in a department before deleting it.*/

--21. Create a view named EmployeeDetails that displays employee name, salary, and department name.

create View empView as (select * from Emp)

select * from empView


--22. Query the EmployeeDetails view to find employees in the 'HR' department.
select * from empView where dept_Id = ( select dept_Id from Dep where dept_Name='HR');


--23. Create a stored procedure that takes a department ID and returns employee count and average salary.

create proc getDeptInfo
@Id int ,
@employeeCount Int output,
@avgSalary decimal(10,2) output
As 
Begin 
   select @employeeCount = count(*) from Emp where dept_Id = @Id ;
   select @avgSalary = Avg(salary) from Emp where dept_Id =@Id;
end;


--24. Create a stored function to calculate annual salary (salary × 12) and return it.

create proc anualSalary 
@salary Decimal(10,2) ,
@annual Decimal(10,2) output
As
Begin
  
  select @annual= @salary * 12 ;

End;

--25. Call the stored procedure and stored function you created.
Declare @employeeCount Int, @avgSalary decimal(10,2) 
exec getDeptInfo 101,@employeeCount output ,@avgSalary output
select @employeeCount ,@avgSalary 


--26. Create a stored procedure that inserts a new employee and logs the action into an audit table.

create proc insertNewEmp
    @emp_Id INT,
    @emp_Name VARCHAR(55) ,
    @email VARCHAR(55),
    @salary DECIMAL(10, 2),
    @dept_Id INT
As
Begin
   insert into emp values (
    @emp_Id,
    @emp_Name,
    @email ,
    @salary ,
    GETDATE(),
    @dept_Id
   );

End;






--27. Modify the stored procedure to include error handling using DECLARE … HANDLER.