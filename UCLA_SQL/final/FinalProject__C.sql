DROP DATABASE IF EXISTS schooldb;

CREATE Database schooldb
GO

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
    ContactID CHAR(10),--FK
    ContactTypeID INT IDENTITY(1, 1) NOT NULL,
    ContactType VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactTypeID),
);
GO

DROP TABLE IF EXISTS CourseList;
GO

CREATE TABLE CourseList(
    StudentCourseID CHAR(10),--FK
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
    EmployeeID CHAR(10),--FK
    EmpJobPositionID INT IDENTITY(1, 1) NOT NULL,
    EmpJobPosition VARCHAR(50),
    PRIMARY KEY (EmpJobPositionID),
);
GO

DROP TABLE IF EXISTS Employees;
GO

CREATE TABLE Employees(
    ContactID CHAR(10),--FK
    EmployeeID INT IDENTITY(1000, 1) NOT NULL,
    EmployeeName VARCHAR(50) NOT NULL,
    EmpJobPositionID INT NOT NULL,
    EmployeePassword VARCHAR(50),
    Access BIT NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmpJobPositionID) REFERENCES EmpJobPosition(EmpJobPositionID)
);
GO

DROP TABLE IF EXISTS StudentContacts;
GO

CREATE TABLE StudentContacts(
    ContactID INT IDENTITY(10000, 1) NOT NULL,
    StudentID INT NOT NULL,
    ContactTypeID INT NOT NULL,
    ContactDate DATE NOT NULL,
    EmployeeID INT NOT NULL,
    ContactDetails VARCHAR(50) NOT NULL,
    PRIMARY KEY (ContactID),
    FOREIGN KEY (ContactTypeID) REFERENCES ContactType(ContactTypeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID)
);
GO

DROP TABLE IF EXISTS student_course;
GO

CREATE TABLE student_course (
    StudentCourseID INT IDENTITY(1, 1) NOT NULL,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    CourseStartDate DATE NOT NULL,
    CourseComplete BIT,
    PRIMARY KEY (StudentCourseID),
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID),
    FOREIGN KEY (CourseID) REFERENCES CourseList(CourseID)
);
GO

PRINT 'Part C Completed'