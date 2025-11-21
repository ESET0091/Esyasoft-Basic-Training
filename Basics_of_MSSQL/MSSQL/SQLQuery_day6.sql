-- Join Operations --

create database employees;
use employees;

create table users (user_id int primary key, email varchar(20), name varchar(50));
create table books (product_id int primary key, title varchar(50), price float);
alter table users alter column email varchar(40);

select * from users;
select * from books;


create table orders (order_no int primary key, user_id int, product_id int, 
 foreign key (user_id) references users(user_id), foreign key (product_id) references books(product_id));

select * from users;
select * from books;
select * from orders;

insert into users values(1, 'callmebhai@gmail.com', 'GopalBhai'),
(2, 'toxicmajhi@gmail.com', 'Manjit'),(3,'kalajadu@gmail.com','SoumyaDeep'),
(4,'vimalpanmasala@gmail.com','JaiSai'),(5,'ghostlaugh@gmail.com','Namitha');

insert into books values(101, 'MSSQL',100),(102, 'Half Girlfriend', 699), (103,'Black Magic',700),
 (104, 'How to Marfa', 2000), (105,'How to Laugh', 2001);

insert into orders values (401,1,101), (402,2,102), (403,2,103),(404,3,103), (405,3,104), (406,4,102), (407,5,102), (408,5,105);
select * from orders;


select u.user_id, u.name, b.title, o.order_no from users u inner join orders o on u.user_id = o.user_id
 inner join books b on  b.product_id= o.product_id;

 select u.user_id, u.name, b.title, o.order_no from users u inner join orders o on u.user_id = o.user_id
 inner join books b on  b.product_id= o.product_id where b.title='Black Magic';

 select u.user_id, u.name, b.title, o.order_no, b.price from users u inner join orders o on u.user_id = o.user_id
 inner join books b on  b.product_id= o.product_id where price=(select max(price) from books b);


 select product_id from orders union all select product_id from books;