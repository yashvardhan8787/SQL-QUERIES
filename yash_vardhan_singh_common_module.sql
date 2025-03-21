--creating new database 

Create DataBase Yash_Vardhan_Singh_Common_Module
-- using database 
use Yash_Vardhan_Singh_Common_Module

/*Create below tables with proper constraints and perform the queries.
Insert at least 5 records for each table
1. Students Table
StudentID,
FirstName,
LastName,
Age ,
SpecializationID*/

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(55),
LastName VARCHAR(55),
Age INT ,
SpecializationID INT FOREIGN KEY REFERENCES Specialization(Specializations_ID)
)

INSERT INTO Students 
values
(1,'yash','singh',21,1),
(2,'harsh','sharma',19,2),
(3,'rolli','singh',23,3),
(4,'vansh','khasia',20,4),
(5,'vraj','soni',21,5)

/*
2. Specialization Table
Specializations ID,
SpecializationName*/

CREATE TABLE Specialization 
(
Specializations_ID INT PRIMARY KEY,
SpecializationName VARCHAR(100))

insert into Specialization 
values
(1,'QA'),
(2,'DA'),
(3,'DE'),
(4,'FS'),
(5,'Cloud')

/*3. Courses Table
CourseID,
CourseName,
Credits*/

CREATE TABLE Courses (
CourseID INT PRIMARY KEY ,
CourseName VARCHAR(100),
Credits INT 
)

insert into Courses
values
(1,'Core Java' ,3),
(2,'SQL' ,2),
(3,'Cloud Computing' ,1),
(4,'GEN AI' ,2),
(5,'SOftware Testing' ,3)



/*
4. Enrollments Table
EnrollmentID,
StudentID,
CourseID,
Grade,
*/
CREATE TABLE  Enrollments (
EnrollmentID INT PRIMARY KEY ,
StudentID INT FOREIGN KEY REFERENCES  Students(StudentID) ,
CourseID INT FOREIGN KEY REFERENCES  Courses(CourseID),
Grade CHAR
)

insert into Enrollments
values 
(1,1,1,'A'),
(2,2,3,'B'),
(3,3,5,'B'),
(4,4,2,'A'),
(5,5,4,'C')


insert into Enrollments
values 
(6,1,4,'A'),
(7,1,2,'B'),
(8,1,3,'B'),
(9,1,4,'B')

Update Enrollments set CourseID= 5 where EnrollmentID=9

select * from Enrollments
/*
1. Retrieve the names of students and their corresponding Specialization names.*/

select (s.FirstName+' ' + s.LastName) as [Students Name],sp.SpecializationName as [Specialization Name]
from Students s
INNER join 
Specialization sp on sp.Specializations_ID = s.SpecializationID



/*
2. Find the names of students who have enrolled in all courses offered by the
university.*/
select s.StudentID ,s.FirstName,s.LastName  from Students s Join Enrollments E
on s.StudentID = E.StudentID
Group by s.StudentID ,s.FirstName,s.LastName having(count(Distinct E.CourseID)=(select count(*) from Courses))


/*
3. Retrieve the list of students along with the courses they are enrolled in and
their grades.*/

select s.StudentID,s.FirstName,s.LastName,c.CourseName,c.Credits ,E.Grade
from Students s
INNER join 
Enrollments e on s.StudentID = e.StudentID Join Courses c on e.CourseID = c.CourseID

/*

4. Find the names of students who have never received a grade lower than ‘B’ in
any course.*/

select s.FirstName ,s.LastName from Students s
join Enrollments e on 
s.StudentID = e.StudentID group by  s.FirstName ,s.LastName
Having MIN(e.Grade) <= 'B'

select * from Students s
join Enrollments e on 
s.StudentID = e.StudentID 
Where Not EXISTS(
select 1 from Enrollments E2 Where E2.StudentID=s.StudentID and E2.Grade > 'B')

/*
5. Retrieve the list of Specialization along with the number of students enrolled in
each Specialization.*/

select s.SpecializationName , count(*) as [Number of students ]
from Specialization s Join Students st on s.Specializations_ID = st.SpecializationID
group by s.SpecializationName

/*
6. Find the names of students who have received an 'A' grade in any course.*/

select s.FirstName,s.LastName,e.Grade from Students s 
inner join  Enrollments e on s.StudentID = e.StudentID
where e.Grade = 'A'
Group by s.FirstName,s.LastName,e.Grade

/*
7. Retrieve the list of courses along with the total number of credits for students
enrolled in each course.*/
select * from Courses c Join Enrollments e
on c.CourseID = e.CourseID

/*
8. Find the names of students who are enrolled in both CourseID = 2 and CourseID = 3.*/
select (s.FirstName +'  '+s.LastName) as [Students Name] from Students s
inner join Enrollments e on 
e.StudentID = s.StudentID where e.CourseID = 2 and 
Exists( select 1 from Enrollments where  StudentID=s.StudentID and CourseID=3)

/*
9. Retrieve the names of students along with their Specialization names and the
courses they are enrolled in.*/
select s.FirstName,s.LastName,sp.SpecializationName,c.CourseName from Students s
join Specialization  sp
on s.SpecializationID = sp.Specializations_ID
join Enrollments e on e.StudentID = s.StudentID
join Courses c on c.CourseID = e.CourseID
/*
10.Retrieve the list of students along with their specialization names and the total
number of credits they have enrolled.*/
select s.FirstName,s.LastName,sp.SpecializationName,SUM(c.Credits) as [Total Credits] from Students s
join Specialization  sp
on s.SpecializationID = sp.Specializations_ID
join Enrollments e on e.StudentID = s.StudentID
join Courses c on c.CourseID = e.CourseID
Group by  s.FirstName,s.LastName,sp.SpecializationName 
