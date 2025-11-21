-- Stored Procedures --

use employees;
create table books (product_id int primary key, title varchar(50), price float);
insert into books values(101, 'MSSQL',100),(102, 'Half Girlfriend', 699), (103,'Black Magic',700),
 (104, 'How to Marfa', 2000), (105,'How to Laugh', 2001);


drop procedure retrive_data;

create procedure retrive_data 
@product_id int
as
begin 
	select * from books where product_id=@product_id;
end;

exec retrive_data @product_id=104;


-- If Else --
create procedure CheckBooksPrice
 @product_id int
as
begin
	declare @price int;

	select @price = price
	from books
	where product_id = @product_id;

	if @price>=1000
		print 'High price book';
	else if @price>=500
		print 'Medium price book';
	else
		print 'Low price book';
end;

exec CheckBooksPrice @product_id=103;


	

-- Try Catch --
create procedure CheckBooks_Price
 @product_id int
as
begin
begin try  
	   IF NOT EXISTS (SELECT 1 FROM books WHERE product_id = @product_id)
        BEGIN
            -- Raise custom error if ID not found
            RAISERROR('Not correct value provided', 16, 1);
            RETURN;
        END
	declare @price int;

	select @price=price  from books where product_id=@product_id

	if @price is null 
	
	print 'please provide product id ';
	select @price = price
	from books
	where product_id = @product_id;

	if @price>=1000
		print 'High price book';
	else if @price>=500
		print 'Medium price book';
	else
		print 'Low price book';
end try
begin catch
		print 'Error Occured: ' + ERROR_MESSAGE();
end catch
end;

exec CheckBooks_Price @product_id=109;




-- Triggers --
