/*
3.
- What department is the project named ProjectB currently managed by?
- Required information: project number, project name, name of management
department
*/


USE FUH_COMPANY
GO 

-- Show table Project
SELECT *
FROM tblProject

-- Show table Department
SELECT *
FROM tblDepartment

/* 
STEP 1: Perform the natural join between the two tables Project and Department through depNum 
STEP 2: Select properties including proNum, proName, depName with the condition 
							proName = 'ProjectB'
*/

SELECT proNum, proName, depName
FROM  tblProject p join tblDepartment d ON p.depNum = d.depNum
WHERE proName = 'ProjectB';