--------------------------------------------------------
--                                                    --
-- Create a database, tables and insert data for them --
--                                                    --
--------------------------------------------------------


-- STEP 1: Create a PASTRY_SHOP database
CREATE DATABASE PASTRY_SHOP
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
)
GO


-- STEP 4: Create Employee table
CREATE TABLE Employee
(
	Employee_ID			VARCHAR(8)		NOT NULL,
	Employee_Name		NVARCHAR(50)	NOT NULL,
	Employee_Phone		VARCHAR(10)		NOT NULL,
	Employee_Address	NVARCHAR(100),
	
	PRIMARY KEY (Employee_ID)
)
GO


-- STEP 5: Create Product table
CREATE TABLE Product
(
	Product_ID		VARCHAR(5)		NOT NULL,
	Product_Name	NVARCHAR(100)	NOT NULL,
	Price			INT				NOT NULL,
	
	PRIMARY KEY (Product_ID)
)
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
)
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
)
GO


-- STEP 8: Create Bill_Data table
CREATE TABLE Bill_Data
(
	Bill_ID			VARCHAR(10)		NOT NULL,
	Product_ID		VARCHAR(5)		NOT NULL,
	Product_Amount	INT				NOT NULL,
	
	PRIMARY KEY (Bill_ID, Product_ID)
)
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
    IF EXISTS (	SELECT 1
			   	FROM Inserted
               	WHERE Customer_Phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			   	OR Point < 0
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!')
        ROLLBACK TRANSACTION
    END
END
Go


-- STEP 12: Trigger for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...
CREATE TRIGGER CheckEmployeeOnInsert
ON Employee
FOR INSERT
AS
BEGIN
	-- Trong IF là các điều kiện kiểm tra các thuộc tính trong bảng
	IF EXISTS (	SELECT 1
			   	FROM Inserted
               	WHERE Employee_ID NOT LIKE 'EMPQN[0-9][0-9][0-9]'
			   		OR Employee_Phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END
GO


-- STEP 13: Trigger for Product table
-- Assign: Nghĩa
-- Format: PD001, PD002, PD003,...
CREATE TRIGGER CheckProductOnInsert
ON Product
FOR INSERT
AS
BEGIN
    IF EXISTS (	SELECT 1
				FROM Inserted
        		WHERE Product_ID NOT LIKE 'PD[0-9][0-9][0-9]'
					OR Price <= 0
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!')
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
        PRINT ('Error! Insertion canceled!')
        ROLLBACK TRANSACTION
    END
END
GO


-- STEP 15: Trigger for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...
CREATE TRIGGER CheckBillOnInsert
ON Bill
FOR INSERT
AS
BEGIN
	IF EXISTS (	SELECT 1
				FROM Inserted
				WHERE Bill_ID NOT LIKE 'BILL[0-9][0-9][0-9][0-9][0-9][0-9]'
					OR Employee_ID NOT LIKE 'EMPQN[0-9][0-9][0-9]'
					OR (Customer_Phone IS NOT NULL AND Customer_Phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
			  )
	BEGIN
		PRINT ('Error! Insertion canceled!')
		ROLLBACK TRANSACTION
	END
END
GO


-- STEP 16: Trigger for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...
CREATE TRIGGER CheckBill_DataOnInsert
ON Bill_Data
FOR INSERT
AS
BEGIN
	-- Trong IF là các điều kiện kiểm tra các thuộc tính trong bảng
	IF EXISTS (	SELECT 1
			   	FROM Inserted
               	WHERE Product_Amount <= 0
			  )
    BEGIN
        PRINT ('Error! Insertion canceled!');
        ROLLBACK TRANSACTION;
    END
END
GO

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
('0984321765',	N'Đỗ Quang Trung',		127)
GO


-- STEP 18: Insert data for Employee table
-- Assign: Thúy
-- Format: EMPQN001, EMPQN002, EMPQN003,...
INSERT INTO Employee (Employee_ID, Employee_Name, Employee_Phone, Employee_Address)
VALUES
('EMPQN001',	N'Đinh Quốc Chương',	'0376166640',	N'An Nhơn'),
('EMPQN002',	N'Lê Minh Vương',		'0367626640',	N'Tây Sơn'),
('EMPQN003',	N'Hồ Trọng Nghĩa',		'0307636664',	N'An Nhơn'),
('EMPQN004',	N'Nguyễn Thị Thúy',		'0376464660',	N'Tây Sơn')
GO


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
('PD010',	N'Bánh hạnh nhân caramel',		10000)
GO


-- STEP 20: Insert data for Voucher table
-- Assign: Chương
-- Format: VC001, VC002, VC003,...
INSERT INTO Voucher (Voucher_ID, Voucher_Description, Discount, Minimum_Price, Begin_Date, End_Date, Is_Require_Member)
VALUES
('VC001',	N'Mừng ngày khai trương, giảm 5% cho hóa đơn từ 0 đồng',	5,	0,		'2023-06-01',	'2023-06-10',	0),
('VC002',	N'Mừng ngày khai trương, giảm 10% cho hóa đơn từ 0 đồng',	10,	0,		'2023-06-01',	'2023-06-10',	1),
('VC003',	N'Mừng hè, giảm 10% cho hóa đơn từ 100000 đồng',			10,	100000,	'2023-06-11',	'2023-08-31',	1),
('VC004',	N'Mừng hè, giảm 15% cho hóa đơn từ 200000 đồng',			15,	200000,	'2023-06-11',	'2023-08-31',	1),
('VC005',	N'Mừng hè, giảm 20% cho hóa đơn từ 500000 đồng',			20,	500000,	'2023-06-11',	'2023-08-31',	1)
GO

-- STEP 15: Insert data for Bill table
-- Assign: Vương
-- Format: BILL000001, BILL000002, BILL000003,...
INSERT INTO Bill (Bill_ID, Create_Date, Create_Time, Employee_ID, Customer_Phone)
VALUES
('BILL000001', '2023-06-01', '08:10:10', 'EMPQN001', NULL),
('BILL000002', '2023-06-01', '10:00:03', 'EMPQN001', '0934567890'),
('BILL000003', '2023-06-08', '15:00:14', 'EMPQN002', '0923456789'),
('BILL000004', '2023-06-08', '15:17:00', 'EMPQN002', '0984321765'),
('BILL000005', '2023-06-11', '10:17:00', 'EMPQN003', NULL),
('BILL000006', '2023-06-11', '12:47:00', 'EMPQN004', '0912345678'),
('BILL000007', '2023-06-12', '13:45:00', 'EMPQN004', NULL),
('BILL000008', '2023-06-19', '11:54:00', 'EMPQN002', '0978012345'),
('BILL000009', '2023-07-01', '12:19:00', 'EMPQN001', '0978012345'),
('BILL000010', '2023-07-01', '08:02:00', 'EMPQN004', '0956789012'),
('BILL000011', '2023-07-02', '09:30:00', 'EMPQN003', '0943210987'),
('BILL000012', '2023-07-05', '14:20:00', 'EMPQN001', NULL),
('BILL000013', '2023-07-07', '16:45:00', 'EMPQN004', '0987654321'),
('BILL000014', '2023-07-10', '11:10:00', 'EMPQN002', '0905123456'),
('BILL000015', '2023-07-12', '18:30:00', 'EMPQN003', NULL),
('BILL000016', '2023-07-15', '10:05:00', 'EMPQN001', '0967890123'),
('BILL000017', '2023-07-15', '15:40:00', 'EMPQN004', '0978012345'),
('BILL000018', '2023-07-16', '13:20:00', 'EMPQN002', '0984321765'),
('BILL000019', '2023-07-16', '17:55:00', 'EMPQN001', NULL),
('BILL000020', '2023-07-16', '19:45:00', 'EMPQN003', '0912345678'),
('BILL000021', '2023-07-17', '09:15:00', 'EMPQN004', NULL),
('BILL000022', '2023-07-18', '12:30:00', 'EMPQN001', '0934567890'),
('BILL000023', '2023-07-19', '14:45:00', 'EMPQN003', '0923456789'),
('BILL000024', '2023-07-20', '16:20:00', 'EMPQN002', '0984321765'),
('BILL000025', '2023-07-21', '11:05:00', 'EMPQN004', NULL),
('BILL000026', '2023-07-22', '13:40:00', 'EMPQN001', '0912345678'),
('BILL000027', '2023-07-23', '15:25:00', 'EMPQN003', '0943210987'),
('BILL000028', '2023-07-24', '10:50:00', 'EMPQN002', '0956789012'),
('BILL000029', '2023-07-25', '17:15:00', 'EMPQN001', '0978012345'),
('BILL000030', '2023-07-26', '19:00:00', 'EMPQN004', NULL)
GO


-- STEP 16: Insert data for Bill_Data table
-- Assign: Thúy
-- Format:
-- - BILL000001, BILL000002, BILL000003,...
-- - PD001, PD002, PD003,...
INSERT INTO Bill_Data(Bill_ID, Product_ID, Product_Amount)
VALUES
('BILL000001', 'PD001', 10),
('BILL000001', 'PD002', 5),
('BILL000001', 'PD005', 3),
('BILL000002', 'PD001', 2),
('BILL000002', 'PD006', 10),
('BILL000003', 'PD003', 4),
('BILL000003', 'PD007', 6),
('BILL000003', 'PD004', 6),
('BILL000004', 'PD002', 8),
('BILL000004', 'PD009', 2),
('BILL000004', 'PD010', 12),
('BILL000005', 'PD004', 15),
('BILL000005', 'PD008', 7),
('BILL000005', 'PD003', 2),
('BILL000006', 'PD001', 3),
('BILL000006', 'PD003', 4),
('BILL000006', 'PD010', 4),
('BILL000007', 'PD003', 6),
('BILL000007', 'PD006', 8),
('BILL000007', 'PD007', 7),
('BILL000008', 'PD002', 12),
('BILL000008', 'PD007', 3),
('BILL000008', 'PD001', 3),
('BILL000008', 'PD004', 6),
('BILL000009', 'PD001', 5),
('BILL000009', 'PD008', 9),
('BILL000010', 'PD005', 2),
('BILL000010', 'PD010', 7),
('BILL000011', 'PD004', 6),
('BILL000011', 'PD009', 4),
('BILL000012', 'PD002', 9),
('BILL000012', 'PD006', 5),
('BILL000013', 'PD003', 7),
('BILL000013', 'PD008', 2),
('BILL000014', 'PD001', 6),
('BILL000014', 'PD009', 3),
('BILL000015', 'PD005', 4),
('BILL000015', 'PD010', 8),
('BILL000016', 'PD004', 10),
('BILL000016', 'PD006', 6),
('BILL000017', 'PD003', 3),
('BILL000017', 'PD007', 9),
('BILL000018', 'PD002', 7),
('BILL000018', 'PD008', 34),
('BILL000018', 'PD004', 2),
('BILL000018', 'PD009', 12),
('BILL000018', 'PD005', 3),
('BILL000018', 'PD010', 22),
('BILL000019', 'PD001', 8),
('BILL000019', 'PD010', 2),
('BILL000020', 'PD005', 6),
('BILL000020', 'PD009', 7),
('BILL000021', 'PD004', 12),
('BILL000021', 'PD007', 4),
('BILL000021', 'PD003', 8),
('BILL000022', 'PD002', 4),
('BILL000022', 'PD006', 9),
('BILL000023', 'PD003', 8),
('BILL000023', 'PD008', 3),
('BILL000024', 'PD001', 3),
('BILL000024', 'PD009', 5),
('BILL000025', 'PD005', 9),
('BILL000025', 'PD010', 6),
('BILL000026', 'PD004', 5),
('BILL000026', 'PD006', 8),
('BILL000027', 'PD003', 9),
('BILL000027', 'PD007', 3),
('BILL000028', 'PD002', 2),
('BILL000028', 'PD008', 7),
('BILL000029', 'PD001', 4),
('BILL000029', 'PD009', 6),
('BILL000029', 'PD002', 8),
('BILL000029', 'PD004', 12),
('BILL000030', 'PD008', 3),
('BILL000030', 'PD005', 7),
('BILL000030', 'PD010', 4)
GO


-- STEP 17: Create procedure for Customer table
CREATE PROCEDURE Update_Point_For_Customer(@Customer_Phone VARCHAR(10), @Used_Point INT, @Earned_Point INT)
AS
BEGIN
	DECLARE @Point INT = 0

	SELECT 	@Point = c.Point
	FROM	Customer c
	WHERE	c.Customer_Phone = @Customer_Phone

	SET @Point = @Point - @Used_Point + @Earned_Point

	UPDATE	Customer
	SET		Point = @Point
	WHERE	Customer_Phone = @Customer_Phone
END
GO


-- STEP 18: Create procedure for Bill table
CREATE PROCEDURE Calculate_Bill(@Bill_ID VARCHAR(10))
AS
BEGIN
	-- Declare variables
	DECLARE @Primary_Price	INT			= 0
	DECLARE @Used_Point		INT			= 0
	DECLARE @Customer_Phone	VARCHAR(10)	= NULL
	DECLARE @Create_Date	DATE		= NULL
	DECLARE @Voucher_ID		VARCHAR(5)	= NULL
	DECLARE @Discount		INT			= 0
	DECLARE @Final_Price	INT			= 0
	DECLARE @Earned_Point	INT			= 0


	-- Get @Primary_Price with @Bill_ID
	SELECT		@Primary_Price 	= SUM(db.Product_Amount * p.Price)
	FROM		Bill_Data db JOIN Product p ON db.Product_ID = p.Product_ID
	GROUP BY	db.Bill_ID
	HAVING		db.Bill_ID 		= @Bill_ID


	-- Get @Used_Point, @Customer_Phone, @Create_Date with @Bill_ID
	SELECT 		@Used_Point		= ISNULL(c.Point, 0),
				@Customer_Phone	= b.Customer_Phone,
				@Create_Date	= b.Create_Date

	FROM 		Bill b LEFT JOIN Customer c ON b.Customer_Phone = c.Customer_Phone
	WHERE 		b.Bill_ID 		= @Bill_ID

	IF @Used_Point > 50
		SET @Used_Point = 50
	

	-- Get @Voucher_ID, @Discount, @Create_Date available
	SELECT TOP 1
				@Voucher_ID = v.Voucher_ID,
				@Discount = v.Discount

	FROM Voucher v
	WHERE		(v.Begin_Date <= @Create_Date AND @Create_Date <= v.End_Date) AND
				((@Primary_Price - @Used_Point * 1000) >= v.Minimum_Price) AND
				(v.Is_Require_Member = CASE WHEN @Customer_Phone IS NULL THEN 0 ELSE 1 END)

	ORDER BY v.Discount DESC
	
	
	-- Calculate @Final_Price
	SET @Final_Price = ((@Primary_Price - @Used_Point * 1000) * (100 - @Discount)) / 100
	

	-- Calculate @Earned_Point
	SET @Earned_Point = @Final_Price / 20000
	
	
	-- Update Point for Customer
	IF @Customer_Phone IS NOT NULL
	BEGIN
		SET @Earned_Point = @Final_Price / 20000

		EXEC Update_Point_For_Customer @Customer_Phone, @Used_Point, @Earned_Point
	END
	ELSE
		SET @Earned_Point = 0


	-- Update Bill with @Bill_ID
	UPDATE	Bill
	SET		Primary_Price	= @Primary_Price,
			Used_Point		= @Used_Point,
			Final_Price		= @Final_Price,
			Earned_Point	= @Earned_Point,
			Voucher_ID		= @Voucher_ID

	WHERE	Bill_ID = @Bill_ID
END
GO


GO