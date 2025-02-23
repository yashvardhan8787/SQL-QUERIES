create Database LearnJoins

use  LearnJoins



create table Student(
 student_id int primary key ,
 student_Name varchar(50) ,
 enrollment_id int  not null,
 course_id int  ,
 constraint fk_cid foreign key( course_id ) References Course(course_id)
)


create table Course(
course_id int primary key,
course_name varchar(55),
course_fees money 
)


insert into Course values
(101,'full satck ' , 30000),
(102,'QA' , 25000),
(103,'DA ' , 20000),
(104,'DE ' , 10000),
(105,'Cloud' , 20000)

insert into Student values
(1 ,'yash',290,101),
(2 ,'harsh',291,102),
(3 ,'vansh',292,103),
(4 ,'vraj',293,104),
(5 ,'jay',294,105),
(6 ,'kuldip',295,104),
(7 ,'matin',296,103),
(8 ,'quasi',297,102),
(9 ,'kartik',298,101)



SELECT * FROM Student;
SELECT * FROM Course;




SELECT * FROM Student s 
INNER JOIN Course c ON s.course_id = c.course_id;


SELECT * FROM Student s 
RIGHT JOIN Course c ON s.course_id = c.course_id;



SELECT * FROM Student s 
FULL OUTER JOIN Course c ON s.course_id = c.course_id;


select * from SYS.tables


Select ISNULL(S.student_Name ,'Name Correction') As StudentName from Student S full outer join  Course  C  on S.course_id = C.course_fees 


select * from sys.tables



--Q1. LIST ALL EMPLOYEES AND THEIR DEPRTMENT NAMES.
/* ANS */

SELECT * FROM Employee E
FULL JOIN Department D
ON E.DID = D.DID


--Q2. LIST ALL EMPLOYEES AND THEIR DEPARTMENT NAMES,INCLUDING EMPLOYEES WHO ARE NOT ASSIGNED TO ANY DEPARTMENT.
/* ANS */

SELECT * FROM Employee E
LEFT JOIN Department D
ON E.DID = D.DID;

--Q3. LIST ALL DEPARTMENT AND THE NUMBER OF EMPLOYEES IN EACH DEPARTMENT.
/* ANS */

SELECT * FROM Employee E
RIGHT JOIN Department D
ON E.DID = D.DID

--Q4. FIND THE EMPLOYEE WITH THE HIGHEST SALARY.
/* ANS */

SELECT * FROM Employee E
LEFT JOIN Department D
ON E.DID = D.DID
WHERE E.Salary= (SELECT MAX(Salary) FROM Employee );


Select D.Dname As [Department Name] ,    count(*) AS [Total Employee]
from Employee E
Inner Join Department D 
on E.DID = D.DID
where DOJ Between '2024-01-01' And '2025-01-01' 
group by Dname 
Having count(*) >= 6 
Order by Dname