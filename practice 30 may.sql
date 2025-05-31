create database practiceMay30;

use practiceMay30;


-- Drop tables if they already exist (for reruns)
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Professors;
DROP TABLE IF EXISTS Departments;

-- Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Professors
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department_id INT,
    professor_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

-- Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Departments
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mathematics'),
(4, 'Physics'),
(5, 'Business');

-- Insert Professors
INSERT INTO Professors VALUES
(1, 'John Doe', 'john@univ.edu', 1),
(2, 'Jane Smith', 'jane@univ.edu', 2),
(3, 'Alice Johnson', 'alice@univ.edu', 3),
(4, 'Robert Brown', 'robert@univ.edu', 4),
(5, 'Emily Davis', 'emily@univ.edu', 1),
(6, 'Michael Scott', 'michael@univ.edu', 5),
(7, 'Dwight Schrute', 'dwight@univ.edu', 2),
(8, 'Pam Beesly', 'pam@univ.edu', 3),
(9, 'Jim Halpert', 'jim@univ.edu', 4),
(10, 'Stanley Hudson', 'stanley@univ.edu', 5);

-- Insert Students
INSERT INTO Students VALUES
(1, 'Amit Kumar', 'amit@student.com', 1),
(2, 'Sara Ali', 'sara@student.com', 1),
(3, 'Priya Mehra', 'priya@student.com', 2),
(4, 'Rahul Sharma', 'rahul@student.com', 2),
(5, 'Neha Singh', 'neha@student.com', 3),
(6, 'Aarav Patel', 'aarav@student.com', 3),
(7, 'Kavya Nair', 'kavya@student.com', 4),
(8, 'Yash Verma', 'yash@student.com', 4),
(9, 'Divya Iyer', 'divya@student.com', 5),
(10, 'Arjun Reddy', 'arjun@student.com', 5),
(11, 'Vikram Joshi', 'vikram@student.com', 1),
(12, 'Anjali Kapoor', 'anjali@student.com', 2),
(13, 'Ritu Rana', 'ritu@student.com', 3),
(14, 'Kunal Bansal', 'kunal@student.com', 4),
(15, 'Swati Jha', 'swati@student.com', 5),
(16, 'Manoj Desai', 'manoj@student.com', 1),
(17, 'Pooja Nanda', 'pooja@student.com', 2),
(18, 'Harshit Gupta', 'harshit@student.com', 3),
(19, 'Meera Rao', 'meera@student.com', 4),
(20, 'Nikhil Roy', 'nikhil@student.com', 5);

-- Insert Courses
INSERT INTO Courses VALUES
(1, 'Data Structures', 4, 1, 1),
(2, 'Digital Logic', 3, 2, 2),
(3, 'Linear Algebra', 3, 3, 3),
(4, 'Quantum Mechanics', 4, 4, 4),
(5, 'Operating Systems', 4, 1, 5),
(6, 'Marketing 101', 2, 5, 6),
(7, 'Microprocessors', 3, 2, 7),
(8, 'Probability Theory', 3, 3, 8),
(9, 'Thermodynamics', 4, 4, 9),
(10, 'Business Law', 2, 5, 10),
(11, 'Database Systems', 4, 1, 1),
(12, 'Embedded Systems', 3, 2, 2),
(13, 'Calculus', 3, 3, 3),
(14, 'Electromagnetism', 4, 4, 4),
(15, 'Finance Basics', 2, 5, 6);

