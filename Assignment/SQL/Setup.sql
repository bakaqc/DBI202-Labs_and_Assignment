--------------------------------------------------------
--                                                    --
-- Create a database, tables and insert data for them --
--                                                    --
--------------------------------------------------------


-- STEP 1: Create a PASTRY_SHOP database
CREATE DATABASE PASTRY_SHOP;
GO


-- STEP 2: Use PASTRY_SHOP database
USE PASTRY_SHOP
GO


-- STEP 3: Create Customer table
CREATE TABLE Customer
(
	Customer_Phone	VARCHAR(10)		NOT NULL,
	Customer_Name	NVARCHAR(50)	NOT NULL,
	Point			INT				NOT NULL,
	
	PRIMARY KEY (Customer_Phone)
);
GO


-- STEP 4: Create Employee table
CREATE TABLE Employee
(
	Employee_ID			VARCHAR(8)		NOT NULL,
	Employee_Name		NVARCHAR(50)	NOT NULL,
	Employee_Phone		VARCHAR(10)		NOT NULL,
	Employee_Address	NVARCHAR(100),
	
	PRIMARY KEY (Employee_ID)
);
GO


-- STEP 5: Create Product table
CREATE TABLE Product
(
	Product_ID		VARCHAR(5)		NOT NULL,
	Product_Name	NVARCHAR(100)	NOT NULL,
	Price			INT				NOT NULL,
	
	PRIMARY KEY (Product_ID)
);
GO


-- STEP 6: Create Voucher table
CREATE TABLE Voucher
(
	Voucher_ID				VARCHAR(5)		NOT NULL,
	Voucher_Description		NVARCHAR(200),
	Discount				INT				NOT NULL,
	Minimum_Price			INT				NOT NULL,
	Begin_Date				DATE			NOT NULL,
	End_Date				DATE			NOT NULL,
	Is_Require_Member		BIT				NOT NULL,
	
	PRIMARY KEY (Voucher_ID)
);
GO


-- STEP 7: Create Bill table
CREATE TABLE Bill
(
	Bill_ID				VARCHAR(10)		NOT NULL,
	
	Create_Date			DATE			NOT NULL,
	Create_Time			TIME			NOT NULL,
	
	Payment_Date		DATE			NOT NULL,
	Payment_Time		TIME			NOT NULL,
	
	Primary_Price		INT				NOT NULL,
	Used_Point			INT				NOT NULL,
	Final_Price			INT				NOT NULL,
	Earned_Point		INT				NOT NULL,
	
	Given_Money			INT				NOT NULL,
	Excess_Money		INT				NOT NULL,
	
	Employee_ID			VARCHAR(8)		NOT NULL,
	Voucher_ID			VARCHAR(5),
	Customer_Phone		VARCHAR(10),
	
	PRIMARY KEY (Bill_ID)
);
GO


-- STEP 8: Create Bill_Data table
CREATE TABLE Bill_Data
(
	Bill_ID			VARCHAR(10)		NOT NULL,
	Product_ID		VARCHAR(5)		NOT NULL,
	Product_Amount	INT				NOT NULL,
	
	PRIMARY KEY (Bill_ID, Product_ID)
);
GO


-- STEP 9: Create foreign keys for Bill table
ALTER TABLE Bill
ADD CONSTRAINT FK_Employee_ID
FOREIGN KEY (Employee_ID)
REFERENCES Employee (Employee_ID);
--
ALTER TABLE Bill
ADD CONSTRAINT FK_Voucher_ID
FOREIGN KEY (Voucher_ID)
REFERENCES Voucher (Voucher_ID);
--
ALTER TABLE Bill
ADD CONSTRAINT FK_Customer_Phone
FOREIGN KEY (Customer_Phone)
REFERENCES Customer (Customer_Phone);
GO


-- STEP 10: Create foreign keys for Bill_Data table
ALTER TABLE Bill_Data
ADD CONSTRAINT FK_Bill_ID
FOREIGN KEY (Bill_ID)
REFERENCES Bill (Bill_ID);
--
ALTER TABLE Bill_Data
ADD CONSTRAINT FK_Product_ID
FOREIGN KEY (Product_ID)
REFERENCES Product (Product_ID);
GO

-- STEP 11: Trigger for Customer table
-- Assign: Nghĩa
-- Format: SĐT 10 số
-- VD: 03xxxxxxxx



-- STEP 12: Trigger for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...



-- STEP 13: Trigger for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...



-- STEP 14: Trigger for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...



-- STEP 15: Trigger for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...



-- STEP 16: Trigger for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...



------------------------------------------------------------



-- STEP 17: Insert data for Customer table
-- Assign: Nghĩa
-- Format: SĐT 10 số
-- VD: 03xxxxxxxx



-- STEP 18: Insert data for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...



-- STEP 19: Insert data for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...



-- STEP 20: Insert data for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...



-- STEP 15: Insert data for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...



-- STEP 16: Insert data for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...