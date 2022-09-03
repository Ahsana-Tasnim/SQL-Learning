USE AP;
GO

-- 1. Create a report that lists the VendorCity and the number of vendors
-- in each city
SELECT
	VendorCity,
	COUNT(*) AS '# of vendors'
FROM
	Vendors
GROUP BY
	VendorCity

USE AP;
GO
-- 2. Create a report that shows the sum of the invoices by invoice date. 
-- Display the Invoice Date and InvoiceTotal
SELECT
	InvoiceDate,
	SUM(InvoiceTotal) AS 'Total $ Orders'
FROM
	Invoices
GROUP BY
	InvoiceDate

USE AP;
GO
-- 3. Create a report that shows the average invoice total by 
-- vendor.  Display the VendorName and the average.
SELECT
	VendorName,
	AVG(InvoiceTotal) AS 'Average Invoice Total'
FROM
	Vendors
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
GROUP BY
	VendorName
ORDER BY
	'Average Invoice Total' DESC

USE AP;
GO
-- 4. Create a report that shows the vendor name 
-- and the number of invoices they have placed
SELECT
	VendorName,
	VendorCity,
	VendorPhone,
	COUNT(*) AS '# Invoices'
FROM
	Vendors
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
GROUP BY
	VendorName,
	VendorCity,
	VendorPhone
		
USE AP;
GO
-- 5. create a report that shows the total of all invoices 
-- (invoice total) by invoice date and 
-- Vendor state
SELECT
	InvoiceDate,
	Vendors.VendorState,
	SUM(InvoiceTotal) AS 'Invoice Total'
FROM
	Invoices
		INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
GROUP BY
	InvoiceDate,
	Vendors.VendorState
ORDER BY
	InvoiceDate,
	Vendors.VendorState

USE AP;
GO
-- 6. Create a report that lists the City and the number of vendors
-- in each city.  Only include the cities with at least 2 vendors
SELECT
	VendorCity,
	COUNT(*) AS '# of vendors'
FROM
	Vendors
GROUP BY
	VendorCity
HAVING
	COUNT(*) > 5

USE AP;
GO
-- 7. Create a report that shows the sum of the invoices by invoice date.  Only include the 
-- dates that that have invoices totalling more than 2000
SELECT
	InvoiceDate,
	SUM(InvoiceTotal) AS 'Total $ Orders'
FROM
	Invoices
GROUP BY
	InvoiceDate
HAVING
	SUM(InvoiceTotal) > 2000		

-- 8. Create a report that shows the sum of the invoices by invoice date.  Only include the 
-- dates that that have invoices totalling more than 2000. Also, only include vendors
-- in the states of CA, VA, NY
SELECT
	InvoiceDate,
	SUM(InvoiceTotal) AS 'Total $ Orders'
FROM
	Invoices
		INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE
	VendorState IN ('CA', 'VA', 'NY')
GROUP BY
	InvoiceDate
HAVING
	SUM(InvoiceTotal) > 2000	
ORDER BY
	InvoiceDate