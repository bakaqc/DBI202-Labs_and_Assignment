
/*
2. 
- For the department with the name: Research and Development Department, which projects are managed 
by this department currently?
- Required information: project number, project name, name of management department 
*/

USE FUH_COMPANY
GO

SELECT *
FROM tblDepartment

SELECT *
FROM tblProject

SELECT proNum, proName, depName
FROM tblDepartment d JOIN tblProject p ON d.depNum = p.depNum
WHERE depName = N'Phòng nghiên cứu và phát triển'
