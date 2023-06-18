USE FUH_COMPANY
GO 

/*
SELECT *
FROM tblDependent
GO
SELECT *
FROM tblEmployee
GO
*/

SELECT depName, depBirthdate, empName
FROM tblDependent d join tblEmployee e ON d.empSSN = e.empSSN
WHERE  1990 /*năm tự chọn*/ - year(depBirthdate) > 18
GO
