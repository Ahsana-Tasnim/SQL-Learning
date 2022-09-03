USE AP;
GO
/*
Create a function that returns the total balance due for a 
specific vendor
*/
CREATE FUNCTION fnAmtDueByVendor (@VendorID INT)
	RETURNS MONEY
AS
BEGIN
	RETURN (
		SELECT 
			SUM(InvoiceTotal - PaymentTotal - CreditTotal)
		FROM
			Invoices
		WHERE
			VendorID = @VendorID)
END

GO

/*
Invoke it for vendorid = 123
*/
DECLARE @AmtDue MONEY;
SET @AmtDue = dbo.fnAmtDueByVendor(123);
PRINT 'The amount due is ' + CONVERT(VARCHAR, @AmtDue);
GO

/*
now lets invoke it for vendorid = 500
*/
DECLARE @AmtDue MONEY;
SET @AmtDue = dbo.fnAmtDueByVendor(500);
IF @AmtDue IS NULL
	PRINT 'There is no balance due for vendor';
ELSE
PRINT 'The amount due is ' + CONVERT(VARCHAR, @AmtDue);

/* 
Why no results?
*/
IF @AmtDue IS NULL
	PRINT 'AmtDue IS NULL';

GO

/*
let's alter the function and check if null
*/
ALTER FUNCTION fnAmtDueByVendor (@VendorID INT)
	RETURNS MONEY
AS
BEGIN
	DECLARE @RetVal MONEY;

	SET @RetVal = (
		SELECT 
			SUM(InvoiceTotal - PaymentTotal - CreditTotal)
		FROM
			Invoices
		WHERE
			VendorID = @VendorID)
	IF @RetVal IS NULL
		SET @RetVal = 0;

	RETURN @RetVal
END

GO

/*
now lets invoke it for vendorid = 500 again
*/
DECLARE @AmtDue MONEY;
SET @AmtDue = dbo.fnAmtDueByVendor(500);
PRINT 'The amount due is ' + CONVERT(VARCHAR, @AmtDue);
GO

/*
I can also use the function in a select statement.  Although this is an odd request,
for example purposes, let's get all the vendors where the balance due is 
greater than the balance due for vendor 122
*/
SELECT
	Vendors.VendorID, VendorName
FROM
	Vendors
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	(InvoiceTotal - PaymentTotal - CreditTotal) > dbo.fnAmtDueByVendor(122)



