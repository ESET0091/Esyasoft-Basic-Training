use employees

select * from emp

alter table emp add  Salary float

update emp set Salary=100000 where id=1;
update emp set Salary=300000 where id=2;
update emp set Salary=200000 where id=3;
update emp set Salary=500000 where id=4;
update emp set Salary=400000 where id=5;

select *from emp where ID=1
select *from emp where ID in (1,2,3,4,9);
select * from emp where Salary>300000;
select * from emp where Salary<300000;
select * from emp where Salary between 300000 and 500000;
select * from emp where Salary between 500000 and 300000;
select * from emp where Name like 'NP';
select * from emp where Name like '%P';
select * from emp where Name not like '%P';
select * from emp where Salary is null;
select * from emp where Salary is not null;
select * from emp where Salary <> 200000;

select max(Salary) as max_sal from emp;
select min(Salary) as min_sal from emp;
select sum(Salary) as sum_sal from emp;
select avg(Salary) as avg_sal from emp;
select count(Salary) as count_sal from emp;


select *, ROW_NUMBER () OVER (order by salary) as popularity,
RANK() OVER (order by salary) as rank_num, DENSE_RANK() OVER (order by salary) as Dense_rank
from emp;

select *, ROW_NUMBER () OVER (order by salary) as popularity from emp;

