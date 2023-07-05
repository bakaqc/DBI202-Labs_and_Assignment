
/*
1. 
- Please indicate who is managing the department named: Research and Development Department. 
- Required information: code, employee name, department number, department name 
*/

USE FUH_COMPANY
GO 

SELECT *
FROM tblDepartment; 

SELECT *
FROM tblEmployee; 

SELECT empSSN,empName,d.depNum, depName
FROM tblDepartment d JOIN tblEmployee e ON d.mgrSSN = e.empSSN
WHERE depName = N'Phòng Nghiên cứu và phát triển'