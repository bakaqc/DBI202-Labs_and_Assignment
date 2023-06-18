USE FUH_COMPANY

GO 

/*
Show bảng Employee

SELECT *
FROM tblEmployee
*/

/* Đáp án Câu 4 */
SELECT empSSN, empName
FROM tblEmployee
WHERE supervisorSSN = (SELECT empSSN
					   FROM tblEmployee
					   WHERE empName = 'Mai Duy An');