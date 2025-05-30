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

CREATE TABLE emplOGS (
    emp_Id INT,
    emp_Name VARCHAR(55) NOT NULL,
    email VARCHAR(55),
    salary DECIMAL(10, 2),
    hire_Date DATE DEFAULT GETDATE(),
    dept_Id INT,
    CONSTRAINT pk_emplOG PRIMARY KEY (emp_Id),
    CONSTRAINT uk_emplOG UNIQUE (email),
    CONSTRAINT fk_emplOG FOREIGN KEY (dept_Id) REFERENCES Dep(dept_Id)
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



--28. Insert sample data into both Department and Employee tables.


Insert into Dep values( 105 , 'FS'),( 102 , 'DA'),( 103 , 'DE'),( 104 , 'DS')
select * from Dep

Insert into Emp values(101, 'Yash','singhyash@gmail.com',55000.00,GETDATE(),101)
Insert into Emp values(102, 'zash','singhzash@gmail.com',65000.00,GETDATE(),102)
Insert into Emp values(103, 'aash','singhaash@gmail.com',45000.00,GETDATE(),103)
Insert into Emp values(104, 'bash','singhbash@gmail.com',35000.00,GETDATE(),104)
Insert into Emp values(105, 'cash','singhcash@gmail.com',75000.00,GETDATE(),101)
Insert into Emp values(106, 'aash','singhdash@gmail.com',45000.00,GETDATE()-100,101)
Insert into Emp values(107, 'bash','singheash@gmail.com',35000.00,GETDATE()-200,104)
Insert into Emp(emp_Id ,
    emp_Name, 
    email ,
    salary,
    hire_Date,
    dept_Id ) values(109, 'cash','singhsash@gmail.com',75000.00,GETDATE()-300,103)

select * from Emp

--29. Update salary by 10% for employees hired before 2025.

Update Emp set salary= salary + (salary  * 0.10 ) Where year(hire_Date) < 2025

--30. Delete all employees who have null emails.

Delete from Emp where email= null;

--31. Alter the Employee table to add a new column experience_years with a default value of 0.
Alter table Emp add  experience Int Default 0 ;


--32. Rename the experience_years column to years_of_experience.
EXEC sp_rename 'Emp.experience_years', 'years_of_experience', 'COLUMN';


--33. Create a BEFORE INSERT trigger to validate that salary is not below 10,000.

CREATE TRIGGER tr_validateSalary
ON Emp
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM INSERTED WHERE salary < 10000)
    BEGIN
        PRINT 'SALARY CANNOT BE LESS THAN 10000';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Emp (emp_Id, emp_Name, email, salary, hire_Date, dept_Id)
        SELECT emp_Id, emp_Name, email, salary, hire_Date, dept_Id
        FROM INSERTED;
    END
END;

--34. Create an AFTER DELETE trigger to insert deleted employee records into a backup table Employee_Logs.

CREATE TRIGGER TR_AFTERDELETE
ON Emp
AFTER DELETE 
AS 
BEGIN
  INSERT INTO emplOGS(emp_Id, emp_Name, email, salary, hire_Date, dept_Id) 
  SELECT emp_Id, emp_Name, email, salary, hire_Date, dept_Id FROM DELETED
END;

/*35. Use a transaction block to:
    - Insert a new department
    - Insert multiple employees into that department
    - Rollback if any step fails  */


CREATE TRIGGER PREVENTINSERTDEP
ON Dep
INSTEAD OF INSERT
AS 
BEGIN
  PRINT('NOT ALLOWED TO CREATE DEPEARTENET')
  ROLLBACK TRANSACTION;
END;

CREATE TRIGGER PREVENTMULTIPLEINSERTINDEPARTMENT
ON Emp
AFTER INSERT
AS 
BEGIN
    IF EXISTS (
        SELECT dept_Id
        FROM INSERTED
        GROUP BY dept_Id
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Not allowed to insert multiple entries in one department.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


