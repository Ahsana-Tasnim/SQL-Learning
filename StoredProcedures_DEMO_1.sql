USE AP;
GO
/*
Create a stored procedure that returns all of the Invoices
*/
CREATE OR ALTER PROCEDURE spGetAllInvoices
AS

BEGIN
	SELECT
		InvoiceID,
		InvoiceDate,
		InvoiceTotal
	FROM
		Invoices
	ORDER BY
		InvoiceDate
END

GO

/* 
Run the script above to create the store procecure
Notice now in your object explorer, the stored procedure created above
is now save as an object in the database under Programmability/Store Procedures

Try to run the script above again.  You can't, since it already exists,
so if you wanted to run it again, you would need to DROP the procedure first
or use CREATE OR ALTER (we will do this after)

Let's execute the stored procedure we created above
*/
EXEC spGetAllInvoices
GO

/*
After executing, we see our result set that the stored procedure returns

If we click on messages, we see the number of rows affected.  We can prevent that
from being returned by turning NOCOUNT ON. We will set NOCOUNT ON in stored procedure
we build below
*/
CREATE OR ALTER PROCEDURE spGetAllInvoices
AS

BEGIN
	SET NOCOUNT ON;

	SELECT
		InvoiceID,
		InvoiceDate,
		InvoiceTotal
	FROM
		Invoices
	ORDER BY
		InvoiceDate
END

GO

/*
Let's execute the stored procedure we created above
*/
EXEC spGetAllInvoices
GO

/*
Create a stored procedure that copies all vendors into a table
called VendorCopy
*/
CREATE OR ALTER PROC spCopyVendors
AS

BEGIN
	--FIRST CHECK IF VendorCopy TABLE EXISTS
	--IF OBJECT_ID('VendorCopy') IS NOT NULL
	-- DROP TABLE VendorCopy
	DROP TABLE IF EXISTS VendorCopy;

	SELECT
		*
	INTO
		VendorCopy
	FROM
		Vendors;
END
GO

/*
Now execute it
*/
EXEC spCopyVendors;
GO

/*
Take a few minutes now to create a store procedure
that returns all vendors in the state of CA
SET NOCOUNT ON so that the number of rows affected are not returned
*/
CREATE OR ALTER PROCEDURE spGetVendorsInCA
AS

BEGIN
	SET NOCOUNT ON;

	SELECT
		*
	FROM
		Vendors
	WHERE
		VendorState = 'CA'
	ORDER BY
		VendorName
END

GO


EXEC spGetVendorsInCA;
GO

/*
Let's create a stored procedure that gets all the vendors by state
We can do this by creating an input parameter for State, and allowing
the user to pass in the state they want to get the vendors for
*/
CREATE OR ALTER PROC spGetVendorsByState
	@StateCode VARCHAR(2)
AS

BEGIN
	SET NOCOUNT ON;

	SELECT
		*
	FROM
		Vendors
	WHERE
		VendorState = @StateCode
	ORDER BY
		VendorName;
END
GO

/*
Now let's run it and pass in a state
*/
EXEC spGetVendorsByState 'CA'
GO

/*
Now let's run it for a different state
*/
EXEC spGetVendorsByState 'NY'
GO

/*
Take a few minutes to create a store procedure 
that gets all invoices by term
*/
CREATE OR ALTER PROC spGetInvoicesByTerm
	@TermID INT
AS

BEGIN
	SET NOCOUNT ON;

	SELECT
		*
	FROM
		Invoices
	WHERE
		TermsID = @TermID
	ORDER BY
		InvoiceDate;
END
GO

/*
The execute it a few times using different termsid's
*/
EXEC spGetInvoicesByTerm 1;
EXEC spGetInvoicesByTerm 3;
GO

/*
We can have up to 2100 parameters in a stored procecedure
*/
CREATE OR ALTER PROC spGetTopVendorByState
	@StateCode VARCHAR(2),
	@MinInvoiceTotal MONEY
AS

BEGIN
	SET NOCOUNT ON;
		
	SELECT
		*
	FROM
		Vendors
			INNER JOIN Invoices ON Vendors.VendorID = Invoices.InvoiceID
	WHERE
		VendorState = @StateCode
		AND InvoiceTotal > @MinInvoiceTotal
	ORDER BY
		VendorName,
		InvoiceTotal DESC
END
GO


EXEC spGetTopVendorByState 'CA', 3000
GO

/* Optional parameters
Let's create a stored procedure that gets all the vendors by state
like we did previously above.  This time, we will set a default value
for the @StateCode parameter which will make it optional.
*/
CREATE OR ALTER PROC spGetVendorsByState2
	@StateCode VARCHAR(2) = NULL
AS

BEGIN
	SET NOCOUNT ON;

	IF @StateCode IS NOT NULL
	SELECT
		*
	FROM
		Vendors
	WHERE
		VendorState = @StateCode
	ORDER BY
		VendorName;
	ELSE
		SELECT * FROM VENDORS ORDER BY VendorName
END
GO

/*
we can call it with or without a parameter
*/
EXEC spGetVendorsByState2;
EXEC spGetVendorsByState2 'NY';
GO