-- Insert Enrollments (40 entries - random but valid)
INSERT INTO Enrollments VALUES
(1, 1, 1, '2024-01-10', 85),
(2, 2, 1, '2024-01-11', 90),
(3, 3, 2, '2024-01-12', 78),
(4, 4, 2, '2024-01-13', 88),
(5, 5, 3, '2024-01-14', 95),
(6, 6, 3, '2024-01-15', 60),
(7, 7, 4, '2024-01-16', 70),
(8, 8, 4, '2024-01-17', 65),
(9, 9, 6, '2024-01-18', 55),
(10, 10, 6, '2024-01-19', 60),
(11, 11, 5, '2024-01-20', 89),
(12, 12, 7, '2024-01-21', 92),
(13, 13, 8, '2024-01-22', 74),
(14, 14, 9, '2024-01-23', 80),
(15, 15, 10, '2024-01-24', 85),
(16, 16, 11, '2024-01-25', 88),
(17, 17, 12, '2024-01-26', 91),
(18, 18, 13, '2024-01-27', 77),
(19, 19, 14, '2024-01-28', 84),
(20, 20, 15, '2024-01-29', 79),
(21, 1, 11, '2024-02-01', 81),
(22, 2, 5, '2024-02-02', 75),
(23, 3, 8, '2024-02-03', 68),
(24, 4, 9, '2024-02-04', 82),
(25, 5, 12, '2024-02-05', 90),
(26, 6, 13, '2024-02-06', 73),
(27, 7, 14, '2024-02-07', 67),
(28, 8, 15, '2024-02-08', 76),
(29, 9, 7, '2024-02-09', 70),
(30, 10, 10, '2024-02-10', 69),
(31, 11, 2, '2024-02-11', 88),
(32, 12, 3, '2024-02-12', 85),
(33, 13, 4, '2024-02-13', 77),
(34, 14, 5, '2024-02-14', 79),
(35, 15, 6, '2024-02-15', 83),
(36, 16, 7, '2024-02-16', 86),
(37, 17, 8, '2024-02-17', 90),
(38, 18, 9, '2024-02-18', 72),
(39, 19, 1, '2024-02-19', 74),
(40, 20, 13, '2024-02-20', 81);
-- Drop tables if they already exist (for reruns)
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Professors;
DROP TABLE IF EXISTS Departments;

-- Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Professors
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department_id INT,
    professor_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

-- Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Departments
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mathematics'),
(4, 'Physics'),
(5, 'Business');

-- Insert Professors
INSERT INTO Professors VALUES
(1, 'John Doe', 'john@univ.edu', 1),
(2, 'Jane Smith', 'jane@univ.edu', 2),
(3, 'Alice Johnson', 'alice@univ.edu', 3),
(4, 'Robert Brown', 'robert@univ.edu', 4),
(5, 'Emily Davis', 'emily@univ.edu', 1),
(6, 'Michael Scott', 'michael@univ.edu', 5),
(7, 'Dwight Schrute', 'dwight@univ.edu', 2),
(8, 'Pam Beesly', 'pam@univ.edu', 3),
(9, 'Jim Halpert', 'jim@univ.edu', 4),
(10, 'Stanley Hudson', 'stanley@univ.edu', 5);

-- Insert Students
INSERT INTO Students VALUES
(1, 'Amit Kumar', 'amit@student.com', 1),
(2, 'Sara Ali', 'sara@student.com', 1),
(3, 'Priya Mehra', 'priya@student.com', 2),
(4, 'Rahul Sharma', 'rahul@student.com', 2),
(5, 'Neha Singh', 'neha@student.com', 3),
(6, 'Aarav Patel', 'aarav@student.com', 3),
(7, 'Kavya Nair', 'kavya@student.com', 4),
(8, 'Yash Verma', 'yash@student.com', 4),
(9, 'Divya Iyer', 'divya@student.com', 5),
(10, 'Arjun Reddy', 'arjun@student.com', 5),
(11, 'Vikram Joshi', 'vikram@student.com', 1),
(12, 'Anjali Kapoor', 'anjali@student.com', 2),
(13, 'Ritu Rana', 'ritu@student.com', 3),
(14, 'Kunal Bansal', 'kunal@student.com', 4),
(15, 'Swati Jha', 'swati@student.com', 5),
(16, 'Manoj Desai', 'manoj@student.com', 1),
(17, 'Pooja Nanda', 'pooja@student.com', 2),
(18, 'Harshit Gupta', 'harshit@student.com', 3),
(19, 'Meera Rao', 'meera@student.com', 4),
(20, 'Nikhil Roy', 'nikhil@student.com', 5);

