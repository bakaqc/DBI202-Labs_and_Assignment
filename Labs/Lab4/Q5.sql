/*
** 5.
** Please show who currently supervises staff named Mai Duy An.
** Required information: employee number, and the full name of the supervisor.
*/

USE FUH_COMPANY
GO

SELECT empSSN AS 'Employee SSN', empName AS 'Employee Name'
FROM tblEmployee
WHERE empSSN = (
	SELECT supervisorSSN
	FROM tblEmployee
	WHERE empName = N'Mai Duy An'
);