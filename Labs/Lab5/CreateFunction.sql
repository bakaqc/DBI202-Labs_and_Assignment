-- 1. Write function name: StudenID_ Func1 with parameter @mavt, return the sum
-- of sl*giaban corresponding

USE ABCCompany
GO

CREATE FUNCTION Group1 (@mavt NVARCHAR(5))
RETURNS INT
AS
BEGIN
    DECLARE @result INT
    
    SELECT @result = SUM(SL * GiaBan)
    FROM CHITIETHOADON
    WHERE MaVT = @mavt
    
    RETURN @result
END
GO

SELECT MaHD, (SL * GiaBan) AS [Số tiền mua VT01 trong mỗi HD]
FROM CHITIETHOADON
WHERE MaVT = 'VT01'

