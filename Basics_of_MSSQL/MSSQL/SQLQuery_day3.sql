create database employees

use employees

create table Employee (Emp_id int, Emp_Name varchar(50),Branch varchar(100), Salary float, );
select * from Employee;

insert into Employee (Emp_id, Emp_Name, Branch, Salary)
 values (1, 'Akash','Mechanical', 100000.0),
 (2, 'Aman','Computer', 200000.0),
 (3, 'Ankesh','Electrical', 300000.0),
 (4, 'Ankit','Chemical', 400000.0),
 (5, 'Ajay','Mechanical', 500000.0);


 select * from Employee where salary>100000;
 update Employee set Emp_Name='Shivam' where Emp_id=4;
 delete from Employee where Emp_Name='Shivam';
 select * from Employee;

 alter table Employee add Ph_No Bigint;
 alter table Employee alter column Ph_No varchar(50);

 EXEC sp_help 'Employee';
 alter table Employee drop column Ph_No;

 EXEC sp_rename 'Employee.Emp_Name', 'Name', 'column';
 EXEC sp_rename 'Employee', 'EmployeeT';
 select * from Employee;
 EXEC sp_rename 'EmployeeT', 'Employee';
 alter table Employee alter column Salary varchar(50);
 alter table Employee alter column Salary Bigint;
 alter table Employee alter column Branch Bigint;

