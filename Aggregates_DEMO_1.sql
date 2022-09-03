USE AP;
GO

-- COUNT - Get the number of vendors
SELECT
	COUNT(*)
FROM
	Vendors

USE AP;
GO
-- COUNT - Get the number of vendors in the state of CA
SELECT
	COUNT(*)
FROM
	Vendors
WHERE
	VendorState = 'CA'

USE AP;
GO
-- COUNT DISTINCT - Get the number of unique cities that vendors are in
SELECT
	COUNT(DISTINCT VendorCity)
FROM
	Vendors

USE AP;
GO
-- MIN - Get the lowest invoice total
SELECT
	MIN(InvoiceTotal)
FROM
	Invoices

USE AP;
GO
-- MIN - Get the minumum balance due (calculated by: InvoiceTotal - PaymentTotal - CreditTotal)
-- for vendors that have a Account Description (from GLAccounts) of Freight.
-- Include only records where balance due is greater than zero
SELECT
	MIN(InvoiceTotal - PaymentTotal - CreditTotal)
FROM 
	Invoices
		INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
		INNER JOIN GLAccounts ON Vendors.DefaultAccountNo = GLAccounts.AccountNo
	WHERE
		AccountDescription = 'Freight'
		AND InvoiceTotal - PaymentTotal - CreditTotal > 0

USE AP;
GO
-- MAX - Get the largest invoice line item amount
SELECT
	MAX(InvoiceLineItemAmount)
FROM
	InvoiceLineItems

USE AP;
GO
-- MAX - Get the most recent invoice date for the invoice that included Freight items
-- (InvoiceLineItemDescription)
SELECT
	MAX(InvoiceDate)
FROM
	Invoices
		INNER JOIN InvoiceLineItems ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
	WHERE
		InvoiceLineItemDescription = 'Freight'

USE AP;
GO
-- SUM - Get the sum of the invoice totals
SELECT
	SUM(InvoiceTotal)
FROM
	Invoices

USE AP;
GO
-- SUM - Get the sum of the invoices from all vendors that are in the state of CA
SELECT
	SUM(InvoiceTotal)
FROM
	Invoices
		INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
	WHERE
		VendorState = 'CA'

USE AP;
GO
-- AVG - Get the average invoice total
SELECT
	AVG(InvoiceTotal)
FROM
	Invoices

USE AP;
GO
-- AVG - Get the average invoice line item amount for invoices that were placed in January
-- and February of 2016
SELECT
	AVG(InvoiceLineItemAmount)
FROM
	InvoiceLineItems
		INNER JOIN Invoices ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
	WHERE
		InvoiceDate >= '1/1/2020' AND InvoiceDate < '3/1/2020'


