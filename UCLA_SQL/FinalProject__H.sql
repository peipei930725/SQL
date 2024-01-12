CREATE PROCEDURE usp_getCourseRosterByName
    @CourseDescription VARCHAR(255)
AS
BEGIN
    SELECT S.FirstName, S.LastName, C.CourseDescription
    FROM Student_Courses SC
    JOIN StudentInformation S ON SC.StudentID = S.StudentID
    JOIN CourseList C ON SC.CourseID = C.CourseID
    WHERE C.CourseDescription = @CourseDescription;
END;
GO

-- EXEC usp_getCourseRosterByName 'Intermediate Math';

PRINT 'Part H Completed'