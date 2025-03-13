


-- Creating the database and selecting it
CREATE DATABASE SchoolDB;

USE SchoolDB;


-- Creating a table (DDL - CREATE)
CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Email VARCHAR(100)
);


-- Modifying the table (DDL - ALTER)
ALTER TABLE Students ADD Address VARCHAR(255);


-- Renaming the table (DDL - RENAME using sp_rename in SQL Server)
EXEC sp_rename 'Students', 'Learners';


-- Dropping the table (DDL - DROP)
DROP TABLE Learners;


-- Recreating the table for further operations
CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Email VARCHAR(100),
    Address VARCHAR(255)
);


-- Inserting data into the table (DML - INSERT)
INSERT INTO Students VALUES (1, 'yash', 22, 'yash@example.com', '123 Main St');
INSERT INTO Students VALUES (2, 'vansh', 24, 'vansh@example.com', '456 Park Ave');
INSERT INTO Students VALUES (3, 'vraj', 21, 'vraj@example.com', '789 Elm St');
INSERT INTO Students VALUES (4, 'jay', 25, 'jay@example.com', '567 Oak St');
INSERT INTO Students VALUES (5, 'kuldip', 23, 'kuldip@example.com', '890 Birch St');


-- Displaying all records (DQL - SELECT)
SELECT * FROM Students;


-- Selecting specific columns
SELECT Name, Age FROM Students;


-- Selecting students above a certain age
SELECT * FROM Students WHERE Age > 22;


-- Counting total number of students
SELECT COUNT(*) AS Total_Students FROM Students;


-- Finding the average age of students
SELECT AVG(Age) AS Average_Age FROM Students;


-- Finding the youngest and oldest students
SELECT MIN(Age) AS Youngest, MAX(Age) AS Oldest FROM Students;


-- Sorting students by name in ascending order
SELECT * FROM Students ORDER BY Name ASC;


-- Sorting students by age in descending order
SELECT * FROM Students ORDER BY Age DESC;


-- Grouping students by age
SELECT Age, COUNT(*) AS Count FROM Students GROUP BY Age;


-- Updating a record (DML - UPDATE)
UPDATE Students SET Age = 23 WHERE ID = 1;


-- Deleting a record (DML - DELETE)
DELETE FROM Students WHERE ID = 2;


-- Truncating the table (DDL - TRUNCATE)
TRUNCATE TABLE Students;


-- Reinserting data after truncation
INSERT INTO Students VALUES (1, 'John', 22, 'john@example.com', '123 Main St');
INSERT INTO Students VALUES (2, 'Alice', 24, 'alice@example.com', '456 Park Ave');
INSERT INTO Students VALUES (3, 'Bob', 21, 'bob@example.com', '789 Elm St');


-- Transaction Control Example (TCL - COMMIT, ROLLBACK)
BEGIN TRANSACTION;

UPDATE Students SET Age = 26 WHERE ID = 3;

SAVE TRANSACTION SavePoint1;

SELECT * FROM Students; -- Before rollback


ROLLBACK TRANSACTION SavePoint1;


SELECT * FROM Students; -- After rollback
COMMIT;



