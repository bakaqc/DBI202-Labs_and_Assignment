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

-- Câu 4:
-- - Hiển thị danh sách hóa đơn của nhân viên Nguyễn Thị Thúy
-- - Nghĩa

-- Câu 5:
-- - Hiển thị tổng doanh thu của mỗi tháng
-- - Vương

-- Câu 6:
-- - Hiển thị sản phẩm best seller của tháng 7
-- - Thúy

-- Câu 7:
-- - Hiển thị khách hàng thành viên có hóa đơn mua lớn nhất trong tháng 6 và thông tin hóa đơn đó
-- - Thúy

-- Câu 8:
-- - Hiển thị thông tin sản phẩm có số lượng mua nhiều nhất của các khách hàng vãng lai
-- - Chương
SELECT TOP 1 WITH TIES P.Product_ID, P.Product_Name, COUNT(BD.Product_ID) AS The_number_of_products
FROM Product P
JOIN Bill_Data BD ON P.Product_ID = BD.Product_ID
JOIN Bill BL ON BD.Bill_ID = BL.Bill_ID
WHERE BL.Customer_Phone IS NOT NULL
GROUP BY P.Product_ID, P.Product_Name
ORDER BY The_number_of_products DESC