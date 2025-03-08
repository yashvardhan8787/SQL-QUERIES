create database Learn_Triggers 


CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (1,'John', 5000, 'Male', 3)
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1)


select * from tblEmployee

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)

create TRIGGER tr_tblEmployee_ForInsert
ON tblEmployee
FOR INSERT 
AS
BEGIN 
Declare @Id int 
Select @Id=Id from inserted

insert into tblEmployeeAudit values
('New employee with Id ='+cast(@Id as nvarchar(5))+'is added at'+cast(Getdate() as nvarchar(20)))
END

Insert into tblEmployee values (7,'Tan', 2300, 'Female', 3)

select * from tblEmployeeAudit
--to disable 
Disable Trigger tr_tblEmployee_ForInsert on tblEmployee 
--to enable 
enable Trigger tr_tblEmployee_ForInsert on tblEmployee 
--Drop trigger 
Drop Trigger tr_tblEmployee_ForInsert
--check is dropped 
Insert into tblEmployee values (8,'yash', 2300, 'male', 6)

select * from tblEmployee
select * from tblEmployeeAudit


--Now trigger for Delete 

create TRIGGER tr_tblEmployee_ForDelete 
ON tblEmployee
FOR Delete
AS
BEGIN 
Declare @Id int 
Select @Id=Id from Deleted

insert into tblEmployeeAudit values
('exixting employee deleted  with Id ='+cast(@Id as nvarchar(5))+' at'+cast(Getdate() as nvarchar(20)))
END

--Deleted value 
Delete from tblEmployee where id= 1

--check audit table 
select * from tblEmployeeAudit

-- to prevent negative department id 
create TRIGGER tr_PreventNegativeDepartment  
ON tblEmployee
After UPDATE
AS
BEGIN 
   If Exists (Select 1 from inserted where DepartmentId < 1)
   Begin
      RAISERROR('Department iid cannot be nagative .',16,1);
	  ROLLBACK TRANSACTION ;
   End 
END



Insert into tblEmployee values (1,'John', 5000, 'Male', -1)

-- to update 
Create Trigger tr_tblEmployee_ForUpdate
on tblEmployee 
for UPDATE 
as 
BEGIN
select * from deleted
select * from inserted 
END 

Update tblEmployee set DepartmentId = 10 where DepartmentId=2


select * from tblEmployee

-- this trigger prevents to craete a database 
create TRIGGER tr_PreventCreateTable
on DATABASE 
for CREATE_TABLE 
AS 
BEGIN
	RollBack;
	print('you are not allowed to create Database ');
END 


CReate Table CheckTable(
name varchar(55));