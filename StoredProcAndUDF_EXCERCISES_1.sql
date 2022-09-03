USE AP;
GO

---- Exercise 3 Page 507 ----
CREATE OR ALTER PROC spDateRange
	@DateMin VARCHAR(50) = NULL,
	@DateMax VARCHAR(50) = NULL

AS

	IF @DateMin IS NULL OR @DateMax IS NULL
		THROW 52001, 'DATE CANNOT BE NULL', 1;
	IF NOT (ISDATE(@DateMin) = 1 AND ISDATE(@DateMax) = 1)
		THROW 52001, 'PLEASE ENTER A DATE', 1;
	IF CAST(@DateMin AS DATE) > CAST(@DateMax AS DATE)
		THROW 52001, 'PLEASE ENTER A VALID DATE', 1;

SELECT
	InvoiceNumber,
	InvoiceDate,
	InvoiceTotal,
	InvoiceTotal - CreditTotal - PaymentTotal AS Balance
FROM	
	Invoices
WHERE
	InvoiceDate BETWEEN @DateMin AND @DateMax
ORDER BY
	InvoiceDate

GO

---- Exercise 4 Page 507 ----
BEGIN TRY
	EXEC spDateRange '2019-10-10', '2019-10-20';
END TRY
BEGIN CATCH
	PRINT 'Error Number: ' + CONVERT(VARCHAR(100), ERROR_NUMBER());
	PRINT 'Error Message: ' + CONVERT(VARCHAR(100), ERROR_MESSAGE());
END CATCH;

GO

---- Exercise 5 Page 507 ----
CREATE OR ALTER FUNCTION fnUnpaidinvoiceID()
	RETURNS INT

BEGIN 
	RETURN (
		SELECT
			MIN(InvoiceID)
		FROM
			Invoices
		WHERE
			InvoiceTotal - CreditTotal - PaymentTotal > 0 AND
			InvoiceDueDate = (
				SELECT
					MIN(InvoiceDueDate)
				FROM
					Invoices
				WHERE
					InvoiceTotal - CreditTotal - PaymentTotal > 0));
END
GO

SELECT VendorName, InvoiceNumber, InvoiceDueDate, 
InvoiceTotal - CreditTotal - PaymentTotal AS Balance 
FROM Vendors JOIN Invoices 
ON Vendors. VendoriD = Invoices.VendoriD 
WHERE InvoiceiD = dbo.fnUnpaidinvoiceiD();
