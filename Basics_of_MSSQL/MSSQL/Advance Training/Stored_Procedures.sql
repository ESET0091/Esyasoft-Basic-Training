use AdvanceDB;
Select * from Student;

-- Stored Procedure --
Create Procedure SelectStudent @Math_Mark int
As
Begin
Select * from Student where Math_Mark= @Math_Mark
END;

Exec SelectStudent @Math_Mark = 97;

Create Procedure insertStudent
as 
begin
insert into Student values (4,'Karthik',98,94,89,'2000-10-04',281,93,'Pass','O');
end;

Exec insertStudent;


-- Procedure for multiple parameters --
-- Create procedure to get students by status and minimum marks
CREATE PROCEDURE GetStudentsByStatusAndMarks
    @Status VARCHAR(20),
    @MinMarks INT
AS
BEGIN
    SELECT * FROM Student 
    WHERE Status = @Status AND TotalMarks >= @MinMarks;
END;

-- Execute
EXEC GetStudentsByStatusAndMarks @Status = 'Pass', @MinMarks = 260;


-- Create procedure to add new student
CREATE PROCEDURE AddNewStudent
    @StdId INT,
    @StdName VARCHAR(50),
    @MathMark INT,
    @ScMark INT,
    @EngMark INT,
    @DoB DATE
AS
BEGIN
    INSERT INTO Student (Std_Id, Std_Name, Math_Mark, Sc_Mark, Eng_Mark, DoB)
    VALUES (@StdId, @StdName, @MathMark, @ScMark, @EngMark, @DoB);
    
    -- Calculate and update derived columns
    UPDATE Student 
    SET TotalMarks = (Math_Mark + Sc_Mark + Eng_Mark),
        AvgMarks = (Math_Mark + Sc_Mark + Eng_Mark)/3,
        Status = CASE 
				   WHEN (Math_Mark + Sc_Mark + Eng_Mark)/3 >= 80 THEN 'Pass'
				   ELSE 'Fail'
			   END,
        Grade = CASE 
                   WHEN (Math_Mark + Sc_Mark + Eng_Mark)/3 >= 90 THEN 'O'
                   WHEN (Math_Mark + Sc_Mark + Eng_Mark)/3 >= 80 THEN 'A'
                   ELSE 'B'
               END
    WHERE Std_Id = @StdId;
    
    PRINT 'Student added successfully!';
END;

-- Execute
EXEC AddNewStudent 
    @StdId = 5,
    @StdName = 'Priya Sharma',
    @MathMark = 85,
    @ScMark = 82,
    @EngMark = 88,
    @DoB = '2003-05-15';

Select * from Student;


-- Create procedure to update marks with validation
CREATE PROCEDURE UpdateStudentMarks
    @StudentId INT,
    @MathMark INT,
    @ScMark INT,
    @EngMark INT
AS
BEGIN
    -- Check if student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE Std_Id = @StudentId)
    BEGIN
        PRINT 'Error: Student ID ' + CAST(@StudentId AS VARCHAR) + ' does not exist!';
        RETURN;
    END
    
    -- Validate marks range
    IF @MathMark < 0 OR @MathMark > 100 OR 
       @ScMark < 0 OR @ScMark > 100 OR 
       @EngMark < 0 OR @EngMark > 100
    BEGIN
        PRINT 'Error: Marks should be between 0 and 100!';
        RETURN;
    END
    
    -- Update marks
    UPDATE Student 
    SET Math_Mark = @MathMark,
        Sc_Mark = @ScMark,
        Eng_Mark = @EngMark,
        TotalMarks = (@MathMark + @ScMark + @EngMark),
        AvgMarks = (@MathMark + @ScMark + @EngMark)/3,
        Status = CASE WHEN (@MathMark + @ScMark + @EngMark)/3 > 80 THEN 'Pass' ELSE 'Fail' END,
        Grade = CASE 
                   WHEN (@MathMark + @ScMark + @EngMark)/3 >= 90 THEN 'O'
                   WHEN (@MathMark + @ScMark + @EngMark)/3 >= 80 THEN 'A'
                   ELSE 'B'
               END
    WHERE Std_Id = @StudentId;
    
    PRINT 'Marks updated successfully for Student ID: ' + CAST(@StudentId AS VARCHAR);
END;

-- Execute (test with valid and invalid data)
EXEC UpdateStudentMarks @StudentId = 1, @MathMark = 99, @ScMark = 92, @EngMark = 88;
EXEC UpdateStudentMarks @StudentId = 999, @MathMark = 85, @ScMark = 82, @EngMark = 88; -- Invalid ID
EXEC UpdateStudentMarks @StudentId = 1, @MathMark = 105, @ScMark = 82, @EngMark = 88; -- Invalid marks


-- Simple loop to print numbers 1 to 5
CREATE PROCEDURE BasicLoopExample
AS
BEGIN
    DECLARE @Counter INT = 1;
    
    WHILE @Counter <= 5
    BEGIN
        PRINT 'Counter value: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END
END;


-- Execute
EXEC BasicLoopExample;



-- Loop through all students and display their information
CREATE PROCEDURE LoopThroughStudents
AS
BEGIN
    DECLARE @StdId INT, @StdName VARCHAR(50), @TotalMarks INT;
    DECLARE @Counter INT = 1;
    DECLARE @TotalStudents INT;
    
    -- Get total number of students
    SELECT @TotalStudents = COUNT(*) FROM Student;
    
    WHILE @Counter <= @TotalStudents
    BEGIN
        -- Get student details
        SELECT 
            @StdId = Std_Id,
            @StdName = Std_Name,
            @TotalMarks = TotalMarks
        FROM (
            SELECT *, ROW_NUMBER() OVER (ORDER BY Std_Id) as RowNum
            FROM Student
        ) AS Temp
        WHERE RowNum = @Counter;
        
        -- Display student info
        PRINT 'Student ' + CAST(@Counter AS VARCHAR) + 
              ': ID=' + CAST(@StdId AS VARCHAR) + 
              ', Name=' + @StdName + 
              ', Total Marks=' + CAST(@TotalMarks AS VARCHAR);
        
        SET @Counter = @Counter + 1;
    END
END;

-- Execute
EXEC LoopThroughStudents;