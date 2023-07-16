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
CREATE TRIGGER CheckCustomerOnInsert
ON Customer
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1
			   FROM Inserted
               WHERE Customer_Phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR Point < 0)
    BEGIN
        PRINT ('Phone number must have 10 digits, not contain letters and Point > 0');
        ROLLBACK TRANSACTION;
    END
END;


-- STEP 12: Trigger for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...



-- STEP 13: Trigger for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...
CREATE TRIGGER CheckProductOnInsert
ON Product
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1
			   FROM Inserted
               WHERE Product_ID NOT LIKE 'PD[0-9][0-9][0-9]' OR Price <= 0)
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END;


-- STEP 14: Trigger for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...
CREATE TRIGGER CheckVoucherOnInsert
ON Voucher
FOR INSERT
AS
BEGIN
	IF EXISTS (SELECT 1
			   FROM Inserted
               WHERE Voucher_ID NOT LIKE 'VC[0-9][0-9][0-9]'
					OR (Begin_Date >= End_Date)
					OR Minimum_Price < 0
					OR Discount <= 0)
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END


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
INSERT INTO Customer
VALUES ('0987654321',N'Đinh Quốc Chương',123),
       ('0123456789',N'Lê Minh Vương',456),
	   ('0918273645',N'Nguyễn Thị Thúy',789),
	   ('0864291735',N'Hồ Trọng Nghĩa',161),
	   ('0946132857',N'Trịnh Mình Dương',562);


-- STEP 18: Insert data for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...



-- STEP 19: Insert data for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...
INSERT INTO Product
VALUES ('PD001', N'Bánh ít lá gai', 5000),
       ('PD002', N'Bánh gấu', 12000),
	   ('PD003', N'Bánh mì', 3000),
	   ('PD004', N'Bánh kem', 100000),
	   ('PD005', N'Bánh mì nhân thịt', 10000);


-- STEP 20: Insert data for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...
INSERT INTO Voucher 
(Voucher_ID, Voucher_Description, Discount, Minimum_Price, Begin_Date, End_Date, Is_Require_Member)
VALUES
('VC001',	 '',	10,		200000	,	'2023-7-1' ,	'2023-7-10',	0),
('VC002',	 '',	15,		300000	,	'2023-7-1' ,	'2023-7-15',	1),
('VC003',	 '',	20,		400000	,	'2023-7-1' ,	'2023-7-20',	1),
('VC004',	 '',	10,		200000	,	'2023-7-1' ,	'2023-7-25',	1),
('VC005',	 '',	5 ,		100000	,	'2023-7-1' ,	'2023-7-30',	1),
('VC006',	 '',	15,		300000	,	'2023-7-5' ,	'2023-7-20',	1),
('VC007',	 '',	10,		200000	,	'2023-7-10',	'2023-7-30',	1),
('VC008',	 '',	25,		500000	,	'2023-7-15',	'2023-7-20',	1),
('VC009',	 '',	30,		1000000	,	'2023-7-20',	'2023-7-30',	1),
('VC010',	 '',	10,		200000	,	'2023-7-5' ,	'2023-8-5' ,	1);
GO

-- STEP 15: Insert data for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...



-- STEP 16: Insert data for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...