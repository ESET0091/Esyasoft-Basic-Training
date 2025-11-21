create database AdvanceDB;
use AdvanceDB;

-- Create table Student --
create table Student(Std_Id int constraint pk_student primary key, Std_Name varchar(50), 
	Math_Mark int, Sc_Mark int, Eng_Mark int, DoB Date);

Insert into Student values(1, 'Gopal Singh', 97, 87, 84, '2004-10-31'),
	(2, 'Mantu Kumar', 96, 89, 85, '2002-09-29'),
	(3, 'Dharmesh Kumar', 95, 88, 89, '2003-2-14');

Select * from Student;
Select * from Student where Math_Mark>90 and Sc_Mark>88 and Eng_Mark>84;

Select * from Student where DoB Between '2003-2-14' and '2004-10-31';

Select * from Student where Math_Mark<85 or Sc_Mark<85 or Eng_Mark<85;

Select * from Student where Std_Name = 'Dharmesh Kumar';

Select * from Student where Std_Name = 'Dharmesh Kumar' or Std_Name = 'Mantu Kumar';

Select * from Student where Std_Name in ( 'Dharmesh Kumar', 'Mantu Kumar');

Select * from Student where MONTH(DoB) =02;

Select * from Student where MONTH(DoB) Between 1 and 10;

Select * from Student where Day(DoB) = 31;

Select * from Student where Year(DoB) = 2004;

Select GETDATE() from Student;

Select DateAdd(Day, 7, DoB) from Student;

Select DateDiff(Day, DoB, GETDATE()) from Student;

Select Convert(Date,GETDATE()) from Student;

Select DATEPART(YEAR, DoB) from Student;

Select UPPER(Std_Name) from Student;
Select LOWER(Std_Name) from Student;

Select * from Student where Std_Name like 'G%';
Select * from Student where Std_Name like '%Kumar';
Select * from Student where Std_Name like '__pal%';

Select CONCAT(Std_Name,' ', 'has scored', ' ', Math_Mark +Sc_Mark + Eng_Mark)  as 'Total Marks' from Student;

-- Remove trailing spaces (right side)
SELECT RTRIM('  Hello World  ') AS TrimmedRight;  -- '  Hello World'

-- Remove leading spaces (left side)
SELECT LTRIM('  Hello World  ') AS TrimmedLeft;   -- 'Hello World  '

-- Remove both leading and trailing spaces
SELECT LTRIM(RTRIM('  Hello World  ')) AS FullyTrimmed;  -- 'Hello World'

SELECT RIGHT(REPLICATE('0', 3)+ '1234',6);
SELECT RIGHT(REPLICATE('0', 3)+ '1234',8);
SELECT LEFT(REPLICATE('0', 3)+ '1234',6);
SELECT (REPLICATE('0', 3)+ '1234');

SELECT (STR('1234', 5));
SELECT (STR(1234.56));
SELECT REPLACE(STR('1234', 8),' ','0');
SELECT REPLACE(STR('1234', 8),' ','*');

Select FORMAT(DoB, 'dd/MM/yyyy') AS 'Date of Birth' from Student; 

Select Std_Id from Student where Std_Id LIKE '%[^0-1]%';

-- Numeric functions --
SELECT 
    POWER(2, 3) AS Power1,     
    POWER(5, 2) AS Power2,      
    POWER(16, 0.5) AS Power3,   
    SQRT(25) AS SquareRoot1,    
    SQUARE(5) AS Square1; 
	
SELECT 
    EXP(1) AS Exponential,      
    LOG(10) AS NaturalLog,      
    LOG10(100) AS LogBase10; 
	
SELECT SIN(PI()/6) AS Sine;          
SELECT COS(RADIANS(60)) AS Cosine;         
SELECT TAN(PI()/4) AS Tangent;        

SELECT 
    RAND() AS Random1,          -- 0.715436... (0 to 1)
    RAND(5) AS SeededRandom,    -- Same seed = same random number
    RAND() * 100 AS Random100,  -- 0 to 100
    FLOOR(RAND() * 100) AS RandomInt; -- Integer 0-99

-- SQL Server 2022 and later
SELECT 
    GREATEST(10, 20, 5) AS GreatestValue,        
    GREATEST(15.5, 12.3, 18.7) AS GreatestDecimal; 

SELECT 
    CONVERT(VARCHAR, 123) AS IntToVarchar,           -- '123'
    CONVERT(VARCHAR, 123.45) AS DecimalToVarchar,    -- '123.45'
    CONVERT(VARCHAR, GETDATE()) AS DateToVarchar;    -- 'Dec 30 2024  2:30PM'

SELECT REPLACE(CONVERT(VARCHAR, GETDATE(), 101),'/',',');
SELECT FORMAT(GETDATE(), 'yyyyMMddHHmmss');


-- Fetch details from a table and add it in another table --
create table Stdudent_copy(Std_Id int constraint pk_copy_student primary key, Std_Name varchar(50), 
	Math_Mark int, Sc_Mark int, Eng_Mark int, DoB Date);