-- Insert Courses
INSERT INTO Courses VALUES
(1, 'Data Structures', 4, 1, 1),
(2, 'Digital Logic', 3, 2, 2),
(3, 'Linear Algebra', 3, 3, 3),
(4, 'Quantum Mechanics', 4, 4, 4),
(5, 'Operating Systems', 4, 1, 5),
(6, 'Marketing 101', 2, 5, 6),
(7, 'Microprocessors', 3, 2, 7),
(8, 'Probability Theory', 3, 3, 8),
(9, 'Thermodynamics', 4, 4, 9),
(10, 'Business Law', 2, 5, 10),
(11, 'Database Systems', 4, 1, 1),
(12, 'Embedded Systems', 3, 2, 2),
(13, 'Calculus', 3, 3, 3),
(14, 'Electromagnetism', 4, 4, 4),
(15, 'Finance Basics', 2, 5, 6);

-- Insert Enrollments (40 entries - random but valid)
INSERT INTO Enrollments VALUES
(1, 1, 1, '2024-01-10', 85),
(2, 2, 1, '2024-01-11', 90),
(3, 3, 2, '2024-01-12', 78),
(4, 4, 2, '2024-01-13', 88),
(5, 5, 3, '2024-01-14', 95),
(6, 6, 3, '2024-01-15', 60),
(7, 7, 4, '2024-01-16', 70),
(8, 8, 4, '2024-01-17', 65),
(9, 9, 6, '2024-01-18', 55),
(10, 10, 6, '2024-01-19', 60),
(11, 11, 5, '2024-01-20', 89),
(12, 12, 7, '2024-01-21', 92),
(13, 13, 8, '2024-01-22', 74),
(14, 14, 9, '2024-01-23', 80),
(15, 15, 10, '2024-01-24', 85),
(16, 16, 11, '2024-01-25', 88),
(17, 17, 12, '2024-01-26', 91),
(18, 18, 13, '2024-01-27', 77),
(19, 19, 14, '2024-01-28', 84),
(20, 20, 15, '2024-01-29', 79),
(21, 1, 11, '2024-02-01', 81),
(22, 2, 5, '2024-02-02', 75),
(23, 3, 8, '2024-02-03', 68),
(24, 4, 9, '2024-02-04', 82),
(25, 5, 12, '2024-02-05', 90),
(26, 6, 13, '2024-02-06', 73),
(27, 7, 14, '2024-02-07', 67),
(28, 8, 15, '2024-02-08', 76),
(29, 9, 7, '2024-02-09', 70),
(30, 10, 10, '2024-02-10', 69),
(31, 11, 2, '2024-02-11', 88),
(32, 12, 3, '2024-02-12', 85),
(33, 13, 4, '2024-02-13', 77),
(34, 14, 5, '2024-02-14', 79),
(35, 15, 6, '2024-02-15', 83),
(36, 16, 7, '2024-02-16', 86),
(37, 17, 8, '2024-02-17', 90),
(38, 18, 9, '2024-02-18', 72),
(39, 19, 1, '2024-02-19', 74),
(40, 20, 13, '2024-02-20', 81);


select name from sys.tables

----Querries ------------------------
--1.	List the names and emails of all students enrolled in a course taught by ‘Prof. John Doe’.

select Distinct e.student_id, s.name , s.email  from Professors p 
join Courses c on p.professor_id = c.professor_id 
join Enrollments e on e.course_id = c.course_id 
join Students s on  s.student_id = e.student_id  where p.name='John Doe' 

--2.	Get the names of courses along with their corresponding department names and professor names.

select course_name , department_name , p.name  as professor_name from courses c 
join Departments d on c.department_id = d.department_id
join Professors p  on p.professor_id = c.professor_id 


--3.List all students along with the number of courses they are enrolled in.
select s.student_id ,s.name , e.course_count from Students s left join
(select count(*) as course_count, student_id  from Enrollments  group by student_id ) as e 
on s.student_id = e.student_id


--4.	Show the courses that do not have any students enrolled.
select c.course_id , c.course_name ,enrollment_id from courses c left join
Enrollments e on  c.course_id=e.course_id where enrollment_id is null

