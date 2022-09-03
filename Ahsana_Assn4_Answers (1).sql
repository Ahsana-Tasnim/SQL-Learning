USE MyGuitarShop;
GO

-- ********* Question 1 *********
CREATE OR ALTER PROC spInsertProduct
	@CategoryID INT,
	@ProductCode VARCHAR,
	@ProductName VARCHAR(255),
	@ListPrice MONEY,
	@DiscountPercent MONEY

AS 

BEGIN

	IF @ListPrice < 0
		THROW 51000, 'LIST PRICE CAN NOT BE NEGATIVE', 1;
	IF @DiscountPercent < 0
		THROW 51000, 'DISCOUNT PRICE CAN NOT BE NEGATIVE', 1;

	INSERT INTO Products (
			CategoryID,
			ProductCode,
			ProductName,
			ListPrice,
			DiscountPercent,
			Description,
			DateAdded)
	
VALUES(
		@CategoryID,
		@ProductCode,
		@ProductName,
		@ListPrice,
		@DiscountPercent,
		'',
		GETDATE());
END
GO

--FAILED EXEC STATEMENT
BEGIN TRY
	EXEC spInsertProduct 1, 12, 'NEW PRODUCT', -1, -5;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH

GO

--SUCCESSFUL EXEC METHOD
BEGIN TRY
	EXEC spInsertProduct 2, 12, 'NEW PRODUCT', 188, 10;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH

GO

-- ********* Question 2 *********
CREATE OR ALTER FUNCTION fnDiscountPrice (@ItemID INT)
	RETURNS MONEY
AS
BEGIN
	RETURN (
		SELECT 
			ItemPrice - DiscountAmount 
		FROM
			OrderItems
		WHERE
			ItemID = @ItemID)
END

GO

SELECT
	ItemID,
	ItemPrice,
	DiscountAmount,
	DBO.fnDiscountPrice(20) AS DiscountPrice
FROM
	OrderItems
GO

-- ********* Question 3 *********
CREATE OR ALTER PROC spUpdateProductDiscount
	@ProductID INT,
	@DiscountPercent MONEY
	
AS 

	IF @DiscountPercent < 0
		THROW 51000, 'THIS FIELD CAN NOT BE NEGATIVE', 1;

	UPDATE 
		Products
	SET 
		DiscountPercent = @DiscountPercent
	FROM 
		Products
	WHERE
		ProductID = @ProductID
GO

--FAILED EXEC STATEMENT
BEGIN TRY
	EXEC spUpdateProductDiscount 1, -5;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH

GO

--SUCCESSFUL EXEC METHOD
BEGIN TRY
	EXEC spUpdateProductDiscount 2, 12;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH

GO
