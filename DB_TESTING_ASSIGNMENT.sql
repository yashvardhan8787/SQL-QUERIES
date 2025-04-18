CREATE DATABASE Hospital; 

USE Hospital; 

CREATE TABLE STAFF(  

STAFF_ID  Int ,  

NAME Varchar(255),  

JOB_TITLE VARCHAR(255),  

DEPARTMENT VARCHAR(255), 

 HIRE_DATE DATE,  

SALARY Money, 

 SUPERVISOR Int,  

CONSTRAINT PK_STAFF PRIMARY KEY (STAFF_ID),  

CONSTRAINT FK_STAFF FOREIGN KEY (SUPERVISOR) REFERENCES STAFF(STAFF_ID) ); 

 

Insert Into STAFF Values (1002, 'Dr. John Smith ','Surgeon','Surgery' ,'01-Jun-15', 180000,null),
(1003 ,'Dr. Emily Chen', 'Pediatrician', 'Pediatrics', '01-Aug-18', 120000, 1002),
(1004 ,'Dr. Michael Brown', 'Anesthesiologist' ,'Anesthesiology', '01-Sep-12', 160000, 1002),
(1005, 'Nurse Jane Doe', 'Nurse', 'Nursing' ,'01-Mar-10', 80000 ,1003),
(1006, 'Nurse Bob Johnson' ,'Nurse','Nursing', '01-Jul-16 ',90000, 1003), 
(500 , 'Dr. David Lee', 'Hospital Administrator', 'Administration' ,'01-Jan-05', 200000,null) 

Select * from STAFF 

--Question 1: --Write a query to retrieve the names and salaries of all staff members. 

SELECT NAME, SALARY FROM STAFF; 

--Question 2: --Write a query to retrieve the names of all staff members who work in the 'Nursing' department. 

SELECT NAME FROM STAFF WHERE DEPARTMENT ='Nursing'; 

--Question 3: --Write a query to retrieve the name and hire date of the staff member with the highest salary. 

SELECT NAME , SALARY ,HIRE_DATE FROM STAFF WHERE SALARY=(SELECT MAX(SALARY) FROM STAFF); 

--Question 4: --Write a query to count how many staff members are in the 'Pediatrics' department. 

SELECT COUNT(*) as [No. of Staff Members in Pediatrics] FROM STAFF WHERE DEPARTMENT='Pediatrics';  

--Question 5: --Write a query to retrieve the names and job titles of all staff members hired after January 1, 2016. 

SELECT NAME,JOB_TITLE FROM STAFF WHERE HIRE_DATE > '01-jan-2016' ;  

--Question 6: --Write a query to retrieve the name and salary of the staff member who has the second-highest salary. 

SELECT NAME , SALARY FROM STAFF WHERE SALARY = ( SELECT MAX(SALARY) FROM ( SELECT SALARY FROM STAFF WHERE SALARY < ( SELECT MAX(SALARY) FROM STAFF)) AS STAFF); 

--Question 7: --Write a query to insert a new staff member, 'Dr. Rachel Green', as a Dermatologist in the --Dermatology department with a salary of 140000 and a hire date of February 1, 2021, under the --supervision of Dr. John Smith (staff ID 1002). 

Insert Into STAFF Values(1008,'Dr. Rachel Green', 'Dermatologist', 'Dermatology', '01-Feb-2021',140000, 1009); 

--Question 8: --Write a query to retrieve the name, job title, and salary of all staff members who earn less than 100000. 

SELECT NAME, JOB_TITLE, SALARY FROM STAFF WHERE SALARY < 100000 ; 

--Question 9: --Write a query to update the salary of 'Nurse Jane Doe' to 85000. 

UPDATE STAFF SET SALARY=85000 WHERE NAME='Nurse Jane Doe' ; 

--Question 10: --Write a query to retrieve the names of all staff members who report to Dr. John Smith (staff ID 1002) --or Dr. Emily Chen (staff ID 1003), along with their supervisor’s name. 

SELECT ST.NAME As [Staff Member] , SP.NAME as [Supervisor] from STAFF ST join STAFF SP on ST.SUPERVISOR = SP.STAFF_ID Where ST.SUPERVISOR IN(1002,1003) 

--Question 11: --Write a query to delete the staff member with the name 'Nurse Bob Johnson' from the STAFF table. 

DELETE FROM STAFF WHERE NAME='Nurse Bob Johnson'; 

 