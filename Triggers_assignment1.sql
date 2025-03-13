create Database Trigger_Assignment1

use Trigger_Assignment1

-- Creating the Employees table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    DepartmentID INT REFERENCES Departments(DepartmentID),
    Status VARCHAR(50),
    LastModified DATETIME
);

-- Creating the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);


-- Creating the Log table for deleted employees
CREATE TABLE EmployeeDeletionLog (
    LogID INT IDENTITY PRIMARY KEY,
    EmployeeID INT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    DeletedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Creating the Log table for deleted department IDs
CREATE TABLE DepartmentDeletionLog (
    LogID INT IDENTITY PRIMARY KEY,
    DepartmentID INT,
    DeletedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

select Name from sys.tables


Insert Into Departments 
values
(1,'QA'),
(2,'DA'),
(3,'FS'),
(4,'CC'),
(5,'DE')


Insert Into Employees(Name,Email, DepartmentID,Status,LastModified)
Values
('Yash','y@gmail.com',1,'Pending',GETDATE()),
('Vansh','Vansh@gmail.com',3,'Pending',GETDATE()),
('Vraj','Vraj@gmail.com',3,'Pending',GETDATE())

select * from sys.triggers

-- 1. Trigger for logging deleted employees
Create  Trigger tr_logDeletedEmployees
on Employees
After DELETE 
AS
Begin 
	Insert Into EmployeeDeletionLog select EmployeeID,Name,Email,CURRENT_TIMESTAMP from deleted
end 

Delete from Employees where EmployeeID = 4

select * from EmployeeDeletionLog

-- 2. Trigger for updating Employee's Last Modified Date on update
Create Trigger tr_update_Emp_Modify_Date
on Employees 
After Update
As 
Begin
   Declare @Id Int 
   Declare @OldDate Varchar(25)
   Declare @NewDate Varchar(25)
   set @NewDate = CURRENT_TIMESTAMP
   select @Id=EmployeeID ,@OldDate =Cast(LastModified As Varchar ) from deleted
   if(@Id is not null)
    Begin 
		Update Employees set LastModified=@newDate where EmployeeID=@Id
		Return 
	End
	Else
	Begin
	   RAISERROR ('Record does not exist', 16, 1);
	   return 
	End 
End 

select * from Employees

Update Employees set Name ='jay' Where EmployeeID=2 ;

select * from Employees

-- 3. Trigger to keep log of deleted department IDs

Create Trigger tr_LogDeleteDepartments 
On Departments
AFTER DELETE 
As 
Begin
   if Exists(select 1 from deleted )
   Begin
	  Insert into DepartmentDeletionLog(DepartmentID,DeletedAt) select DepartmentId ,CURRENT_TIMESTAMP from deleted 
   End 
End 

select * from Departments

Delete from Departments Where DepartmentId = 1 

select * from Departments
select * from DepartmentDeletionLog


-- 4. Trigger to prevent duplicate email addresses in Employees table
Create trigger tr_preventDuplicateEmail
On Employees
Instead of Insert 
as 
Begin
  Declare @Email varchar(255)
  select @Email = Email from inserted
  
  if Exists(Select 1 from Employees Where Email=@Email)
  Begin
    Raiserror('Email is already there in Database',1,16)
	Return 
  End
  Else
  Begin
    Insert into Employees(Name,Email, DepartmentID,Status,LastModified) select Name,Email, DepartmentID,Status,LastModified from Inserted 
  End 
End 

Insert Into Employees(Name,Email, DepartmentID,Status) Values('Vansh','vansh@gmail.com',3,'Pending')
select * from Employees

Drop trigger tr_preventDuplicateEmail

-- 5. Trigger to set default value for Status column if not provided

Alter Trigger tr_setDefaultStatus
ON Employees
Instead OF Insert 
As 
Begin 
  Declare @EmpStatus varchar(255) 
  select  @EmpStatus=status from inserted

  if(@EmpStatus is not null)
  Begin
    Insert into Employees
	(Name,Email, DepartmentID,Status,LastModified)
	select Name,Email, DepartmentID,Status,CURRENT_TIMESTAMP
	from Inserted 
  End 
  Else
  Begin 
    set @EmpStatus = 'tr_Status'
    Insert into Employees
	(Name,Email, DepartmentID,Status,LastModified)
	select Name,Email, DepartmentID,@EmpStatus,CURRENT_TIMESTAMP
	from Inserted 
  End 
End 


select * from Employees

Insert Into Employees(Name,Email, DepartmentID) Values('RRRR','R@gmail.com',3)


Insert Into Employees(Name,Email, DepartmentID,Status) Values('YYYY','YY@gmail.com',3,'Pending')

