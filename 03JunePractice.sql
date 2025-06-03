CREATE DATABASE practiceJune3;
GO

USE practiceJune3;
GO

-- 2. Departments
CREATE TABLE Departments (
    department_id INT IDENTITY,
    department_name VARCHAR(100),
    hod_name VARCHAR(100),
    CONSTRAINT pk_department PRIMARY KEY (department_id)
);

-- 1. Students
CREATE TABLE Students (
    student_id INT IDENTITY,
    name VARCHAR(100),
    age INT,
    department_id INT,
    admission_date DATE,
    CONSTRAINT pk_students PRIMARY KEY (student_id),
    CONSTRAINT ck_age CHECK (age > 5),
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 3. Courses
CREATE TABLE Courses (
    course_id INT IDENTITY,
    course_name VARCHAR(100),
    department_id INT,
    credits INT,
    CONSTRAINT pk_courses PRIMARY KEY (course_id),
    CONSTRAINT ck_credits CHECK (credits > 0),
    CONSTRAINT fk_depCourses FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 4. Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT GETDATE(),
    grade INT,
    CONSTRAINT pk_enrollement PRIMARY KEY (enrollment_id),
    CONSTRAINT fk_enrolledStudent FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_enrolledCourse FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    CONSTRAINT ck_grades CHECK (grade >= 0 AND grade <= 100)
);

-- 5. Fees
CREATE TABLE Fees (
    fee_id INT IDENTITY,
    student_id INT,
    total_fee DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    due_date DATE,
    CONSTRAINT pk_fees PRIMARY KEY (fee_id),
    CONSTRAINT ck_totalfees CHECK (total_fee >= 0),
    CONSTRAINT ck_paidAmount CHECK (paid_amount >= 0)
);

-- 6. Results
CREATE TABLE Results (
    result_id INT IDENTITY,
    student_id INT,
    course_id INT,
    marks INT,
    exam_date DATE,
    CONSTRAINT pk_result PRIMARY KEY (result_id),
    CONSTRAINT fk_stu_id FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_corse_id FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    CONSTRAINT ck_marks CHECK (marks >= 0 AND marks <= 100)
);

-- 7. Login
CREATE TABLE Login (
    user_id INT IDENTITY,
    username VARCHAR(100),
    password VARCHAR(100),
    last_login DATETIME DEFAULT GETDATE(),
    is_active BIT,
    CONSTRAINT pk_login PRIMARY KEY (user_id)
);

-- 8. Audit_Log
CREATE TABLE Audit_Log (
    log_id INT IDENTITY,
    operation_type VARCHAR(1000),
    table_name VARCHAR(100),
    operation_time DATETIME,
    user_id INT,
    CONSTRAINT fk_userid FOREIGN KEY (user_id) REFERENCES Login(user_id),
    CONSTRAINT pk_log PRIMARY KEY (log_id)
);


INSERT INTO Departments (department_name, hod_name) VALUES
('Computer Science', 'Dr. A Sharma'),
('Mechanical Engineering', 'Dr. B Mehta'),
('Electrical Engineering', 'Dr. C Verma'),
('Mathematics', 'Dr. D Kapoor');

INSERT INTO Students (name, age, department_id, admission_date) VALUES
('Alice', 19, 1, '2022-08-01'),
('Bob', 20, 2, '2022-08-15'),
('Charlie', 22, 1, '2021-07-10'),
('Daisy', 18, 3, '2023-01-05'),
('Eva', 21, 4, '2021-09-23'),
('Fay', 17, 2, '2023-05-11');


INSERT INTO Courses (course_name, department_id, credits) VALUES
('Data Structures', 1, 4),
('Thermodynamics', 2, 3),
('Circuit Analysis', 3, 4),
('Linear Algebra', 4, 3),
('Algorithms', 1, 4);

INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2022-08-10', 85),
(1, 5, '2022-09-01', 90),
(2, 2, '2022-09-10', 75),
(3, 1, '2021-08-05', 88),
(3, 5, '2021-09-15', 92),
(4, 3, '2023-02-10', 60),
(5, 4, '2021-10-05', 70),
(6, 2, '2023-06-01', 55);


INSERT INTO Fees (student_id, total_fee, paid_amount, due_date) VALUES
(1, 50000.00, 50000.00, '2022-09-01'),
(2, 45000.00, 30000.00, '2022-09-15'),
(3, 48000.00, 48000.00, '2021-08-30'),
(4, 47000.00, 20000.00, '2023-02-20'),
(5, 46000.00, 46000.00, '2021-10-10'),
(6, 45000.00, 15000.00, '2023-07-01');

INSERT INTO Results (student_id, course_id, marks, exam_date) VALUES
(1, 1, 85, '2022-12-01'),
(1, 5, 90, '2022-12-15'),
(2, 2, 75, '2022-12-01'),
(3, 1, 88, '2021-12-01'),
(3, 5, 92, '2021-12-20'),
(4, 3, 60, '2023-03-01'),
(5, 4, 70, '2021-12-10'),
(6, 2, 55, '2023-07-01');

INSERT INTO Login (username, password, is_active) VALUES
('admin1', 'pass@123', 1),
('admin2', 'pass@456', 0),
('user1', 'user@123', 1),
('user2', 'user@456', 1);


INSERT INTO Audit_Log (operation_type, table_name, operation_time, user_id) VALUES
('INSERT', 'Students', GETDATE(), 1),
('UPDATE', 'Fees', GETDATE(), 2),
('DELETE', 'Courses', GETDATE(), 3),
('INSERT', 'Results', GETDATE(), 1),
('LOGIN', 'Login', GETDATE(), 4);


--1.	Write a query to fetch names and admission dates of students who joined after 2022-01-01.
select name , admission_date from Students 
--2.	Insert a new student with all appropriate details in the Students table.
Insert into Students Values('yash', 20, 2, getDate())
--3.	Update the paid_amount of a student in the Fees table by adding 5000.
Update Fees set paid_amount = paid_amount + 5000 where student_id=1;
--4.	Delete all students from the Students table who have not enrolled in any course.
Delete from Students Where student_id not in (
select Distinct student_id from Enrollments );
--5.	Write a query to retrieve all students who have paid full fees.
Select student_id from Fees where total_fee = paid_amount ;
--6.	Display the names of students who have a NULL grade in Enrollments.
Select name from Students where student_id in (
select student_id from Enrollments where grade is null) ;

--7.	Write a query using INNER JOIN to fetch student names with
--      their enrolled course names.

Select name , course_name from  Students s INNER JOIN
Enrollments e on s.student_id = e.student_id 
INNER JOIN Courses c 
on c.course_id = e.course_id ;

--8.	Use LEFT JOIN to find students who haven’t enrolled in any course.
Select name  from  Students s LEFT JOIN
Enrollments e on s.student_id = e.student_id 
Where e.course_id is null ;

--9.	Write a subquery to find students who scored above the average in the course "Mathematics".
select name from Students where student_id in (
SELECT student_id FROM Enrollments WHERE course_id = (
 select course_id from Courses where course_name ='Mathematics'
) and grade >= (
 select Avg(grade) from Enrollments where course_id = (
 select course_id from Courses where course_name ='Mathematics'
)));

--10.	Get the names of departments that do not have any students.
select department_name from Departments where  department_id not in (
select Distinct department_id From Enrollments 
)

--11.	Write a query using a subquery inside WHERE clause to get student 
--      details who are enrolled in more than 2 courses.

select * from Students Where student_id in (
select student_id from (
select student_id,course_id ,count(*) as coursecount from 
Enrollments group by student_id, course_id)
as t2 where t2.coursecount > 2 ) ;

--12.	Write a correlated subquery to list students whose fee due date is earlier 
--      than their department's average due date.


--13.	Count the number of students in each department.
select department_id , count(*) [Students in Departments] from Students group by department_id

--14.	Find the average marks in each course.
Select course_id , avg(grade) as [average grade] from Enrollments group by course_id


--15.	List the courses where more than 5 students have scored more than 75 marks.
Select course_id , count(*) as studentCount from Enrollments where grade  > 75  group by course_id having count(*) > 5

--16.	Show total fees paid by students, ordered by highest first.
Select student_id ,sum(paid_amount) as totalFeesPaid from Fees group by student_id  Order by totalFeesPaid Desc 


--17.	Get departments where the average age of students is greater than 23.
select department_id from Students  group by department_id having avg(age) > 23 

--18.	Show the highest and lowest marks in each course.
select course_id , min(grade) as minGrade, max(grade) as maxGrade from Enrollments group by course_id


--19.	Display all student names in uppercase.
select upper(name) from Students 

--20.	Extract the year from the admission_date column.
select name ,YEAR(admission_date) from Students

--21.	Concatenate student_id and name with a dash - in between.
select concat(name,'-',student_id) from Students

--22.	Find students whose names start with 'A' and end with 'n'.
select name from Students where name like 'A%n'

--23.	List all students who were admitted in the month of January.
select name , MONTH(admission_date) as admission_month from  Students where MONTH(admission_date ) = 1  ;

--24.	Create a new table Alumni with fields: alumni_id, name, graduation_year, department.
Create Table Alumni(
 alumni_id int ,
 name varchar(100),
 graduation_year DateTime,
 department varchar(100),
 constraint pk_alumini primary key (alumni_id) );

--25.	Add a new column email to the Students table.

Alter Table Alumni Add email varchar(100) ;

--26.	Rename the column hod_name to head_of_department in the Departments table.
EXEC sp_rename 'Departments.hod_name', 'head_of_department', 'COLUMN';

--27.	Revoke UPDATE permission on Fees from a user finance_clerk.

--28.	Grant SELECT and INSERT privileges on Results to user exam_admin.

--29.	Begin a transaction to deduct fee, commit it only if deduction and logging both succeed.

 
-- 30.	Create a trigger that logs any INSERT into the Fees table into the Audit_Log table.

Create Trigger tr_insertFeesAuditLog
on Fees
after INSERT 
As 
BEGIN
  INSERT into Audit_Log Values('INSERT','Fees',GETDATE(), 1);
END;

select * from Audit_Log
--31.	Write a trigger that prevents insertion into Enrollments if
--      the student has already failed the course.

CREATE TRIGGER tr_preventsEnrollmentInsertion
ON Enrollments
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        WHERE EXISTS (
            SELECT 1
            FROM Enrollments e
            WHERE e.student_id = i.student_id
              AND e.course_id = i.course_id
              AND e.grade < 40
        )
    )
    BEGIN
        RAISERROR('Failed students are not allowed to re-enroll in the same course.', 16, 1);
    END
