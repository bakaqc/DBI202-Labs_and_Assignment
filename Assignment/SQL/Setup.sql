--------------------------------------------------------
--                                                    --
-- Create a database, tables and insert data for them --
--                                                    --
--------------------------------------------------------


-- STEP 1: Create a PASTRY_SHOP database
IF DB_ID('PASTRY_SHOP') IS NULL
BEGIN
    CREATE DATABASE PASTRY_SHOP;
    PRINT 'PASTRY_SHOP database created successfully.';
END
GO


-- STEP 2: Use PASTRY_SHOP database
USE PASTRY_SHOP
GO


-- STEP 3: Create Customer table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Customer')
BEGIN
    CREATE TABLE Customer (
        Customer_Phone	VARCHAR(10)		NOT NULL,
        Customer_Name	NVARCHAR(50)	NOT NULL,
        Point			INT				NOT NULL,

		PRIMARY KEY(Customer_Phone)
    );
    PRINT 'Customer table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Customer table already exists.';
END
GO


-- STEP 4: Create Employee table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Employee')
BEGIN
	CREATE TABLE Employee (
		Employee_ID			VARCHAR(8)		NOT NULL,
		Employee_Name		NVARCHAR(50)	NOT NULL,
		Employee_Phone		VARCHAR(10)		NOT NULL,
		Employee_Address	NVARCHAR(100),

		PRIMARY KEY(Employee_ID)
	);
	PRINT 'Employee table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Employee table already exists.';
END
GO


-- STEP 5: Create Product table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Product')
BEGIN
    CREATE TABLE Product (
        Product_ID		VARCHAR(5)		NOT NULL,
        Product_Name	NVARCHAR(100)	NOT NULL,
        Price			INT				NOT NULL,

		PRIMARY KEY(Product_ID)
    );
    PRINT 'Product table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Product table already exists.';
END
GO


-- STEP 6: Create Voucher table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Voucher')
BEGIN
	CREATE TABLE Voucher
	(
		Voucher_ID			VARCHAR(5)			NOT NULL, 
		Voucher_Description NVARCHAR(200),
		Discount			INT					NOT NULL,
		Minimum_Price		INT					NOT NULL,
		Begin_Date			DATE				NOT NULL,
		End_Date			DATE				NOT NULL,
		Is_Require_Member	BIT					NOT NULL,

		PRIMARY KEY (Voucher_ID)
	);
    PRINT 'Voucher table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Voucher table already exists.';
END
GO


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
GO


-- STEP 8: Create Bill_Data table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bill_Data')
BEGIN
	CREATE TABLE Bill_Data (
		Bill_ID			VARCHAR(10)		NOT NULL,
		Product_ID		VARCHAR(5)		NOT NULL,
		Product_Amount	INT				NOT NULL,

		PRIMARY KEY(Bill_ID, Product_ID)
	);
    PRINT 'Bill_Data table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Bill_Data table already exists.';
END
GO


-- STEP 9: Create foreign keys for Bill table
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bill')
BEGIN
	ALTER TABLE Bill
	ADD CONSTRAINT FK_Employee_ID
	FOREIGN KEY (Employee_ID)
	REFERENCES Employee (Employee_ID);

	PRINT 'Create foreign key Employee_ID for Bill table.';
	
	--
	
	ALTER TABLE Bill
	ADD CONSTRAINT FK_Voucher_ID
	FOREIGN KEY (Voucher_ID)
	REFERENCES Voucher (Voucher_ID);

	PRINT 'Create foreign key Voucher_ID for Bill table.';
	
	--
	
	ALTER TABLE Bill
	ADD CONSTRAINT FK_Customer_Phone
	FOREIGN KEY (Customer_Phone)
	REFERENCES Customer (Customer_Phone);
	
	PRINT 'Create foreign key Customer_Phone for Bill table.';
END
GO


-- STEP 10: Create foreign keys for Bill_Data table
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bill_Data')
BEGIN
	ALTER TABLE Bill_Data
	ADD CONSTRAINT FK_Bill_ID
	FOREIGN KEY (Bill_ID)
	REFERENCES Bill (Bill_ID);
	
	PRINT 'Create foreign key Bill_ID for Bill_Data table.';
	
	--
	
	ALTER TABLE Bill_Data
	ADD CONSTRAINT FK_Product_ID
	FOREIGN KEY (Product_ID)
	REFERENCES Product (Product_ID);
	
	PRINT 'Create foreign key Voucher_ID for Bill_Data table.';
END
GO