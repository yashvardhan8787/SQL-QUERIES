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
Alter Procedure spAllEmployeeDetails
as 
Begin 
select * from Employee
End 

exec spAllEmployeeDetails

/*2. Create a stored procedure that retrieves details of a specific employee by their ID.*/
Create Procedure spGetEmployeeDetail
@ID Int 
as 
Begin 
select * from Employee Where EmployeeID = @ID
End 

exec spGetEmployeeDetail 1


/*3. Create a procedure to insert a new employee into the Employees table.*/
Create Procedure spInsertEmployee
    @EmployeeID INT ,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255) ,
    @HireDate DATE ,
    @Salary DECIMAL(10,2),
    @Experience INT ,
    @Department VARCHAR(55) 
as 
Begin 
INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, Salary, Experience, Department,UpdatedAt) 
VALUES(@EmployeeID, @FirstName, @LastName, @HireDate,@Salary,@Experience, @Department,getDate());
End 

exec spInsertEmployee 6, 'yash', 'singh', '2015-06-15', 75000.50, 9, 'IT' ;

select * from Employee
/*4. Create a procedure that returns the total number of employees with respect to their
department.*/
Create Procedure spGetEmployeeInDepartment
as 
Begin 
select Department,Count(*) from Employee group by Department
End 

exec spGetEmployeeInDepartment

/*
5. Create a procedure to update the Experience of an employee by their ID.*/
Create Procedure spUpdateEmployeeExperience
@ID INT,
@Experience INT 
as 
Begin 
Update Employee set Experience=@Experience Where EmployeeID = @ID
End 

exec spUpdateEmployeeExperience 1,40

select * from Employee

/*
6. Create a trigger to log insert operations into a LogTable.*/
Alter Trigger tr_insertEmployee
on Employee 
After Insert 
As 
Begin 
	Declare @Id Int 
	Declare @Message Varchar(1000) 
	select @Id = EmployeeID from inserted
	set @Message = 'Employee with the id '+cast(@Id as Varchar(4))+' inserted in the Employee Table'

	Insert into LogTable(Message) Values(@Message) ;
End 

INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, Salary, Experience, Department,UpdatedAt) 
VALUES
(7, 'harsh', 'Johnson', '2015-06-15', 75000.50, 9, 'IT',getDate())

select * from LogTable
/*7. Create a trigger that logs whenever an employee's salary is updated.*/
Alter Trigger tr_logEmployeeSalaryUpdate
on Employee
After update 
As Begin
    if(Update(Salary))
	Begin
		Declare @Id int 
		Declare @old_salary Decimal(10,2)
		Declare @new_salary Decimal(10,2)
		Declare @Message Varchar(1000) 

		Select @old_salary=Salary,@Id=EmployeeID from deleted
		select @new_salary =Salary from inserted

		set @Message = 'Salary Update from '+Cast(@old_salary as varchar(10)) +' to'+Cast(@new_salary as varchar(10))+' for Employe'+cast(@Id as Varchar(4))

		Insert into LogTable(Message) Values(@Message) ;
    End
End 

Update Employee set Salary=70000 where EmployeeID=6

select * from LogTable
--8. Create a trigger to log when an employee record is deleted.
Create Trigger tr_LogEmployeeDelete
on Employee 
After delete 
As 
Begin 
	Declare @Id Int 
	Declare @Message Varchar(1000) 
	select @Id = EmployeeID from deleted
	set @Message = 'Employee with the id '+cast(@Id as Varchar(4))+' delete from Employee Table'

	Insert into LogTable(Message) Values(@Message) ;
End 

Delete from Employee where EmployeeID=7

select * from LogTable

--9. Create a trigger to prevent inserting a salary below 20,000.
Create Trigger tr_preventSalaryInsert 
on Employee 
After Insert 
as 
Begin 
	Declare @iSalary Decimal(
	select @iSalary = Salary from inserted
    if(Exists (select salary from Inserted ))
	Begin
		if(@iSalary < 20000
    End 
End




/*10.Create a trigger to automatically update the LastModified field with the current
timestamp when a record is updated*/

Create Trigger tr_logUpdateLastModified
on Employee
After update 
As Begin
    Declare @Id int 
	Select @Id=EmployeeID from deleted
	if(@Id is not null)
	Begin
	Update Employee set UpdatedAt=CURRENT_TIMESTAMP where EmployeeID=@ID
	End 
End 

Update Employee set FirstName='jay' where EmployeeID=3

select * from LogTable
select * from Employee