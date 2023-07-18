--------------------------------------------------------
--                                                    --
--                    Write query                     --
--                                                    --
--------------------------------------------------------

USE PASTRY_SHOP
GO

-- Câu 1:
-- - Tìm nhân viên tạo hóa đơn nhiều nhất
-- - Nghĩa

SELECT *
FROM Employee
WHERE Employee_ID = ANY (SELECT TOP 1 WITH TIES Employee_ID
						 FROM Bill
						 GROUP BY Employee_ID
						 ORDER BY COUNT(Bill_ID) DESC)

-- Câu 2:
-- - Hiển thị lịch sử mua hàng của khách hàng thành viên có SĐT là 0956789012
-- - Chương
SELECT B.Bill_ID, B.Create_Date, B.Create_Time, P.Product_Name, BD.Product_Amount, B.Final_Price
FROM Bill B
JOIN Customer C ON B.Customer_Phone = C.Customer_Phone
JOIN Bill_Data BD ON B.Bill_ID = BD.Bill_ID
JOIN Product P ON BD.Product_ID = P.Product_ID
WHERE C.Customer_Phone = '0956789012'
ORDER BY B.Bill_ID ASC



-- Câu 3:
-- - Hiển thị số lần được áp dụng của các voucher
-- - Vương
SELECT      v.Voucher_ID AS [Voucher ID],
            COUNT(*) AS [Total times applied]

FROM        Voucher v LEFT JOIN Bill b ON v.Voucher_ID = b.Voucher_ID
GROUP BY    v.Voucher_ID
ORDER BY    [Total times applied] DESC

-- Câu 4:
-- - Hiển thị danh sách hóa đơn của nhân viên Nguyễn Thị Thúy
-- - Nghĩa

SELECT *
FROM Bill
WHERE Employee_ID = (SELECT Employee_ID
					 FROM Employee
					 WHERE Employee_Name = N'Nguyễn Thị Thúy')

-- Câu 5:
-- - Hiển thị tổng doanh thu của mỗi tháng
-- - Vương
SELECT      YEAR(b.Create_Date) AS [Year],
            MONTH(b.Create_Date) AS [Month],
            SUM(b.Final_Price) AS [Total revenue]
            
FROM        Bill b
GROUP BY    YEAR(b.Create_Date),
            MONTH(b.Create_Date)

-- Câu 6:
-- - Hiển thị sản phẩm best seller của tháng 7
-- - Thúy

/*	SELECT p.Product_Name, SUM(bd.Product_Amount) AS Total_sold
	FROM Bill_Data AS bd
		JOIN Product p ON bd.Product_ID = p.Product_ID
		JOIN Bill b ON bd.Bill_ID = b.Bill_ID
	WHERE MONTH(b.Create_Date) = 7
	GROUP BY p.Product_Name
	*/

	SELECT TOP 1 WITH TIES p.Product_Name, SUM(bd.Product_Amount) AS Total_sold
	FROM Bill_Data AS bd
		JOIN Product p ON bd.Product_ID = p.Product_ID
		JOIN Bill b ON bd.Bill_ID = b.Bill_ID
	WHERE MONTH(b.Create_Date) = 7
	GROUP BY p.Product_Name
	ORDER BY Total_Sold DESC;

-- Câu 7:
-- - Hiển thị khách hàng thành viên có hóa đơn mua lớn nhất trong tháng 6 và thông tin hóa đơn đó
-- - Thông tin hoá đơn cần hiển thị: Mã hoá đơn, số tiền khách đã chi trả
-- - Thúy

/*	SELECT c.Customer_Name, b.Bill_ID, b.Final_Price
	FROM Customer c
		JOIN Bill b ON c.Customer_Phone = b.Customer_Phone
	WHERE MONTH(b.Create_Date) = 6
	ORDER BY b.Final_Price DESC;
	*/

	SELECT TOP 1 WITH TIES c.Customer_Name, b.Bill_ID, b.Final_Price
	FROM Customer c
		JOIN Bill b ON c.Customer_Phone = b.Customer_Phone
	WHERE MONTH(b.Create_Date) = 6
	ORDER BY b.Final_Price DESC;

-- Câu 8:
-- - Hiển thị thông tin sản phẩm có số lượng mua nhiều nhất của các khách hàng vãng lai
-- - Thông tin sản phẩm cần hiển thị: Tên sản phẩn, giá sản phẩm, số lượng đã bán ra
-- - Chương

SELECT TOP 1 WITH TIES P.Product_ID, P.Product_Name, COUNT(BD.Product_ID) AS The_number_of_products
FROM Product P
JOIN Bill_Data BD ON P.Product_ID = BD.Product_ID
JOIN Bill BL ON BD.Bill_ID = BL.Bill_ID
WHERE BL.Customer_Phone IS NOT NULL
GROUP BY P.Product_ID, P.Product_Name
ORDER BY The_number_of_products DESC
