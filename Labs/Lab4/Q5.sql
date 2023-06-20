/*
** 5.
** Please show who currently supervises staff named Mai Duy An.
** Required information: employee number, and the full name of the supervisor.
*/

USE FUH_COMPANY
GO

-- Step 1: Declare a variable.
Declare @SupervisorSSN VARCHAR(50);

-- Step 2: Find supervisorSSN of staff named Mai Duy An and assign to @SupervisorSSN.
SELECT @SupervisorSSN = supervisorSSN
FROM tblEmployee
WHERE empName = N'Mai Duy An'

-- Step 3: Find empSSN and empName by @SupervisorSSN.
SELECT empSSN AS 'Employee SSN', empName AS 'Employee Name'
FROM tblEmployee
WHERE empSSN = @SupervisorSSN;