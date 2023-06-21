/*
** 6.
** Indicates where the project named ProjectA is currently working.
** Required information: code, name of working position.
*/

USE FUH_COMPANY
GO

SELECT locNum AS 'Code', locName AS 'Working position'
FROM tblLocation
WHERE locNum = (
	SELECT locNum
	FROM tblProject
	WHERE proName = N'ProjectA'
);