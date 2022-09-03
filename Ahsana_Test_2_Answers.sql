USE MyGuitarShop;
GO

/*
My name is Ahsana Tasnim and I certify that this assignment represents
my own work and is in accordance with the NBCC Policy 1111 - Academic Integrity
*/


---- Question 1 ----
CREATE OR ALTER PROC  spCreateOrder
	@CustomerID INT,
	@CardType VARCHAR(50),
	@CardNumber CHAR(16),
	@CardExpires CHAR(7),
	@ShipAddressID INT = NULL,
	@BillingAddressID INT = NULL

AS 

BEGIN
		IF @ShipAddressID IS NULL
			SET @ShipAddressID = (
				SELECT
					ShippingAddressID
				FROM
					Customers
				WHERE
					CustomerID = @CustomerID)
		IF @BillingAddressID IS NULL
			SET @BillingAddressID = (
				SELECT
					BillingAddressID
				FROM
					Customers
				WHERE
					CustomerID = @CustomerID)

	INSERT INTO Orders (
		CustomerID,
		OrderDate,
		ShipAmount,
		TaxAmount,
		ShipDate,
		ShipAddressID,
		CardType,
		CardNumber,
		CardExpires,
		BillingAddressID)

	VALUES(
		@CustomerID,
		GETDATE(),
		0,
		0,
		NULL,
		@ShipAddressID,
		@CardType,
		@CardNumber,
		@CardExpires,
		@BillingAddressID);

END

GO

EXEC spCreateOrder 3, 'Visa', 4111111111111111, '06/2020';

GO

---- Question 2 ----
CREATE OR ALTER PROC  spAddToOrder
	@OrderID INT,
	@ProductID INT,
	@Quantity INT = 1,
	@ShipAmount MONEY,
	@ApplyDiscount BIT,
	@OrderTotal MONEY OUTPUT

AS

BEGIN
	
	DECLARE @ItemPrice MONEY = (
		SELECT
			ListPrice
		FROM
			Products
		WHERE
			ProductID = @ProductID)
	DECLARE @DiscountAmount MONEY

	IF @ApplyDiscount = 1
		BEGIN
			DECLARE @DiscountPercent MONEY = (
					SELECT
						DiscountPercent
					FROM
						Products
					WHERE
						ProductID = @ProductID)
			SET @DiscountAmount = (@ItemPrice * @DiscountPercent/100)
		END
	ELSE
		SET @DiscountAmount = 0

	INSERT INTO OrderItems (
		OrderID,
		ProductID,
		ItemPrice,
		DiscountAmount,
		Quantity)

	VALUES(
		@OrderID,
		@ProductID,
		@ItemPrice,
		@DiscountAmount,
		@Quantity)

	SET @ShipAmount = (
		SELECT
			ShipAmount
		FROM
			Orders
		WHERE
			OrderID = @OrderID)
	DECLARE @TaxAmount MONEY = (((@ItemPrice - @DiscountAmount) * @Quantity) * .15)

UPDATE Orders
	SET
		ShipAmount = @ShipAmount,
		TaxAmount = @TaxAmount
	FROM
		Orders
	WHERE
		OrderID = @OrderID

SET @OrderTotal = (
		SELECT
			(Sum(ItemPrice-DiscountAmount)*Quantity) + ShipAmount + TaxAmount
		FROM
			OrderItems
				INNER JOIN Orders ON Orders.OrderID = OrderItems.OrderID
	    GROUP BY
			Quantity,
			ShipAmount,
			TaxAmount);
END

GO
