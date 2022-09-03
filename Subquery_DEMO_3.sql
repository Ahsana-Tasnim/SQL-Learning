USE AP;
GO
/*
SUBQUERIES IN FROM

Not used very often - we use a View normally which we will learn about
later

We are asked to retrieve the top 5 vendors by average invoice total
and then sort those by the vendors latest invoice

Let's start by getting the top 5 vendors by average invoice total

*/
SELECT
	TOP 5 VendorID,
	AVG(InvoiceTotal)
FROM	
	Invoices
GROUP BY
	VendorID
ORDER BY
	AVG(InvoiceTotal)

/*
Now, look at the above...is there a way for me to sort this by the
vendors latest invoice date?  Let's try by ordering by MAX(InvoiceDate)
*/
SELECT
	TOP 5 VendorID,
	AVG(InvoiceTotal),
	MAX(InvoiceDate)
FROM	
	Invoices
GROUP BY
	VendorID
ORDER BY
	MAX(InvoiceDate)

/*
We can see that this doesn't work becuase now it is selecting the TOP 5 based on
the Invoice Date, not the Average of the invoice total

To solve this, we can include a subquery in our FROM.  This is will create what we
refer to as a derived table

Our first query we wrote above will be the derived table.  We will then select from invoices
the vendorid, latest invoice date and the average invoice total, and then join this
with the derived table and then group the resulting rows by vendorid
*/
SELECT
	Invoices.VendorID,
	MAX(InvoiceTotal) AS LastestInv,
	AVG(InvoiceDate) AS AvgInvoice
FROM
	Invoices
		INNER JOIN (
			SELECT 
				TOP 5 VendorID,
				AVG(InvoiceTotal) AS AvgInvoice
			FROM
				Invoices
			GROUP BY
				VendorID
			ORDER BY
				AvgInvoice DESC) AS TopVeNdor ON Invoices.VendorID = TopVeNdor.VendorID
GROUP BY
	Invoices.VendorID
ORDER BY
	LastestInv DESC			

/*
Few things to notice
1.  The derived table (the subquery in the from) is assigned an alias so that
it can be referred to by the outer query

2. The AVG function result in subqery is given a column alias, becuase a derived table
cannot have unnamed columns

3. the subquery uses TOP and it has an ORDER BY.  This is the only time a subquery can
have an ORDER BY...if it uses TOP

SUBQUERY IN SELECT

Retreive the most recent invoice for each vendor

we can do this using a join
*/
SELECT
	VendorName,
	MAX(InvoiceDate) AS LastestInv
FROM
	Vendors
		LEFT OUTER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
GROUP BY
	VendorName
ORDER BY
	LastestInv DESC

/*
And we can do it by putting a select statement in the select list to get the max invoice date
It's best to do it using a JOIN though.
*/
SELECT
	VendorName,
	(SELECT	
		MAX(InvoiceDate)
	FROM
		Invoices
	WHERE
		Invoices.VendorID = Vendors.VendorID) AS LastestInv
FROM
	Vendors
ORDER BY
	LastestInv DESC

/*
we can also use subqueries in UPDATE statements

Let's update the invoices table and set the TermsID to 1 for all vendors in 
CA, AZ and NV
*/
UPDATE Invoices SET
	TermsID = 1
WHERE
	VendorID IN (
	SELECT	
		VendorID
	FROM
		Vendors
	WHERE
		VendorState IN ('CA', 'AZ', 'NV'))

/*
Let's update the due date for invoice number 97/522 to the largest invoice due date
in the invoices table
*/
UPDATE Invoices SET
	InvoiceDueDate = (SELECT MAX(InvoiceDueDate) FROM Invoices)
WHERE
	InvoiceNumber = '97/522'

/*
We can also use subqueries in delete

Delete all invoices where Vendor zip code is 90210
*/
DELETE FROM Invoices
WHERE VendorID IN (
	SELECT VendorID FROM Vendors WHERE VendorZipCode = '90210')

/*
You can also use them in inserts
*/

