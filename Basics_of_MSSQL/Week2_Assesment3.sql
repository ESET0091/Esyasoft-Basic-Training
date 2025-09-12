-- Basic Task --

create database university;
use university;

CREATE TABLE Students2024 (ID INT, Name VARCHAR(50));
CREATE TABLE Students2025 (ID INT, Name VARCHAR(50));

INSERT INTO Students2024 VALUES
(1,'Ravi'),(2,'Asha'),(3,'John'),(4,'Meera'),(5,'Kiran'),
(6,'Divya'),(7,'Lokesh'),(8,'Anita'),(9,'Rahul'),(10,'Sneha');

INSERT INTO Students2025 VALUES
(2,'Asha'),(4,'Meera'),(5,'Kiran'),(11,'Prakash'),(12,'Vidya'),
(13,'Neha'),(14,'Manoj'),(15,'Ramesh'),(16,'Lata'),(17,'Akash');


CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Department VARCHAR(20));

INSERT INTO Employees VALUES 
(1,'Ananya','HR'),(2,'Ravi','IT'),(3,'Meera','Finance'),
(4,'John','IT'),(5,'Divya','Marketing'),(6,'Sneha','Finance'),
(7,'Lokesh','HR'),(8,'Asha','IT'),(9,'Kiran','Finance'),(10,'Rahul','Sales');



CREATE TABLE Projects (ProjectID INT, Name VARCHAR(50), StartDate DATE, EndDate DATE);
INSERT INTO Projects VALUES 
(1,'Bank App','2025-01-01','2025-03-15'),
(2,'E-Commerce','2025-02-10','2025-05-20');


CREATE TABLE Contacts (ID INT, Name VARCHAR(50), Email VARCHAR(50), Phone VARCHAR(20));
INSERT INTO Contacts VALUES
(1,'Ravi','ravi@gmail.com',NULL),
(2,'Asha',NULL,'9876543210'),
(3,'John',NULL,NULL);

select * from Students2024;
select * from Students2025;
select * from Employees;
select * from Projects;
select * from Contacts;

-- Task 1--
select Name from Students2024 union select Name from Students2025;
select Name from Students2024 union all select Name from Students2025;

-- Task 2 --
select upper(name) as uppercase from employees;
select lower(name) as lowercase from employees;
select len(name) length from employees;
select substring(name,1,3) as Subname from employees;
select replace(Department, 'Finance','Account') from employees;
select concat(name,' ', Department) from employees;

-- Task 3 --
select getdate() as CurrentDate;
select datediff(day, StartDate, EndDate) as Duration from projects;
select dateadd(day, 10, EndDate) as newEndDate from projects;
select datediff(day, getdate(), EndDate) as LeftDays from projects;

-- Task 4 --
select convert(varchar(10), getdate(), 103) as Date_DDMMYYYY;
select cast(123.456 as int) as IntNum;
select Department, case
	when Department = 'IT' then 'Tech Team'
	when Department = 'HR' then 'Human Resources'
	else 'Others' end as status from Employees;








