use employees;
select * from books;

create trigger trg_after_insert_book
on books
after insert
as
begin
	print 'A new book has been added';
end

insert into books values(106,'How to cry', 600);


-- -- 

create trigger trg_after_insert_book_on_delete
on books
instead of delete
as
begin
	print 'Books can not be deleted';
end

delete from books where product_id=105



--------

CREATE TABLE PriceAudit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    OldPrice INT,
    NewPrice INT,
    ChangeDate DATETIME DEFAULT GETDATE()
);
 
 
 
CREATE TRIGGER trg_AuditPriceChange
ON books
AFTER UPDATE
AS
BEGIN
    IF UPDATE(price) -- Run only if price column is updated
    BEGIN
        INSERT INTO PriceAudit (product_id, OldPrice, NewPrice)
        SELECT 
            d.product_id,
            d.price AS OldPrice,
            i.price AS NewPrice
        FROM deleted d
        INNER JOIN inserted i ON d.product_id = i.product_id;
    END
END;
 
 
update books set price=9000 where product_id=104;
 
select * from PriceAudit;



--- Views ---
create view required_view 
as
select title, price from books;

select * from required_view;