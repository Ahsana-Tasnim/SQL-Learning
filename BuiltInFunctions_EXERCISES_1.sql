USE AP;
GO

--- Exercise 1 - Page 300 ---
SELECT
	VendorContactFName + ' ' + LEFT(VendorContactLName, 1) + '.' AS Contact,
	--SUBSTRING(VendorPhone, 7,8) AS Phone
	REPLACE(VendorPhone, '(559) ', '') AS Phone
FROM
	Vendors
WHERE
	LEFT(VendorPhone, 4) = '(559'
ORDER BY
	Contact
	   	 
--- Exercise 2 - Page 300 ---
SELECT
	InvoiceNumber,
	InvoiceTotal - CreditTotal - PaymentTotal AS Balance
FROM
	Invoices
WHERE
	InvoiceTotal - CreditTotal - PaymentTotal > 0
	AND InvoiceDueDate < GETDATE() + 30

--- Exercise 3 - Page 300 ---
SELECT
	InvoiceNumber,
	InvoiceTotal - CreditTotal - PaymentTotal AS Balance
FROM
	Invoices
WHERE
	InvoiceTotal - CreditTotal - PaymentTotal > 0
	AND InvoiceDueDate < CAST(CAST(YEAR(GETDATE())) AS CHAR(4)) + '-' +
		CAST(MONTH(GETDATE()) + 1 AS CHAR(2)) + '-01' AS DATETIME) -1;



SELECT
	InvoiceNumber,
	InvoiceTotal - CreditTotal - PaymentTotal AS 'Balance Due'
FROM
	Invoices
WHERE
	InvoiceTotal - CreditTotal - PaymentTotal <> 0 AND
	DATEDIFF(DAY, GETDATE(), InvoiceDueDate) < DATEDIFF(DAY, GETDATE(), EOMONTH(GETDATE()))

