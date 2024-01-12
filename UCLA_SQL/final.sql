CREATE Database School

DROP TABLE IF EXISTS StudentContacts;
GO

CREATE TABLE StudentContacts(
    ContactID CHAR(10) NOT NULL,
    StudentID CHAR(10) NOT NULL,
    ContactTypeID CHAR(10) NOT NULL,
    ContactDate DATE NOT NULL,
    EmployeeID CHAR(10) NOT NULL,
    ContactDetails VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactID)
);

CREATE TABLE student_course (
    StudentCourseID CHAR(10) NOT NULL,
    StudentID CHAR(10) NOT NULL,
    CourseID CHAR(10) NOT NULL,
    CourseStartDate DATE NOT NULL,
    CourseComplete BOOLEAN NOT NULL,
    PRIMARY KEY (StudentCourseID)
);

CREATE TABLE ContactType(
    ContactTypeID CHAR(10) NOT NULL,
    ContactType VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactTypeID)
);

CREATE TABLE CourseList(
    StudentCourseID CHAR(10) NOT NULL,--FK
    CourseID CHAR(10) NOT NULL,
    CourseDescription VARCHAR(50) NOT NULL,
    CourseCost DECIMAL(10,2) NOT NULL,
    CourseDurationYears INT NOT NULL,
    Notes VARCHAR(50) NOT NULL,
    PRIMARY KEY (CourseID),
    FOREIGN KEY (StudentCourseID) REFERENCES student_course(StudentCourseID)
);

CREATE TABLE StudentInformation(
    StudentCourseID CHAR(10) NOT NULL,--FK
    ContactID CHAR(10) NOT NULL,--FK
    StudentID CHAR(10) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address1 VARCHAR(50) NOT NULL,
    Address2 VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Zip CHAR(10) NOT NULL,
    Telephone CHAR(10) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Enrolled BOOLEAN NOT NULL,
    AltTelephone CHAR(10) NOT NULL,
    PRIMARY KEY (StudentID),
    FOREIGN KEY (StudentCourseID) REFERENCES student_course(StudentCourseID),
    FOREIGN KEY (ContactID) REFERENCES StudentContacts(ContactID)
);

CREATE TABLE Employees(
    ContactID CHAR(10) NOT NULL,--FK
    EmployeeID CHAR(10) NOT NULL,
    EmployeeName VARCHAR(50) NOT NULL,
    EmpJobPositionID CHAR(10) NOT NULL,
    EmployeePassword VARCHAR(50) NOT NULL,
    Access BOOLEAN NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (ContactID) REFERENCES StudentContacts(ContactID)
);

CREATE TABLE EmpJobPosition(
    EmployeeID CHAR(10) NOT NULL,--FK
    EmpJobPositionID CHAR(10) NOT NULL,
    EmpJobPosition VARCHAR(50) NOT NULL,
    PRIMARY KEY (EmpJobPositionID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

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