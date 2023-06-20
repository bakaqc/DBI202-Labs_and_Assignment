/*
7. 
- Indicate the working position named: Tp. Ho Chi Minh City is currently the working
place of which projects. 
- Required information: code, project name
*/

USE FUH_COMPANY
GO 

/*
SELECT *
FROM tblProject

SELECT *
FROM tblLocation
*/

SELECT proNum AS 'Code', proName
FROM tblProject
WHERE locNum = (SELECT locNum
				FROM tblLocation
				WHERE locName = N'TP Hồ Chí Minh')