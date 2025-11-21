create database PracticeDB
use PracticeDB

create table Employees (Emp_id int, Emp_Name varchar(50),Salary float, Ph_No int, DoB date);
select * from Employees;
insert into Employees (Emp_id, Emp_Name, Salary, Ph_No, DoB)
 values (1, 'Gopal Singh', 10000000, 739087370, '2004-10-31');

insert into Employees (Emp_id, Emp_Name, Salary, Ph_No, DoB)
 values (2, 'Mantu Kumar', 10000000, 839087370, '2003-10-30'),
 (3, 'Tejas', 10000000, 939087370, '2003-11-29'),
 (4, 'Dharmesh', 10000000, 639087370, '2002-11-29'),
 (5, 'Shashi', 10000000, 539087370, '2002-11-19');

 delete  from Employees where Emp_id=2

 select * from Employees
 select Emp_name from Employees
 select Salary from Employees
 select * from Employees where Emp_Name='Dharmesh';

 update Employees set salary = 5000000 where Emp_Name='Shashi';
 update Employees set salary = 6000000 where Emp_Name='Tejas';
 update Employees set salary = 7000000 where Emp_Name='Dharmesh';