Insert into Stdudent_copy Select * from Student;
Select * from Stdudent_copy;

Select * into StudentDummy from Student;
Select * from StudentDummy;

Alter table Student add TotalMarks int, AvgMarks int, Status varchar(20), Grade varchar(10); 
Select * from Student;
Update Student set TotalMarks = (Math_Mark + Sc_Mark + Eng_Mark);
Update Student set AvgMarks = TotalMarks/3;

Update Student set Status = 
	case 
		when AvgMarks>80 then 'Pass'
		else 'Fail'
	end

Update Student set Grade =
	case 
		when AvgMarks>=90 then 'O'
		When AvgMarks>=80 then 'A'
	end

Select * from Student Order by Math_Mark;
Select top 1* from Student Order by Math_Mark;
Select * from Student Order by Math_Mark, Eng_Mark;

Select Grade, count(*) from Student group by Grade;
Select Status, count(*) from Student group by Status;
Select Grade, count(*) from Student group by Grade having count(*) > 1;


 --- Unique, check, Default constraint -- 
 CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,           -- Unique email addresses
    phone_number VARCHAR(15) UNIQUE,     -- Unique phone numbers
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);


Insert into employees values(1, 'Gopal@gmail.com', '7390873789', 'Gopal', 'Singh'),
(2, 'Mantu@gmail.com', '7390873709', 'Mantu', 'Kumar');

Select * from employees;
	
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),           -- Price must be positive
    discount DECIMAL(5,2) CHECK (discount >= 0 AND discount <= 100), -- Discount between 0-100%
    stock_quantity INT CHECK (stock_quantity >= 0)   -- Cannot have negative stock
);

ALTER TABLE products ADD CONSTRAINT chk_price_positive 
CHECK (price > 0);

ALTER TABLE products ADD CONSTRAINT chk_discount_range 
CHECK (discount >= 0 AND discount <= 100);

INSERT INTO products (product_id, product_name, price, discount, stock_quantity) 
VALUES (1, 'Laptop', 999.99, 10.00, 50);

INSERT INTO products (product_id, product_name, price, discount, stock_quantity) 
VALUES (2, 'Wireless Mouse', 29.99, 0.00, 100);

Select * from products;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE DEFAULT GETDATE(),              -- Current date
    status VARCHAR(20) DEFAULT 'PENDING',           -- Default status
    created_at DATETIME DEFAULT GETDATE(),          -- Timestamp
    priority INT DEFAULT 1,                         -- Default priority
    discount DECIMAL(5,2) DEFAULT 0.00              -- Default discount
);

INSERT INTO orders (order_id, status, priority, discount) 
VALUES (1001, 'PROCESSING', 2, 5.00);

INSERT INTO orders (order_id, status) 
VALUES (1002, 'SHIPPED'); 

INSERT INTO orders (order_id) 
VALUES (1003);

SELECT * FROM orders;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) CHECK (LEN(username) >= 5 AND LEN(username) <= 20),
    password VARCHAR(100) CHECK (LEN(password) >= 8),
    email VARCHAR(100) CHECK (LEN(email) >= 5 AND email LIKE '%@%.%')
);

-- Valid data
INSERT INTO users VALUES (1, 'john_doe', 'securepass123', 'john@email.com');
INSERT INTO users VALUES (2, 'jane_smith', 'strongpassword', 'jane@company.org');

--  Invalid: Username too short
INSERT INTO users VALUES (3, 'joe', 'password123', 'joe@email.com');
Select * from users;

Select * from sys.objects;
Select * from sys.check_constraints;
Select * from sys.default_constraints;

-- Foreign key --
CREATE TABLE departments (
    department_id INT PRIMARY KEY IDENTITY(1,1),
    department_name VARCHAR(50) NOT NULL UNIQUE,
    manager_id INT,
    budget DECIMAL(15,2) DEFAULT 0,
    created_date DATETIME DEFAULT GETDATE()
);

INSERT INTO departments (department_name, manager_id, budget) VALUES
('Human Resources', 101, 500000.00),
('Information Technology', 102, 1500000.00),
('Finance', 103, 800000.00),
('Marketing', 104, 600000.00);

SELECT * FROM departments;

CREATE TABLE employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL DEFAULT GETDATE(),
    salary DECIMAL(10,2) CHECK (salary > 0),
    department_id INT NOT NULL,
    -- Foreign key constraint
    CONSTRAINT fk_employee_department 
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert sample data into child table
INSERT INTO employee (first_name, last_name, email, hire_date, salary, department_id) VALUES
('John', 'Doe', 'john.doe@company.com', '2023-01-15', 60000.00, 2),
('Jane', 'Smith', 'jane.smith@company.com', '2023-03-20', 55000.00, 1),
('Mike', 'Johnson', 'mike.johnson@company.com', '2022-11-10', 75000.00, 2),
('Sarah', 'Wilson', 'sarah.wilson@company.com', '2024-02-01', 48000.00, 3),
('David', 'Brown', 'david.brown@company.com', '2023-07-15', 52000.00, 4);

SELECT * FROM departments;
SELECT * FROM employee;