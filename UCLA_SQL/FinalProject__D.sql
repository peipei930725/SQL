ALTER TABLE Student_Courses
ADD CONSTRAINT UC_StudentCourse UNIQUE (StudentID, CourseID);

GO
ALTER TABLE StudentInformation
ADD CreatedDateTime DATETIME NOT NULL DEFAULT GETDATE();

GO
ALTER TABLE StudentInformation
DROP COLUMN AltTelephone;

GO
CREATE INDEX IX_LastName
ON StudentInformation (LastName);
GO

PRINT 'Part D Completed'