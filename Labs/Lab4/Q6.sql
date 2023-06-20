/*
** 6.
** Indicates where the project named ProjectA is currently working.
** Required information: code, name of working position.
*/

USE FUH_COMPANY
GO

-- Step 1: Declare a variable.
Declare @LocNum VARCHAR(50);

-- Step 2: Find locNum of staff named Mai Duy An and assign to @LocNum.
SELECT @LocNum = locNum
FROM tblProject
WHERE proName = N'ProjectA'

-- Step 3: Find locNum and locName by @LocNum.
SELECT locNum AS 'Code', locName AS 'Working position'
FROM tblLocation
WHERE locNum = @LocNum;