/*
4.
- Display information of all employees who are supervised by an employee named
Mai Duy An
- Required information: employee number, employee's full name
*/


USE FUH_COMPANY
GO 

-- Show bảng Employee
SELECT *
FROM tblEmployee

/* 
STEP 1: Select empSSN of Mai Duy An
STEP 2: Select all employee have supervisorSSN is empSSN of Mai Duy An
STEP 3: Select empSSN and empName of all employee selected in STEP 2
*/

SELECT empSSN, empName
FROM tblEmployee
WHERE supervisorSSN = (SELECT empSSN
					   FROM tblEmployee
					   WHERE empName = N'Mai Duy An');