USE AP;
GO
/*
Inserting data using a stored procedure, and
performing data validation
Create a stored procedure that inserts a invoice
Make sure that the vendor that you are inserting the invoice for
exists before performing an insert, so you don't violate any
constraints
*/
CREATE OR ALTER PROC spInsertInvoice
	@VendorID INT,
	@InvoiceDate DATETIME,
	@TermsID INT,
	@InvoiceNumber VARCHAR(50),
	@InvoiceTotal MONEY,
	@InvoiceDueDate DATETIME
AS

BEGIN
	
	IF NOT EXISTS(SELECT * FROM Vendors WHERE VendorID = @VendorID)
		THROW 51000, 'Vendor ID IS NOT VALID', 1;

	INSERT INTO Invoices VALUES(
		@VendorID,
		@InvoiceNumber,
		@InvoiceDate,
		@InvoiceTotal,
		0,
		0,
		@TermsID,
		@InvoiceDueDate,
		NULL);
END

GO

-- to call it, we use a try catch so that we can catch that error
BEGIN TRY
	EXEC spInsertInvoice 123, '2020-05-01', 1, 'ZXK-799', 299.95, '2020-05-31';
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH

GO

/*
Output parameters
Create a stored procedure that accepts a parameter for vendor state,
and outputs the invoice total for that vendor state
*/
CREATE OR ALTER PROC spGetVendorInvoiceTotal
	@VendorState VARCHAR(2),
	@InvoiceTotal MONEY OUTPUT
AS

BEGIN
	SET @InvoiceTotal = (
		SELECT
			SUM(InvoiceTotal)
		FROM
			Invoices
				INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
		WHERE
			Vendors.VendorState = @VendorState);
END

GO

/*
To execute it, we first delcare a variable to store the value of the 
output parameter
*/
DECLARE @InvTotal MONEY -- NOTICE this does NOT have to be same name as outpur parameters

-- next we execute the store procedure and pass in the paramters
EXEC spGetVendorInvoiceTotal 'CA', @InvTotal OUTPUT

-- now we can use that variable holding the output in our code
-- let's just select it
SELECT @InvTotal

GO

/*
Return values
Stored procedures pass back a return value.  It is an integer, and the
default value is zero.  If you only have to return a single integer,
then you can use a RETURN statement to return the value instead of an
output parameter
*/
CREATE OR ALTER PROC spGetNumInvoicesByVendor
	@VendorID INT
AS

DECLARE @NumInvoices INT

SET @NumInvoices = (SELECT COUNT(*) FROM Invoices WHERE VendorID = @VendorID)

RETURN @NumInvoices;

GO

/*
To call this procedure, we declare a variable to hold the return value
*/
DECLARE @NumInv INT

EXEC @NumInv = spGetNumInvoicesByVendor 122;

SELECT @NumInv;

GO

/*
Create a stored procedure that outputs the balance due for an invoice
*/
--////
CREATE OR ALTER PROC spGetBalanceDue
	@VendorID INT,
	@BalanceDue MONEY OUTPUT
AS

BEGIN
	SET @BalanceDue = (
		SELECT
			InvoiceTotal - PaymentTotal - CreditTotal
		FROM
			Invoices
				INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
		WHERE
			Vendors.VendorState = @VendorID);
END

GO

DECLARE @BDue MONEY
EXEC spGetBalanceDue 121, @BDue OUTPUT
GO

/*
Create a stored procedure that updates the Payment Total for a specified invoice
and outputs the new balance due - Let's assume that you can make multiple payments
on an invoice, although, this database design is really 
*/






