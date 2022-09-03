USE AP;
GO

/*
1. Exercise 1 from page 212 of book
*/ 
--FROM THE BOOK
--SELECT DISTINCT VendorName 
--FROM Vendors JOIN Invoices 
--ON Vendors.VendoriD = Invoices. VendoriD 
--ORDER BY VendorName;


SELECT
	VendorName
FROM
	Vendors
WHERE
	VendorID IN (
		SELECT DISTINCT
			VendorID
		FROM
			Invoices)
ORDER BY
	VendorName


/*
2. Exercise 2 from page 212 of book
*/
SELECT
	InvoiceNumber,
	InvoiceTotal
FROM
	Invoices
WHERE
	PaymentTotal > (
		SELECT	
			AVG(PaymentTotal)
		FROM
			Invoices
		WHERE
			PaymentTotal <> 0)


USE MurachCollege;
GO
/*
3.	Write a SELECT statement that returns the same result set as 
this SELECT statement, but don’t use a join. Instead, use a subquery 
in a WHERE clause that uses the IN keyword.

SELECT DISTINCT LastName, FirstName
FROM Instructors i JOIN Courses c
  ON i.InstructorID = c.InstructorID
ORDER BY LastName, FirstName
*/
SELECT
	LastName,
	FirstName
FROM
	Instructors
WHERE
	InstructorID IN (
		SELECT DISTINCT
			InstructorID
		FROM
			Courses)
ORDER BY
	LastName,
	FirstName


/*
2.	Write a SELECT statement that answers this question: Which instructors have an annual 
salary that’s greater than the average annual salary for all instructors?
Return the LastName, FirstName, and AnnualSalary columns for each Instructor.
Sort the result set by the AnnualSalary column in descending sequence.
*/
SELECT
	LastName,
	FirstName,
	AnnualSalary
FROM
	Instructors
WHERE
	AnnualSalary > (
		SELECT	
			AVG(AnnualSalary)
		FROM
			Instructors)
ORDER BY
	AnnualSalary DESC

