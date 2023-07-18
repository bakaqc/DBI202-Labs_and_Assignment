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

-- Câu 2:
-- - Hiển thị lịch sử mua hàng của khách hàng thành viên có SĐT là 0956789012
-- - Chương

-- Câu 3:
-- - Hiển thị số lần được áp dụng của các voucher
-- - Vương

-- Câu 4:
-- - Hiển thị danh sách hóa đơn của nhân viên Nguyễn Thị Thúy
-- - Nghĩa

-- Câu 5:
-- - Hiển thị tổng doanh thu của mỗi tháng
-- - Vương

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
-- - Chương