END;




--32.	Write a stored procedure to get total credits a student has earned.
Create proc spGetTotalCredits
@id int,
@totalCredits int output
As
Begin
  select @totalCredits = Sum(Credits) from Enrollments e join Courses c 
  on e.course_id =c.course_id where e.student_id = @id ;
End ;


--33.Create a procedure that updates a student’s grade based on marks (e.g., >=90 = 'A', etc.).
Create proc spUpdateGrade
@id int ,
@newGrade int output
AS
Begin
 if(Exists(Select 1 from Enrollments where student_id = @id))
 Begin
  Update Enrollments set grade =@newGrade ;
 End ;
End ;



--34.	Create a trigger that automatically deactivates a user in the Login table 
--      if last_login is older than 6 months.

CREATE TRIGGER tr_AutoDeactivateUser
ON Login
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Login
    SET is_active = 0
    WHERE user_id IN (
        SELECT i.user_id
        FROM inserted i
        WHERE i.last_login < DATEADD(MONTH, -6, GETDATE())
    );
END;

--35.	Fetch students who haven’t paid any fee or have negative paid_amount.

select * from Students Where student_id not in(
select Distinct student_id from Fees 
)

--36.	List courses which are not offered by any department.

select * from courses where department_id is null


--37.	Get students who enrolled in the same course more than once.

