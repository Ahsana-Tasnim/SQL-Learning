/*
Back when we learned about using a subquery in the from clause
we created a query to get the top 5 vendors by average invoice total
and order it by the LATEST invoice
*/
SELECT
	Invoices.VendorID, MAX(InvoiceDate) AS LatestInv,
	AVG(InvoiceTotal) AS AvgInvoice
FROM
	Invoices INNER JOIN
	(SELECT 
		TOP 5 VendorID, AVG(InvoiceTotal) AS AvgInvoice
	FROM
		Invoices
	GROUP BY 
		VendorID
	ORDER BY 
		AvgInvoice DESC) AS TopVendor
	ON Invoices.VendorID = TopVendor.VendorID
GROUP BY
	Invoices.VendorID
ORDER BY
	LatestInv DESC;
GO
/*
Above we write a subquery in the FROM clause which creates a
derived table, and we join that derived table with Invoices
*/
/*
Doing the same thing using a CTE
A Common Table Expression allows you to code an expression
that defines a derived table
*/
WITH TopVendors AS
(
	SELECT 
		TOP 5 VendorID, AVG(InvoiceTotal) AS AvgInvoice
	FROM
		Invoices
	GROUP BY 
		VendorID
	ORDER BY 
		AvgInvoice DESC
)
SELECT
	Invoices.VendorID, MAX(InvoiceDate) AS LatestInv,
	AVG(InvoiceTotal) AS AvgInvoice
FROM
	Invoices INNER JOIN TopVendors ON Invoices.VendorID = TopVendors.VendorID
GROUP BY
	Invoices.VendorID
ORDER BY
	LatestInv DESC;

/*
TABLE VARIABLE
We can create a variable that will store an entire result set. 
We use the same syntax as we do when we create a table using 
CREATE TABLE.
Just like a scalar variable, a table variable has local scope.  
It is only available in the batch where it is declared.
*/
DECLARE @TopVendors TABLE (
	VendorID INT,
	AvgInvoice MONEY
)

INSERT INTO @TopVendors
SELECT 
	TOP 5 VendorID, AVG(InvoiceTotal) AS AvgInvoice
FROM
	Invoices
GROUP BY 
	VendorID
ORDER BY 
	AvgInvoice DESC

SELECT
	Invoices.VendorID, MAX(InvoiceDate) AS LatestInv,
	AVG(InvoiceTotal) AS AvgInvoice
FROM
	Invoices INNER JOIN @TopVendors AS TopVendors ON Invoices.VendorID = TopVendors.VendorID
GROUP BY
	Invoices.VendorID
ORDER BY
	LatestInv DESC;

/*
Doing it using a Temp table
A temporary table exists during the current database session.  
Once you close the script window in SSMS where you created the table, 
that table is no longer available
Local temporary table: Only visible within the current session.  
They are prefixed by #
Global temporary table: Visible in all sessions.  
They are prefixed by ##
*/


IF OBJECT_ID('tempdb.dbo.#TopVendors') IS NOT NULL
	DROP TABLE IF EXISTS #TopVendors

SELECT
	TOP 5 VendorID, AVG(InvoiceTotal) AS AvgInvoice
INTO
	#TopVendors
FROM
	Invoices
GROUP BY
	VendorID
ORDER BY
	AvgInvoice DESC

ALTER TABLE #TopVendors
ADD VendorName VARCHAR(200)

UPDATE #TopVendors SET 
	VendorName = (
		SELECT	
			VendorName
		FROM
			Vendors
		WHERE
			VendorID = #TopVendors.VendorID)

SELECT * FROM #TopVendors

-- Simple While Loop
DECLARE @i INT = 1
WHILE (@i <= 10)
	BEGIN
		PRINT @i
		SET @i += 1
	END
GO

-- while loop with break
DECLARE @i INT = 1
WHILE (@i <= 10)
	BEGIN
		PRINT @i
		SET @i += 1
		IF @i = 4
			CONTINUE
		PRINT 'AFTER CONTINUE' -- NEVER GETS EXECUTED
	END
GO

-- while loop with break and continue
/*