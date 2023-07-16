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
	
	Payment_Date		DATE,
	Payment_Time		TIME,
	
	Primary_Price		INT,
	Used_Point			INT,
	Final_Price			INT,
	Earned_Point		INT,
	
	Given_Money			INT,
	Excess_Money		INT,
	
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
               WHERE Customer_Phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			   OR Point < 0
			   )
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END
Go


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
    IF EXISTS (	SELECT 1
				FROM Inserted
        		WHERE Product_ID NOT LIKE 'PD[0-9][0-9][0-9]'
					OR Price <= 0
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END
GO


-- STEP 14: Trigger for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...
CREATE TRIGGER CheckVoucherOnInsert
ON Voucher
FOR INSERT
AS
BEGIN
	IF EXISTS (	SELECT 1
			   	FROM Inserted
               	WHERE Voucher_ID NOT LIKE 'VC[0-9][0-9][0-9]'
					OR (Begin_Date >= End_Date)
					OR Minimum_Price < 0
					OR Discount <= 0
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END
GO


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
INSERT INTO Customer (Customer_Phone, Customer_Name, Point)
VALUES
('0934567890',	N'Nguyễn Thị Hương',	8),
('0978012345',	N'Lê Văn Tuấn',			7),
('0912345678',	N'Trần Thị Lan Anh',	9),
('0987654321',	N'Phạm Minh Đức',		23),
('0905123456',	N'Hoàng Thị Thu Hà',	67),
('0967890123',	N'Vũ Minh Hưng',		98),
('0943210987',	N'Đặng Thanh Trúc',		34),
('0923456789',	N'Bùi Xuân Nam',		3),
('0956789012',	N'Ngô Thị Hồng Nhung',	4),
('0987654321',	N'Đỗ Quang Trung',		127);


-- STEP 18: Insert data for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...



-- STEP 19: Insert data for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...
INSERT INTO Product (Product_ID, Product_Name, Price)
VALUES
('PD001',	N'Bánh macaron',				25000),
('PD002',	N'Bánh tiramisu',				35000),
('PD003',	N'Bánh mousse socola',			30000),
('PD004',	N'Bánh red velvet',				40000),
('PD005',	N'Bánh cupcake',				20000),
('PD006',	N'Bánh bông lan trứng muối',	15000),
('PD007',	N'Bánh cheesecake',				50000),
('PD008',	N'Bánh tart trái cây',			45000),
('PD009',	N'Bánh cookie socola',			10000),
('PD010',	N'Bánh hạnh nhân caramel',		10000);


-- STEP 20: Insert data for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...
INSERT INTO Voucher (Voucher_ID, Voucher_Description, Discount, Minimum_Price, Begin_Date, End_Date, Is_Require_Member)
VALUES
('VC001',	N'Mừng ngày khai trương, giảm 5% cho hóa đơn từ 0 đồng',	5,	0,		'2023-06-01',	'2023-06-10',	0),
('VC002',	N'Mừng ngày khai trương, giảm 10% cho hóa đơn từ 0 đồng',	10,	0,		'2023-06-01',	'2023-06-10',	1),
('VC003',	N'Mừng hè, giảm 10% cho hóa đơn từ 100000 đồng',			10,	100000,	'2023-06-11',	'2023-08-32',	1),
('VC004',	N'Mừng hè, giảm 15% cho hóa đơn từ 200000 đồng',			15,	200000,	'2023-06-11',	'2023-08-32',	1),
('VC005',	N'Mừng hè, giảm 20% cho hóa đơn từ 500000 đồng',			20,	500000,	'2023-06-11',	'2023-08-32',	1),
GO

-- STEP 15: Insert data for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...



-- STEP 16: Insert data for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...