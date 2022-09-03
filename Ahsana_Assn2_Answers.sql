USE MyGuitarShop;
GO

-- ********* Question 1 *********
DECLARE @NumberOfProducts AS INT
SET @NumberOfProducts = (
						SELECT
							COUNT(*)
						FROM
							Products);
IF @NumberOfProducts >= 7
	PRINT 'The number of products is greater than or equal to 7'
ELSE
	PRINT 'The number of products is less than 7'


-- ********* Question 2 *********
DECLARE @AvgListPrice AS MONEY
SET @AvgListPrice = (
					SELECT
						Avg(ListPrice)
					FROM	
						Products);
IF @NumberOfProducts >= 7
	PRINT 'Total product: ' + CONVERT(VARCHAR, @NumberOfProducts) + ' Average list price is: ' + CONVERT(VARCHAR, @AvgListPrice)
ELSE
	PRINT 'The number of products is less than 7'
GO

-- ********* Question 3 *********
DECLARE @X INT = 10;
DECLARE @Y INT = 20;
DECLARE @I INT = 1;

WHILE (@I <= @X)
	BEGIN
		IF(@Y % @I = 0 AND @X % @I = 0)
			PRINT (CONVERT(VARCHAR, @I,1))
		SET @I = @I + 1;
	END
GO

-- ********* Question 4 *********
BEGIN 
	TRY
		INSERT INTO Categories (CategoryName)
		VALUES ('Guitars')
		PRINT 'SUCCESS: Record was inserted.';
END TRY

BEGIN 
	CATCH
		PRINT 'FAILURE: Record was not inserted.';
		PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1) + ': '+ ERROR_MESSAGE()
END CATCH
GO