select student_id, course_id  From Enrollments group by student_id, course_id Having count(*) > 2

--38.	Find duplicate names of students across the table.
Select Distinct name from Students group by name having count(*) > 1

--39.	Write a query to handle division by zero
--      when calculating percentage of fees paid.
SELECT 
  student_id,
  paid_amount,
  total_fee,
  CASE 
    WHEN total_fee = 0 THEN 0
    ELSE CAST(paid_amount AS FLOAT) / total_fee * 100
  END AS percentage_paid
FROM Fees;



--40.	Find top 3 students per course based on marks (use window functions).
SELECT *
FROM (
    SELECT 
        e.student_id,
        c.course_id,
        c.course_name,
        e.grade,
        RANK() OVER (PARTITION BY c.course_id ORDER BY e.grade DESC) AS rank
    FROM Enrollments e
    JOIN Courses c ON e.course_id = c.course_id
) ranked
WHERE rank <= 3;

--41.	List students who are enrolled in all courses offered by their department.

SELECT s.student_id, s.name
FROM Students s
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM Courses c
    WHERE c.department_id = s.department_id
    EXCEPT
    SELECT e.course_id
    FROM Enrollments e
    WHERE e.student_id = s.student_id
);

--42.	Write a query to fetch students who have not logged in since admission.
SELECT s.student_id, s.name
FROM Students s
LEFT JOIN Login l ON s.student_id = l.user_id
WHERE l.last_login IS NULL OR l.last_login <= s.admission_date;