--5.Display the names of students enrolled in at least two courses.

select s.student_id ,s.name , e.course_count from Students s join
(select count(*) as course_count, student_id  from Enrollments  group by student_id ) as e 
on s.student_id = e.student_id where e.course_count >= 2

--6.	Find departments that have no professors assigned.

select d.department_id , d.department_name from  Departments d left join Professors p
on d.department_id = p.department_id  where p.professor_id is null


--7.Get the professor name and number of courses they are teaching.

select p.professor_id , name , c.course_count  from Professors p 
left join 
(select count(*)  as course_count, professor_id  from courses group by professor_id) as c 
on p.professor_id = c.professor_id


--8.	Show student name, course name, and grade for all students who got a grade above 90.
    select s.name , c.course_name , e.grade  from Students  s 
    join Enrollments e on s.student_id = e.student_id 
	join Courses c on c.course_id  = e.course_id Where e.grade > 90



--9.	List the students along with their departments who have enrolled in any course taught by a professor in the 'Electronics' department.

select S.name as [Studnet Name], d.department_name as [Stu dep] ,p.name as [professor name] ,pd.department_name as [Proff. dep] ,c.course_name from Students S  join 
Departments d on S.department_id = d.department_id
join Enrollments e on e.student_id  = s.student_id 
join Courses  c on e.course_id = c.course_id 
join Professors p on p.professor_id = c.professor_id 
join Departments pd on p.department_id = pd.department_id 
Where pd.department_name = 'Electronics'



--10.	Find the names of students who have enrolled in all courses taught by a specific professor.

-- Get students who are enrolled in ALL courses taught by 'John Doe'
SELECT s.name
FROM Students s
WHERE NOT EXISTS (
    SELECT c.course_id 
    FROM Courses c 
    JOIN Professors p ON p.professor_id = c.professor_id 
    WHERE p.name = 'John Doe'
    EXCEPT
    SELECT e.course_id 
    FROM Enrollments e 
    WHERE e.student_id = s.student_id
);


---?? Subqueries
--11.	List students who have enrolled in the course that has the highest number of credits.


select Student_id , Name  from Students where student_id in 
	(select Distinct student_id from Enrollments where course_id in 
		(select course_id from Courses where credits=
			(select max(credits) from Courses )
		)
	)

--12.	Find courses which have more students enrolled than the course with the minimum enrollment.


select * from Courses where course_id not in (
select  course_id  from (select course_id ,count(*) as en_count from Enrollments group by course_id) as e1 where e1.en_count  = (
select min(en_count) from (select course_id ,count(*) as en_count from Enrollments group by course_id) as e)
);

--13.	Display the names of professors who don’t teach any course (using subquery).


select name from Professors where professor_id not in (
	select Distinct professor_id from Courses 
)

--14. Get the names of students whose grade in any course is below the average grade of that course.


select Distinct s.student_id ,name from Students  s join 
Enrollments  e on e.student_id = s.student_id 
join
(select course_id , avg(grade) as avgGrade from Enrollments group by course_id) as t1 on
e.course_id = t1.course_id 
Where e.grade < t1.avgGrade 



--15.	Find the top 3 students with the highest average grade across all their courses.
SELECT TOP 3 s.student_id, s.name, AVG(e.grade) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name
ORDER BY avg_grade DESC;


--16.	Find the department with the highest number of enrolled students (indirect via students table).

select * from Departments where department_id in (
select department_id  from (select department_id , count(*) stcount from Students group by department_id ) as d1
where stcount = (select max(stcount) from (select department_id , count(*) stcount from Students group by department_id ) as d2 )
);

--17.	Get students who are in the same department as the student with ID = 5.

select * from Students where department_id = (select department_id from Students where student_id = 5);

--18.	Display courses where no student scored above 60.

select * from Courses where course_id not in (
   select course_id from Enrollments where grade  > 60
)


--19.	Create a view that lists student name, course name, department, and grade.

