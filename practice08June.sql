Create Database practice08June

use practice08June

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    status VARCHAR(10) DEFAULT 'Active'
);


INSERT INTO Employees (emp_id, name, department, salary, hire_date)
VALUES 
(101, 'Alice', 'HR', 55000, '2021-05-01'),
(102, 'Bob', 'Engineering', 80000, '2020-03-15'),
(103, 'Charlie', 'Engineering', 75000, '2019-11-23'),
(104, 'Diana', 'Marketing', 60000, '2022-01-10'),
(105, 'Evan', 'HR', 52000, '2023-08-01');


--Write a procedure to update the salary of an employee given their emp_id and new salary.

create proc updateEmployeeSal
@emp_id int ,
@sal Decimal(10,2)
AS
Begin
 Update Employees set salary = @sal where emp_id = @emp_id;

END 


exec updateEmployeeSal 101,70000

--Write a procedure that returns all employees in a given department as input.

create proc getEmployeeInDept
@dep varchar(55)
AS
Begin
select * from employees where department = @dep;
END 

exec getEmployeeInDept 'HR'



--Write a procedure that takes a salary range and lists all employees within that range.

create proc getEmployeesInSalRange
@start Decimal(10,2),
@end Decimal(10,2)
As
Begin
    select * from employees where salary > @start and salary < @end 
End;


exec getEmployeesInSalRange 10000 ,80000

--Write a procedure to promote employees by increasing their salary by 10% if they were hired before a certain date.

create proc increaseTenPerForEmployeeByDate
@date Date 
As
Begin
Update Employees set salary = salary + (salary * 0.1) where hire_date > @date
End 

exec  increaseTenPerForEmployeeByDate '2020-03-15'

select * from Employees


--Write a procedure that deactivates (sets status = 'Inactive') all employees from a department that is passed as a parameter.

create proc deactivateEmployee
@dep varchar(50)
As 
Begin
Update Employees set status = 'Inactive' where department = @dep;
End 

--Create a trigger to automatically set status = 'Inactive' when an employee's record is deleted (soft delete – don’t actually remove the row).
Create  trigger softDeleteEmployee 
on Employees 
Instead of Delete 
As 
Begin
 Update Employees set status = 'Inactive' where emp_id in (select emp_id from deleted )
End ; 

delete from Employees where department ='HR'

select * from Employees

--Create a trigger to log any update in the salary column into a new table called SalaryChanges.

CREATE TRIGGER salaryChanges
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO SalaryChanges (emp_id, old_salary, new_salary)
    SELECT 
        i.emp_id,
        d.salary AS old_salary,
        i.salary AS new_salary
    FROM 
        inserted i
    JOIN 
        deleted d ON i.emp_id = d.emp_id
    WHERE 
        i.salary <> d.salary;
END



--Create a trigger that prevents inserting a new employee with a salary less than 30000.

Create Trigger preventEmployeeless
on Employees
Instead of insert
As 
Begin
 if(exists(select 1 from inserted where salary < 30000 ))
 Begin
  RAISERROR('Cannot insert employee with salary less than 30000.', 16, 1);
 End 
 Else
 Begin
  insert into Employees(
    emp_id ,
    name ,
    department,
    salary,
    hire_date,
    status) select   emp_id ,
    name ,
    department,
    salary,
    hire_date,
    status from inserted 
 End 
End;

--Create a trigger that updates a separate audit table whenever the department is changed.
create table AuditLog(
emp_id int ,
old_dep varchar(55),
new_dep varchar(55)
)

Create Trigger departmentChangeAudit
on Employees
after update 
As 
Begin
   Insert into AuditLog
   select i.emp_id , d.department as old_dep , i.department as new_dep from inserted i 
   join deleted d on i.emp_id = d.emp_id  
End ;

--Create a trigger to ensure no two employees in the same department can have the same salary.

CREATE TRIGGER noSameDep
ON Employees
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Employees e
            ON i.department = e.department
           AND i.salary = e.salary
    )
    BEGIN
        RAISERROR('An employee with the same salary already exists in this department.', 16, 1);
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO Employees (emp_id, name, department, salary, hire_date, status)
        SELECT emp_id, name, department, salary, hire_date, status
        FROM inserted;
    END
END;
 