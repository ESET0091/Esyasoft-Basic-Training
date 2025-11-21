-- UNION and UNION ALL --
use employees;

select * from users;
select * from books;
select * from orders;

 select product_id  from orders union select product_id from books;
 select product_id from orders union all select product_id from books;

 -- upper and lower --

 select getdate() as today_date;
 select upper('Gopal') as UpperText;
 select lower('GoPaL') as LowerText;

 select upper (name) as NAME from users;

 -- Len no of character --
 select len(23445) as hello;
 select len(name) as name_len from users;
 select len('Gopal    ') as length;
 select len('Gopal Singh') as length;
 select len('    Gopal') as length;

 -- Substring -- 3 = string position -- 4 = no of character to return
 select substring('Gopal', 3, 4) as Gopal;
 select substring(name, 3, 4) as substrings from users;
 
 -- Reverse --
 select reverse(name) from users;
 select reverse(substring(name,2,len(name))) from users;

 -- Replace --
 select replace('Gopal likes tea', 'tea', 'coffee');
 select replace(name, 'Manjit', 'Mantu') from users;
 select replace(22,2,4);

 -- Concat --
 select concat('Gopal dont', ' ', 'like EV') as hell;
 select concat(name,' ', email) from users;

 -- Cast -- 
 select cast('500000' as int) as SalaryInt;
 select cast(user_id as float) from users;

 -- Convert --
 select getdate() as todaydate;
 select convert(varchar(10), getdate(), 103) as Date_DDMMYYYY;
 select convert(varchar(10), getdate(), 104) as Date_DDMMYYYY;
 select convert(varchar(10), getdate(), 102) as Date_DDMMYYYY;

 -- Case --
