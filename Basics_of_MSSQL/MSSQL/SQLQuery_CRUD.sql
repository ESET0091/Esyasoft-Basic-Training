CREATE table TestEmployee(ID INT IDENTITY(1,1) Primary key, Name varchar(100), Age INT, Active Int)

SELECT * FROM TestEmployee;
-- SELECT ALL
-- SELECT By ID
-- Insert New record
-- Update record
-- Delete record

CREATE PROC usp_AddEmployeee(@Name varchar(100), @Age INT, @Active INT)
AS
BEGIN
	INSERT INTO TestEmployee(Name, Age, Active)
	Values (@Name, @Age, @Active);
END;

CREATE PROC usp_GetAllEmployees
AS
BEGIN
	SELECT * from TestEmployee;
END

CREATE PROC usp_GetEmployeesByID(@Id INT)
AS
BEGIN
	SELECT * from TestEmployee WHERE ID =@Id;
END