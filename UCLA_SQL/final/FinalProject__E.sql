CREATE TRIGGER trg_assignEmail
ON StudentInformation
AFTER INSERT
AS
BEGIN
    UPDATE StudentInformation
    SET Email = I.FirstName + '.' + I.LastName + '@disney.com'
    FROM INSERTED I
    WHERE StudentInformation.StudentID = I.StudentID AND I.Email IS NULL;
END;
GO

PRINT 'Part E Completed'