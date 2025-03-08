use LearnJoins


create table Project
(
PID int Primary key Identity(1,1),
PName varchar(55) not null ,
EID int foreign Key references Employee(Eid))

Create Table Manager(
MID int primary key Identity(1,1),
Mname varchar(55) not null ,
DID int Foreign key references Department(DID) )



insert into Project (PName , EID) values
('E-commerce',6),
('chat-bot',7),
('health-care',8),
('wallmart',6),
('social-App',9),
('E-commerce',8),
('wallmaert',10)


insert into Manager(Mname , DID) values
('yash',3),
('vansh',2),
('vraj',1),
('jay',5),
('yash',4),
('harsh',1)



select * from Employee
select * from Department
select * from Project
select * from Manager



select
Employee.EName , Department.Dname 
from Employee INNER Join Department 
on Employee.DID = Department.DID 

select
Employee.EName , Department.Dname 
from Employee left Join Department 
on Employee.DID = Department.DID 



select * from 
Employee inner join Project on Employee.Eid = Project.EID 
Right join 
Department D
inner join
Manager M on  D.DID = M.DID   on    D.DID = Employee.DID  


select Employee.EName,count(Employee.EName) as 'has projects' from Employee Inner join Project on 
Employee.Eid = Project.EID  group by Employee.EName having( count(Employee.EName)  > 1)



select * from Employee left join Project on Employee.Eid = Project.EID where Project.EID is NUll


select * from Employee left join Project on Employee.Eid = Project.EID where Project.PName ='wallmart'
 


