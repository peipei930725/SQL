/********************************************
General tips for getting the highest score

Ensure the entire script can run from beginning to end without errors. If you cannot fully implement a PART or some statements, add what works correctly, and add comments to describe the issue. If you can't get a statement to process correctly, comment it out and add comments to explain the issue.

Again, the entire script needs to run without errors.

Every time a CREATE (Table, Index, Database, Stored Procedure, Trigger) is used ensure it has a corresponding DROP IF EXISTS that precedes it. This allows the script to be run over and over getting in an inconsistent state (e.g. remanent objects)

See the CREATE database section below as an example for a CREATE DATABASE statement, you'll need to do this for EVERY object  (Table, Index, Database, Stored Procedure, Trigger) you create.


For many batch statements, you'll need to use a GO as a separator, which resets the transaction block,otherwise you'll get an error.

As an example, make sure your DROP statements that preceed a CREATE of the same object have a GO in between

DROP statement <OBJECTA>
--followed by a
GO
--followed by a
CREATE statement <OBJECTA>

Without the GO, you'll get a Error like .....CREATE ....' must be the first statement in a query batch

Also, while not absolute, the same type of error CAN happen after a CREATE statement followed directly by a corresponding SELECT statement of the same object. (e.g. Create VIEW followed by a GO, then by a SELECT from the VIEW).

To be safe in this project, follow this pattern when you have the two statements back to back.
CREATE statement <OBJECTA>
--followed by a
GO
--followed by a
SELECT statement <OBJECTA>



********************************************/



/********************************************
PART A

CREATE DATABASE

To house the project, create a database : schooldb, so the script can be run over and over, use :

DROP DATABASE IF EXISTS schooldb statement before the  CREATE statement.

Don’t forget to specify USE schooldb once the db is created.
********************************************/
USE Master;
GO
DROP DATABASE IF EXISTS schooldb;
GO
CREATE DATABASE schooldb;
GO
USE schooldb;
PRINT 'Part A Completed'


-- ****************************
-- PART B
-- ****************************
-- Write statements below 

GO

CREATE PROCEDURE usp_dropTables
AS
BEGIN
    DROP TABLE IF EXISTS EmpJobPosition;
    DROP TABLE IF EXISTS Employees;
    DROP TABLE IF EXISTS StudentInformation;
    DROP TABLE IF EXISTS CourseList;
    DROP TABLE IF EXISTS Student_Courses;
    DROP TABLE IF EXISTS ContactType;
    DROP TABLE IF EXISTS StudentContacts;
END;

GO

EXEC usp_dropTables;

PRINT 'Part B Completed'

-- ****************************
-- PART C
-- ****************************
-- Write statements below 

USE schooldb;
GO

DROP TABLE IF EXISTS StudentInformation;
GO

CREATE TABLE StudentInformation(
    StudentCourseID CHAR(10),--FK
    ContactID CHAR(10),--FK
    StudentID INT IDENTITY(100, 1) NOT NULL,
    Title VARCHAR(50),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address1 VARCHAR(50),
    Address2 VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50),
    Zip CHAR(10),
    Telephone CHAR(10),
    Email VARCHAR(50),
    Enrolled BIT,
    AltTelephone CHAR(10),
    PRIMARY KEY (StudentID),
);
GO

DROP TABLE IF EXISTS ContactType;
GO

CREATE TABLE ContactType(
    ContactID CHAR(10),
    ContactTypeID INT IDENTITY(1, 1) NOT NULL,
    ContactType VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactTypeID)
);
GO

DROP TABLE IF EXISTS CourseList;
GO

CREATE TABLE CourseList(
    StudentCourseID CHAR(10),
    CourseID INT IDENTITY(10, 1) NOT NULL,
    CourseDescription VARCHAR(50) NOT NULL,
    CourseCost DECIMAL(10,2),
    CourseDurationYears INT,
    Notes VARCHAR(50),
    PRIMARY KEY (CourseID)
);
GO

DROP TABLE IF EXISTS EmpJobPosition;
GO

CREATE TABLE EmpJobPosition(
    EmpJobPositionID INT IDENTITY(1, 1) NOT NULL,
    EmployeePosition VARCHAR(50),
    PRIMARY KEY (EmpJobPositionID)
);
GO

DROP TABLE IF EXISTS Employees;
GO

CREATE TABLE Employees(
    EmployeeID INT IDENTITY(1000, 1) NOT NULL,
    EmpJobPositionID INT,--FK
    EmployeeName VARCHAR(50) NOT NULL,
    EmployeePositionID INT NOT NULL,
    EmployeePassword VARCHAR(50),
    Access BIT,
    PRIMARY KEY (EmployeeID)
);
GO

DROP TABLE IF EXISTS StudentContacts;
GO

