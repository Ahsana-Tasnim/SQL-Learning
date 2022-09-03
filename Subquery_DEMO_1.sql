USE AP;
GO

-- USING SUBQUERIES

/* 
- A subquery is a SELECT statement that is coded withing another SQL Statement

- There are four ways to intorduce a subquery in a SELECT statement
	1. In a WHERE clause as a search condition
	2. In a HAVING clause as a search condition
	(the first 2 are the most common)
	3. In the FROM clause as a table specification
	4. In the SELECT clause as a column specification

Example 1:
Get all of the invoices from the Invoices table that have invoice totals greater than the 
average invoice total of all of the invoices in the Invoices table

*/
SELECT
	InvoiceNUmber,
	InvoiceDate,
	InvoiceTotal
FROM
	Invoices
WHERE
	InvoiceTotal > 
		(SELECT 
			AVG(InvoiceTotal)
		FROM
			Invoices)
ORDER BY
	InvoiceTotal


/* 
In this example, the subquery (inner query) gets evalulated first, and the the outer query 
gets evaluated after
The subquery is returning a single value - a result set
that contains a single column - the average of the invoice totals in 
the invoices table

A few rules: 
	Subqueries must be in parentheses
	They cannot contain an ORDER BY unless TOP is used
	Typically do not include a GROUP BY or HAVING
	They can be nested within other subqueries


Example 2:
Most joins can be replaced by 
subqueries, and most subqueries can be replaced by joins
(The query above cannot be written any other way however)
Here is an example of a query that can be written with a join
and with a subquery:  
We'll retrieve some data from the invoices table where the 
vendor for the invoices is in the state of California
First, using a join
*/
SELECT
	InvoiceNumber,
	InvoiceDate,
	InvoiceTotal
FROM
	Invoices
		INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE
	VendorState = 'CA'
ORDER BY
	InvoiceDate


/* now, using a subquery */
SELECT
	InvoiceNumber,
	InvoiceDate,
	InvoiceTotal
FROM
	Invoices
WHERE 
	VendorID IN
		(SELECT
			VendorID
		FROM
			Vendors
		WHERE
			VendorState = 'CA')
ORDER BY
	InvoiceDate


/*
Which one seems more intuitive to you?

What if we want our result set to include data from the Vendors table;
Can I do that with the second example that uses a subquery?

Advantage of Joins
 - You can include data in your result set from more than 1 table
 - more intuitive when it uses an existing relationship between
   two tables ie: primary key to foreign key relationship
 - usually performs faster than the same query written with a sub query

Advantage of subquery
 - Can be more intiutive - especially with ad hoc relationship
 - complex queries can be easier to code using subqueries


SUBQUERIES IN SEARCH CONDITIONS

IN OPERATOR
Remember in a previous class, we learned about the IN Operator.  It
allows you to specify Multiple values in where clause.  A shortcut
to using OR
For example, we can get all the vendors that are IN specific vendor ids 
*/
SELECT
	*
FROM
	Invoices
WHERE
	VendorID IN (1, 4, 6, 9)


--or NOT IN specific vendor ids
SELECT
	*
FROM
	Invoices
WHERE
	VendorID NOT IN (1, 4, 6, 9)


/*
We can use the IN Operator with subquery.  The list of values
in our IN is replaced with a subquery

First, let's get all of the vendors that do not have invoices
We did this previously using an OUTER JOIN
*/
SELECT
	Vendors.VendorID,
	VendorName,
	VendorState
FROM
	Vendors
		LEFT OUTER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	Invoices.VendorID IS NULL


/*
Now, Let's do the same thing using a subquery
*/
SELECT
	Vendors.VendorID,
	VendorName,
	VendorState
FROM
	Vendors
WHERE
	VendorID NOT IN (
		SELECT 
			DISTINCT VendorID
		FROM
			Invoices)


/*
The subquery above returns a single column.  This is a MUST
when a subquery is used with the IN operator

We want to make sure we include DISTINCT.  SQL Server will
allow you to omit it, however, other DBMS may not

I find the subquery version more readable than the OUTER JOIN in this
case.

COMPARISION MODIFIERS
Used in a search condition to compare an expression with the results of the subquery

Using >, <, =, <> operators, the subquery must return a single value.
ie: Get all the invoices that have a balnce due AND that 
balance due is less than the average balance due of all invoices
First, the subquery will return what the average balance due of all invoices is, 
and then we will use that in our WHERE search condition and retrieve all of the 
invoices that have a balance due less than that average
*/
SELECT
	InvoiceNumber,
	InvoiceDaTe,
	InvoiceTotal,
	InvoiceTotal - PaymentTotal - CreditTotal AS 'Balance Due'
FROM
	Invoices
WHERE
	InvoiceTotal - PaymentTotal - CreditTotal > 0
	AND InvoiceTotal - PaymentTotal - CreditTotal <
	(SELECT	
		AVG(InvoiceTotal - PaymentTotal - CreditTotal)
	FROM
		Invoices
	WHERE
		InvoiceTotal - PaymentTotal - CreditTotal > 0)
ORDER BY
	InvoiceTotal DESC


/*
Remember, when using those compairison operators, the subtotal must only
return a single value

We can use the ANY, SOME and ALL keywords to compare a column value to a
list of values - the subquery can return a list of values

ANY and SOME - these are the same thing - ANY is more commonly used
We use the ANY keyword to test that a condition is true for one
or more of the values returned by the subquery.

Let's retrieve the invoices that are smaller than the largest
invoice for vendor 115
*/
SELECT
	VendorName,
	InvoiceNumber,
	InvoiceTotal
FROM
	Vendors 
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	InvoiceTotal < ANY
	(SELECT 
		InvoiceTotal
	FROM
		Invoices
	WHERE
		VendorID = 115)


-- To me, it makes far more sense to do this...so, you won't see ANY used very often
SELECT
	VendorName,
	InvoiceNumber,
	InvoiceTotal
FROM
	Vendors 
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	InvoiceTotal <
	(SELECT	
		MAX(InvoiceTotal)
	FROM
		Invoices
	WHERE
		VendorID = 115)


/*
ALL keyword
We use the ALL keyword to test that a comparision is true for ALL
of the values returned by a subquery

Refer to table on page 193 of textbook

Write a query that returns invoices larger than the largest invoice
for vendor 34
*/
SELECT
	VendorName,
	InvoiceNumber,
	InvoiceTotal
FROM
	Vendors 
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	InvoiceTotal > ALL
	(SELECT	
		MAX(InvoiceTotal)
	FROM
		Invoices
	WHERE
		VendorID = 34)


/*
The above is wacky to me. It was in the book. I would write it like this,
as they also show you in the book
*/
SELECT
	VendorName,
	InvoiceNumber,
	InvoiceTotal
FROM
	Vendors 
		INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE
	InvoiceTotal <
	(SELECT	
		InvoiceTotal
	FROM
		Invoices
	WHERE
		VendorID = 34)

