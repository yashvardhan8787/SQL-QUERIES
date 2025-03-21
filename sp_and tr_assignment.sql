Create Database StoreProcedureAndTrigger

use StoreProcedureAndTrigger


CREATE TABLE Employee (
    EmployeeID INT ,
    FirstName VARCHAR(255),
    LastName VARCHAR(255) ,
    HireDate DATE ,
    Salary DECIMAL(10,2),
    Experience INT ,
    Department VARCHAR(55) ,
	UpdatedAt DateTime
);


Create Table LogTable ( Id INT Primary KEy Identity,  Message Varchar(1000));

INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, Salary, Experience, Department,UpdatedAt) 
VALUES
(1, 'Alice', 'Johnson', '2015-06-15', 75000.50, 9, 'IT',getDate()),
(2, 'Bob', 'Smith', '2018-09-23', 62000.00, 6, 'HR',getDate()),
(3, 'Charlie', 'Brown', '2020-01-10', 58000.75, 4, 'Finance',getDate()),
(4, 'David', 'Williams', '2016-07-12', 90000.00, 10, 'Engineering',getDate()),
(5, 'Eve', 'Davis', '2019-11-05', 67000.25, 5, 'Marketing',getDate());


/*1. Create a Stored Procedure to Retrieve details of All Employees*/
Create Proc spGetAllEmployee
as 
Begin
	select * from Employee;
End 

spGetAllEmployee
/*2. Create a stored procedure that retrieves details of a specific employee by their ID.*/
Create Proc spGetEmployeeById
@Eid INT 
As
Begin
	select * from Employee Where EmployeeID=@Eid;
End 

spGetEmployeeById 1 ;

/*3. Create a procedure to insert a new employee into the Employees table.*/

Create Proc spInsertEmployee
@EmployeeID INT ,
@FirstName VARCHAR(255),
@LastName VARCHAR(255),
@HireDate DateTime,
@Salary DECIMAL(10,2),
@Experience INT, 
@Department VARCHAR(55)
As
Begin
	INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, Salary, Experience, Department,UpdatedAt) 
    VALUES(@EmployeeID,@FirstName,@LastName,@HireDate,@Salary,@Experience,@Department,GETDATE())
End 

spInsertEmployee 4, 'David', 'Williams', '2016-07-12', 90000.00, 10, 'Engineering'

/*4. Create a procedure that returns the total number of employees with respect to their
department.*/
Create Proc spGetTotalEmployeesAndDepartment
As
Begin
	select  Department , count(Department) from Employee Group by Department 
End 

spGetTotalEmployeesAndDepartment

/*
5. Create a procedure to update the Experience of an employee by their ID.*/
Create Proc spUpDateExperienceById
@Id int ,
@Exp Int 
As 
Begin
	if(Exists(select 1 from Employee Where EmployeeID= @Id))
	Begin
	  Update Employee Set Experience = @Exp Where EmployeeID=@Id;
	End 
	Else
	Begin
	 Raiserror('Employee with the Id %d does not Exists',16,1,@Id);
	End
End 

spUpDateExperienceById 1,8

spUpDateExperienceById 8,1

/*
6. Create a trigger to log insert operations into a LogTable.*/
Alter Trigger Tr_InesertLog
on Employee
for Insert
As 
Begin
   Insert Into LogTable(Message)
   select 'New Employee With Id'+Cast(EmployeeID as Varchar(4))+' on Date '+cast(GetDate() as varchar(40))as Masg
   from Inserted
End

select * from Logtable

/*7. Create a trigger that logs whenever an employee's salary is updated.*/
Create Trigger tr_SalaryUpDateemployee
on Employee
for Update
As 
Begin

  if(Update(Salary))
  Begin
    Insert into LogTable(Message)
	select 'Employee with id' + cast(D.EmployeeId as varchar(4)) +'old Salary'+Cast(D.Salary as varchar(10))+' to '+Cast(I.Salary as varchar(10)) as msg
	from Inserted I join Deleted  D on  I.EmployeeID = D.EmployeeID 
	WHERE D.Salary <> I.Salary;
  End
End 

--8. Create a trigger to log when an employee record is deleted.
Create Trigger tr_logDeletedRecord
on Employee
for Delete
As 
Begin
    Insert into LogTable(Message)
	select 'Employee With Id '+cast(EmployeeID as Varchar(4))+' Deleted from Employee Table' from Deleted
End 

--9. Create a trigger to prevent inserting a salary below 20,000.
CREATE TRIGGER tr_preventSalary
ON Employee
FOR INSERT
AS 
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Salary < 20000)
    BEGIN
        RAISERROR('Cannot insert salary less than 20000', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

/*10.Create a trigger to automatically update the LastModified field with the current
timestamp when a record is updated*/

Create trigger tr_UpdateModifiyDate
on Employee 
for Update 
as 
Begin
	if(Exists(select 1 from Inserted))
	Begin
	   Update Employee set UpdatedAt = GetDate() where EmployeeID in (select EmployeeID from Inserted) ;
	End 
End 

-- count of Employees by Store procedure with Return 
Create proc spGetCountEmployees
As 
Begin
  Return(select Count(*) from Employee);
End 

Declare @TotalEmployee Int 
Exec @TotalEmployee= spGetCountEmployees ;
print(@TotalEmployee);


select * from Employee


-- count of Employees by Store procedure with outPut parameter 
Create Proc spGetOutputEmployeeCount
@Count INT  Output
As 
BEgin
	select @Count= Count(*) from Employee
End 


Declare @Res Int 
Exec spGetOutputEmployeeCount @Res out 
select @Res


Declare @Idresult  int;
select @Idresult = EmployeeID from Employee
select @Idresult

select * from Employee

Create proc spGetGetGreatestExperience
As 
Begin
	return select Max(experience) from Employee
End 


