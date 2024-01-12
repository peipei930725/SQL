ALTER TABLE student_course
DROP CONSTRAINT PK_student_course;
GO

ALTER TABLE student_course
ADD CONSTRAINT PK_student_course PRIMARY KEY (StudentID, CourseID);
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