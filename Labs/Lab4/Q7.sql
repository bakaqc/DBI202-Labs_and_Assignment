USE FUH_COMPANY

GO 

/*
SELECT *
FROM tblProject

SELECT *
FROM tblLocation
*/

SELECT proNum, proName
FROM tblProject
WHERE locNum = (SELECT locNum
				FROM tblLocation
				WHERE locName = N'TP Hồ Chí Minh')