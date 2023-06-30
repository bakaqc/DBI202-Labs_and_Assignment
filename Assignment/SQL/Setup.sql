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



-- STEP 2: Use PASTRY_SHOP database
USE PASTRY_SHOP
GO


-- STEP 3: Create Customer table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Customer')
BEGIN
    CREATE TABLE Customer (
        Customer_Phone VARCHAR(20) PRIMARY KEY,
        Customer_Name NVARCHAR(100) NOT NULL,
        Point INT CHECK(Point >= 0) NOT NULL
    );
    PRINT 'Customer table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Customer table already exists.';
END


-- STEP 4: Create Employee table


-- STEP 5: Create Product table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Product')
BEGIN
    CREATE TABLE Product (
        Product_ID VARCHAR(20) PRIMARY KEY,
        Product_Name NVARCHAR(100) NOT NULL,
        Price INT CHECK(Price > 0) NOT NULL
    );
    PRINT 'Product table created successfully.';
END
ELSE
BEGIN
    PRINT 'The Product table already exists.';
END


-- STEP 6: Create Voucher table


-- STEP 7: Create Bill table


-- STEP 8: Create Bill_Data table

