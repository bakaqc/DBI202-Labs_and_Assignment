

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

SELECT dbo.Group1('VT02') AS SUMGIABAN
