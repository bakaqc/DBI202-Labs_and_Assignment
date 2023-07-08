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

SELECT dbo.Group1('VT01') AS SUMGIABAN
SELECT dbo.Group1('VT02') AS SUMGIABAN
SELECT dbo.Group1('VT03') AS SUMGIABAN
SELECT dbo.Group1('VT04') AS SUMGIABAN
SELECT dbo.Group1('VT05') AS SUMGIABAN