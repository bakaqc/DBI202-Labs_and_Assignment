USE FUH_COMPANY

GO 
/*
Show bảng Project

SELECT *
FROM tblProject

Show bảng Department

SELECT *
FROM tblDepartment
*/

/* Đáp án Câu 3 */
SELECT depName, proNum, proName
FROM  tblProject p join tblDepartment d ON p.depNum = d.depNum
WHERE proName = 'ProjectB';