CREATE TABLE StudentContacts(
    ContactID INT IDENTITY(10000, 1) NOT NULL,
    StudentID INT NOT NULL,--FK
    ContactTypeID INT NOT NULL,--FK
    EmployeeID INT NOT NULL,--FK
    ContactDate DATE NOT NULL,
    ContactDetails VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactID),
    FOREIGN KEY (ContactTypeID) REFERENCES ContactType(ContactTypeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID)
);
GO

DROP TABLE IF EXISTS Student_Courses;
GO

CREATE TABLE Student_Courses (
    StudentCourseID INT IDENTITY(1, 1) NOT NULL,
    StudentID INT NOT NULL,--FK
    CourseID INT NOT NULL,--FK
    CourseStartDate DATE NOT NULL,
    CourseComplete BIT,
    PRIMARY KEY (StudentCourseID),
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID),
    FOREIGN KEY (CourseID) REFERENCES CourseList(CourseID)
);
GO

PRINT 'Part C Completed'

-- ****************************
-- PART D
-- ****************************
-- Write statements below 

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

-- ****************************
-- PART E
-- ****************************
-- Write statements below 
GO
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

-- ****************************
-- Part F
-- DATA Population
-- If the table structures have been created correct, these data population statements  will run without issue
-- ****************************
INSERT INTO StudentInformation
   (FirstName,LastName)
VALUES
   ('Mickey', 'Mouse');

INSERT INTO StudentInformation
   (FirstName,LastName)
VALUES
   ('Minnie', 'Mouse');

INSERT INTO StudentInformation
   (FirstName,LastName)
VALUES
   ('Donald', 'Duck');
SELECT * FROM StudentInformation;

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Advanced Math');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Intermediate Math');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Beginning Computer Science');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Advanced Computer Science');
select * from CourseList;

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (100, 10, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (101, 11, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (102, 11, '01/05/2018');
INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (100, 11, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (102, 13, '01/05/2018');
select * from Student_Courses;

INSERT INTO EmpJobPosition
   (EmployeePosition)
VALUES
   ('Math Instructor');

INSERT INTO EmpJobPosition
   (EmployeePosition)
VALUES
   ('Computer Science');
select * from EmpJobPosition

INSERT INTO Employees
   (EmployeeName,EmployeePositionID)
VALUES
   ('Walt Disney', 1);

INSERT INTO Employees
   (EmployeeName,EmployeePositionID)
VALUES
   ('John Lasseter', 2);

INSERT INTO Employees
   (EmployeeName,EmployeePositionID)
VALUES
   ('Danny Hillis', 2);
select * from Employees;

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Tutor');

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Homework Support');

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Conference');
SELECT * from ContactType;

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (100, 1, 1000, '11/15/2017', 'Micky and Walt Math Tutoring');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (101, 2, 1001, '11/18/2017', 'Minnie and John Homework support');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (100, 3, 1001, '11/18/2017', 'Micky and Walt Conference');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (102, 2, 1002, '11/20/2017', 'Donald and Danny Homework support');

SELECT * from StudentContacts;

-- Note for Part E, use these two inserts as examples to test the trigger
-- They will also be needed if you’re using the examples for Part G
INSERT INTO StudentInformation
   (FirstName,LastName,Email)
VALUES
   ('Porky', 'Pig', 'porky.pig@warnerbros.com');
INSERT INTO StudentInformation
   (FirstName,LastName)
VALUES
   ('Snow', 'White');

PRINT 'Part F Completed'

-- ****************************
-- PART G
-- ****************************
-- Write statements below 

GO

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

    INSERT INTO StudentContacts (StudentID, ContactTypeID, EmployeeID, ContactDate, ContactDetails)
    VALUES (
        (SELECT StudentID FROM StudentInformation WHERE Email = @StudentEmail),
        @ContactTypeID,
        (SELECT EmployeeID FROM Employees WHERE EmployeeName = @EmployeeName),
        GETDATE(),
        @ContactDetails
    );
END;
GO

-- EXEC usp_addQuickContacts 'minnie.mouse@disney.com','John Lasseter','Minnie getting Homework Support from John','Homework Support' 
-- EXEC usp_addQuickContacts 'porky.pig@warnerbros.com','John Lasseter','Porky studying with John for Test prep','Test Prep'

PRINT 'Part G Completed'

-- ****************************
-- PART H
-- ****************************
-- Write statements below 

GO

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

-- ****************************
-- Part I
-- ****************************
-- Write statements below 

GO
--employeeName, StudentName, ContactDetails, and ContactDate
CREATE VIEW vtutorContacts AS
SELECT E.EmployeeName, 
    RTRIM(S.FirstName) + ' ' + RTRIM(S.LastName) AS StudentName, 
    SC.ContactDetails, 
    SC.ContactDate
FROM StudentContacts SC
JOIN StudentInformation S ON SC.StudentID = S.StudentID
JOIN Employees E ON SC.EmployeeID = E.EmployeeID
JOIN ContactType CT ON SC.ContactTypeID = CT.ContactTypeID
WHERE CT.ContactType = 'Tutor';

GO

PRINT 'Part I Completed'




