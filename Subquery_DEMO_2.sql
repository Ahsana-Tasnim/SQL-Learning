USE AP;
GO
/*
Up until now, we have created subqueries that are executed
only once for the entire query.

Now we will be looking at subqueries that are executed once
for each row that is processed by the outer query.

Retreive each invoice that is higher than the vendor's average
*/
USE AP;
GO
SELECT
	VendorId,
	InvoiceNumber,
	InvoiceTotal
FROM
	Invoices AS InvOuter
WHERE
	InvoiceTotal > (
		SELECT 
			AVG(InvoiceTotal)
		FROM
			Invoices AS InvInner
		WHERE
			InvInner.VendorID = InvOuter.VendorID)
ORDER BY
	VendorID,
	InvoiceTotal


/*
What happened here?
1. The Outer query passed a value for VendorID to the Inner query.  
You can see that in the WHERE clause of the Inner query (the subquery).

2. The subquery uses the vendorid that is passed in to look up the 
average invoice total for that vendor

3. When the average invoice total is found for that vendor, it is returend to the 
outer query

When the row is found the engine temporarily holds it in memory

4.  The engine moves onto the next row and repeats steps 1-3

5.  When all vendors have been evalulated, the results are returned


Because our subquery used the same name 
as the outer query, an alias or correlation name
must be assigned to the tables

Another example...Get the most recent order for each employee
*/
USE Northwind;
GO

SELECT
	OrderId,
	CustomerId,
	EmployeeId,
	OrderDate,
	RequiredDate
FROM
	Orders AS OrdersOuter
WHERE
	OrderDate = (
		SELECT	
			MAX(OrderDate)
		FROM
			Orders OrdersInner
		WHERE
			OrdersInner.EmployeeID = OrdersOuter.EmployeeID)


/*
Test our query by checking to see what the most recent date for an order is for employee 5
and make sure it is the same as the date retrieved in the above query for employee 5
*/
SELECT
	MAX(OrderDate)
FROM
	Orders 
WHERE
	EmployeeID = 5
	   	  

/*
Another example...return a list of products and the largest order ever placed for each product
*/
SELECT DISTINCT
	p.ProductID,
	ProductName,
	Quantity
FROM
	[Order Details] AS od1
		INNER JOIN Products AS p ON od1.ProductID = p.ProductID
WHERE
	Quantity = (
		SELECT	
			MAX(Quantity)
		FROM
			[Order Details] od2
		WHERE
			od1.ProductID = od2.ProductID)
ORDER BY
	ProductName


/*
Test by retrieving the maximum for productid = 17
*/
-- SELECT * FROM Products [Order Details] WHERE ProductID = 17 ORDER BY Quantity DESC
SELECT MAX(Quantity) FROM [Order Details] WHERE ProductID = 17


/*
Get the termsdescription for Terms that a have more than 2 invoices assigned to it
*/
USE AP;
GO


-- first using HAVING
SELECT
	TermsDescription
FROM
	Terms
		INNER JOIN Invoices ON Terms.TermsID = Invoices.TermsID
GROUP BY
	TermsDescription
HAVING 
	COUNT(*) > 10


-- then using subquery
SELECT
	TermsDescription
FROM
	Terms
WHERE (
	SELECT	
		COUNT(*)
	FROM
		Terms
	WHERE
		TermsID = Terms.TermsID) > 10

/*

USING EXISTS

The EXISTS operator tests whether or not the subquery returns a result set.
The subquery doesn't actually return a result set to the outer query
It just returns a true or a false...do any rows meet the specified condition or not
Since no rows are returned, we can just use *

Retrieve all vendors that do not have invoices

We did this in a previous using the NOT IN keyword
*/
SELECT
	VendorID,
	VendorName,
	VendorState
FROM
	Vendors
WHERE
	VendorID NOT IN (
		SELECT 
			VendorID
		FROM
			Invoices)

/*
using EXISTS keyword
*/
SELECT
	VendorID,
	VendorName,
	VendorState
FROM
	Vendors
WHERE
	NOT EXISTS (
		SELECT
			* 
		FROM
			Invoices
		WHERE
			VendorID = Vendors.VendorID)			   			 		  

/*
EXISTS would execute quicker than IN IF The results of the subquery were very large,
Otherwise, IN would be quicker
*/

