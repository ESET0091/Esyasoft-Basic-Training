use employees;

create table university (ID int primary key identity (1,1), 
 Names varchar(100), Dept varchar(100), Fees float);

insert into university values ('Shivam', 'Mech', 4500.09);
select * from university;
update  university set Fees=45000.09 where Id=1;
update  university set Names='Gopal', Email='Gopal@gmail.com' where Id=1;
alter table university add Email varchar(50) unique;
update university set Email='Shivam@gmail.com' where ID=1;
EXEC sp_help 'university'

insert into university values ('Madhav', 'Computer', 7500.09, 'Madhav@gmail.com'),
('Ayush', 'Civil', 6500.09,'Ayush@gmail.com'),('Tejal', 'Meta', 5500.09, 'Tejal@gmail.com'),
('Abhay', 'Electrical', 8500.09,'Abhay@gmail.com'), ('Monika', 'Chemical', 2500.09, 'Monika@gmail.com'),
('Mohit', 'Biotech', 3500.09, 'Mohit@gmail.com'), ('Saksham', 'Polymer', 4500.09, 'Saksham@gmail.com');


create table student (S_ID int, Name varchar(50), class varchar(10), 
 foreign key (S_ID) references university(ID));
select * from student;

insert into student values (1,'Mantu', 'Middle'),(2, 'Tejas', 'Upper'),(3,'Shashi', 'Lower');

delete from university where id=2;





create table Emp (ID int primary key, Name varchar(50), Dept varchar(50), Salary varchar(40));
select * from Emp;
insert into Emp values (1, 'NB', 'IT', 100000);
insert into Emp values (2, 'SD', 'HR', 200000);
insert into Emp values (3, 'MM', 'Marketing', 300000);
update Emp set Salary=400000 where ID=2;
insert into Emp values (4, 'SK', 'Marketing', 200000);
insert into Emp values (5, 'NP', 'IT', 100000);

alter table Emp add Ph_No varchar(40);
update Emp set Ph_No=9999999999 where ID=1;
update Emp set Ph_No=8888888888 where ID=2;
update Emp set Ph_No=7777777777 where ID=3;
update Emp set Ph_No=6666666666 where ID=4;
update Emp set Ph_No=5555555555 where ID=5;
select * from Emp;


create table SalaryT (ID int primary key, Salary varchar(40), foreign key (ID) references Emp(ID));
select * from SalaryT;

insert into SalaryT values (1,100000),(2,400000),(3,300000),(4,200000),(5,100000);
alter table Emp drop column Salary;
alter table Emp alter column Ph_No Bigint;

