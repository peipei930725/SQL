GO

CREATE PROCEDURE usp_dropTables
AS
BEGIN
    DROP TABLE IF EXISTS EmpJobPosition;
    DROP TABLE IF EXISTS Employees;
    DROP TABLE IF EXISTS StudentInformation;
    DROP TABLE IF EXISTS CourseList;
    DROP TABLE IF EXISTS student_course;
    DROP TABLE IF EXISTS ContactType;
    DROP TABLE IF EXISTS StudentContacts;
END;

GO

EXEC usp_dropTables;

PRINT 'Part B Completed'