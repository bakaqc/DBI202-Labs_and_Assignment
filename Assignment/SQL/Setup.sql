--------------------------------------------------------
--                                                    --
-- Create a database, tables and insert data for them --
--                                                    --
--------------------------------------------------------


-- STEP 1: Create a PASTRY_SHOP database
--IF DB_ID('PASTRY_SHOP') IS NULL
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PASTRY_SHOP')
BEGIN
    CREATE DATABASE PASTRY_SHOP;
    PRINT 'PASTRY_SHOP database created successfully.';
END



-- STEP 2: Use PASTRY_SHOP database
USE PASTRY_SHOP
GO


-- STEP 3: Create Customer table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Customer')
BEGIN
    CREATE TABLE Customer (
        Customer_Phone VARCHAR(20) PRIMARY KEY,
        Customer_Name NVARCHAR(100),
        Point INT
    );
    PRINT 'Customer table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Customer table already exists.';
END


-- STEP 4: Create Employee table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Employee')
BEGIN
    PRINT 'Employee table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Employee table already exists.';
END


-- STEP 5: Create Product table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Product')
BEGIN
    PRINT 'Product table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Product table already exists.';
END


-- STEP 6: Create Voucher table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Voucher')
BEGIN
	CREATE TABLE Voucher
	(
		Voucher_ID VARCHAR(5) PRIMARY KEY, 
		Voucher_Description NVARCHAR(200) NOT NULL,
		Discount INT,
		Minimum_Price INT,
		Begin_Date DATE,
		End_Date DATE,
		Is_Require_Member BIT
	);
    PRINT 'Voucher table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Voucher table already exists.';
END


-- STEP 7: Create Bill table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bill')
BEGIN
	CREATE TABLE Bill (
		Bill_ID			VARCHAR(10)	NOT NULL,

		Create_Date		DATE		NOT NULL,
		Create_Time		TIME		NOT NULL,

		Payment_Date	DATE		NOT NULL,
		Payment_Time	DATE		NOT NULL,

		Primary_Price	INT			NOT NULL,
		Used_Point		INT			NOT NULL,
		Final_Price		INT			NOT NULL,
		Earned_Point	INT			NOT NULL,

		Given_Money		INT			NOT NULL,
		Excess_Money	INT			NOT NULL,

		Employee_ID		VARCHAR(8)	NOT NULL,
		Voucher_ID		VARCHAR(5),
		Customer_Phone	VARCHAR(10),

		PRIMARY KEY(Bill_ID)
	);

    PRINT 'Bill table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Bill table already exists.';
END


-- STEP 8: Create Bill_Data table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bill_Data')
BEGIN
    PRINT 'Bill_Data table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Bill_Data table already exists.';
END