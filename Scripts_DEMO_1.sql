USE AP;
GO
/*
Declaring Variables

We use the DECLARE statement to declare variables.
Variable names must begin with an @ sign
*/
DECLARE @FirstName AS VARCHAR(50)
DECLARE @Age AS INT
DECLARE @IsDiscontinued AS BIT

/*
Assigning a value to a variable

We use the SET statement to assign a value to a variable
*/
SET @FirstName = 'Ahsana'
SET @Age = 22
SET @IsDiscontinued = 1

/*
We can use the SELECT statement to assign values to one or more
variables
*/
SELECT @FirstName = 'Ahsana', @Age = 22, @IsDiscontinued = 1

/*
Above we were assigning literal values to variables.  We can
also assign scalar values we retrieve via a select statement
to variables
*/
DECLARE @NumberOfVendors AS INT
DECLARE @VendorWithLargestInvoice AS VARCHAR(100)

SET @NumberOfVendors = (SELECT COUNT(*) FROM Vendors);
SET @VendorWithLargestInvoice = (
	SELECT
		TOP 1 VendorName
	FROM
		Vendors
			INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
	ORDER BY
		Invoices.InvoiceTotal)

/*
We can use these variables in scripts that we write.
We can print them out to the messages window by using the PRINT
command
*/
PRINT 'The vendor with the largest invoice is ' + @VendorWithLargestInvoice
PRINT '# of vendors: ' + CONVERT(VARCHAR, @NumberOfVendors)

/*
We can use statements to control the flow of execution, for example,
IF and ELSE
*/
IF @NumberOfVendors > 150
	PRINT 'You have a lot of vendors.'
ELSE IF @NumberOfVendors > 100
	BEGIN
		PRINT 'You have a decent amount of vendors'
		PRINT 'Great job!'
	END
ELSE
	PRINT 'Not very many vendors'
