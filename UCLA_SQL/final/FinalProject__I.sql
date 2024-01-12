CREATE VIEW vtutorContacts AS
SELECT E.EmployeeName, 
    RTRIM(S.FirstName) + ' ' + RTRIM(S.LastName) AS StudentName, 
    SC.ContactDetails, 
    SC.ContactDate
FROM StudentContacts SC
JOIN StudentInformation S ON SC.StudentID = S.StudentID
JOIN Employee E ON SC.EmployeeID = E.EmployeeID
JOIN ContactType CT ON SC.ContactTypeID = CT.ContactTypeID
WHERE CT.TypeName = 'Tutor';