create view studentDetailView as (
select name ,course_name, department_name , grade from Students  s
Join Enrollments e on s.student_id = e.student_id
join Courses c on e.course_id = c.course_id
join Departments d on d.department_id = s.department_id
)

select * from studentDetailView



--20.	Create a view that shows the average grade for each course.


Create View avgCourseGradeView
as
select a.course_id ,course_name , a.gradeAvg from courses c join (
select course_id , avg(grade) as gradeAvg from Enrollments group by course_id ) as a
on a.course_id = c.course_id


select * from avgCourseGradeView


--21.	Create a view for each professor listing the courses they teach and number of enrolled students.
create view professorDetail
as 
Select name , course_name , enrolledStudents  from Professors p 
join Courses c on c.professor_id = p.professor_id
join ( select course_id , count(*) as enrolledStudents from Enrollments group by course_id ) as e
on e.course_id = c.course_id

select * from professorDetail


--22.	Create a view that lists departments and the number of professors and students in each.

Create view deptDetailView as 
select department_name , No_of_proff , No_of_Stu from Departments d 
join (select department_id , count(*) as No_of_proff from Professors group by department_id) as p
on p.department_id = d.department_id
join (select department_id , count(*) as No_of_Stu from Students group by department_id) as s
on s.department_id = d.department_id


select * from deptDetailView


--23.	Create a view showing students who have enrolled in at least one course and their average grade.

create view studentAvg as
select name , average  from Students s join 
(select student_id , Avg(grade) as average from Enrollments group by student_id ) as a
on s.student_id = a.student_id


select * from studentAvg 


--24.	Create a view that lists all courses with total credits offered by each department.
Create View courseView
as 
select course_name , d.department_name ,c.credits from Courses c 
join Departments d  on c.department_id  = d.department_id 

select * from courseView

--25.	Create a procedure to get all courses and grades for a given student name.

create proc getCourseAndGrade 
@st_name varchar(55)
As 
Begin

  if(Exists(select 1 from Students where name= @st_name ))
  Begin
	  Declare @id int 
	  select @id = student_id from Students  where name = @st_name;

	  select course_name , grade from Courses  c 
	  join Enrollments e  on 
	  e.course_id = c.course_id where e.student_id= @id;
  End
  Else
  Begin
    print('Student not exists');
  End
End; 



--26.	Write a procedure that returns a list of students who failed (grade < 40) any course.

create proc getFailedStudent
as 
Begin
 
 select Distinct name from Students s
 join Enrollments e on s.student_id = e.student_id
 where e.grade < 40;


end 

--27.	Create a stored procedure that inserts a new course and assigns it to a professor.

create proc createNewCourse
    @course_id INT,
    @course_name VARCHAR(100),
    @credits INT,
    @department_id INT,
    @professor_id INT
As
Begin
  insert into Courses( course_id,course_name ,credits , department_id,professor_id) values( @course_id,@course_name ,@credits , @department_id,@professor_id);
End






--28.	Create a procedure that updates a student's grade for a given course.
create proc updateGrade 
@s_id int ,
@c_id int ,
@new_grade int 
As 
Begin
  Update Enrollments set grade =@new_grade where student_id = @s_id and course_id =@c_id ;

End 

--29.	Write a procedure to list students who haven’t enrolled in any course for more than 3 months.
create proc getUnenrolledStudent
As 
Begin
select name from Students where student_id not in (
select student_id from Enrollments
)
end ; 

--30.	Write a procedure to transfer a professor to a different department and update all relevant course associations.

create proc updateProffDept
@proff_id int ,
@newDept_id int 
as 
Begin

Update Professors set department_id = @newDept_id where professor_id = @proff_id ;
Update Courses set department_id = @newDept_id where professor_id =@proff_id ;

End


--31.	Create an index to optimize lookups on course name.

create index idxcoursename on Courses(course_name) 


--32.	Add an index on enrollment_date for faster time-based queries.

create index idexenrollmentdate on Enrollments(enrollment_date)

--33.	Create a composite index on (department_id, course_id) in the Courses table to optimize department-wise course reports.

create index idxcompositecourse on Courses(department_id, course_id)

