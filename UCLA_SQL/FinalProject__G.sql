CREATE PROCEDURE usp_addQuickContacts
    @StudentEmail VARCHAR(50),
    @EmployeeName VARCHAR(50),
    @ContactDetails VARCHAR(50),
    @ContactType VARCHAR(50)
AS
BEGIN
    DECLARE @ContactTypeID INT;

    SELECT @ContactTypeID = ContactTypeID FROM ContactType WHERE ContactType = @ContactType;

    IF @ContactTypeID IS NULL
    BEGIN
        INSERT INTO ContactType (ContactType) VALUES (@ContactType);
        SET @ContactTypeID = SCOPE_IDENTITY();
    END

    INSERT INTO StudentContacts (StudentEmail, EmployeeName, ContactDetails, ContactTypeID, ContactDate)
    VALUES (@StudentEmail, @EmployeeName, @ContactDetails, @ContactTypeID, GETDATE());
END;
GO

-- EXEC usp_addQuickContacts 'minnie.mouse@disney.com','John Lasseter','Minnie getting Homework Support from John','Homework Support' 
-- EXEC usp_addQuickContacts 'porky.pig@warnerbros.com','John Lasseter','Porky studying with John for Test prep','Test Prep'

PRINT 'Part G Completed'
