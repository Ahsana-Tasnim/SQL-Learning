USE AP;
GO

/* STRING FUNCTIONS */

/* LEN(string)
Returns the number of characters in the string.  Leading spaces
are included, but trailing spaces are not*/
DECLARE @Name VARCHAR(50)
SET @Name = 'Ahsana '
PRINT LEN(@Name)
SET @Name = ' Ahsana'
PRINT LEN(@Name)
SET @Name = 'Ahsana '
PRINT LEN(@Name)

/*
LTRIM(string) - returns the string with leading spaces removed
RTRIM(string) - returns the string with trailing spaces removed
*/
DECLARE @CourseName VARCHAR(50)
SET @CourseName = '  Intermediate SQL  '
PRINT '|' + LTRIM(@CourseName) + '|'
PRINT '|' + RTRIM(@CourseName) + '|'
PRINT '|' + LTRIM(RTRIM(@CourseName)) + '|'

/*
LEFT(string,length) 
- returns the specified number of characters from the
  beginning of string
RIGHT(string,length) 
- returns the specified number of characters from the
  end of string
*/
SELECT
	VendorName,
	LEFT(VendorName, 2),
	RIGHT(Vendorname, 2)
FROM
	Vendors

/*
SUBSTRING(string,start,length) 
- Returns the sepcified number of characters from
  string starting at the specified position
*/
SELECT
	VendorName,
	SUBSTRING(VendorName, 3, 6)
FROM
	Vendors

/*
REPLACE(search,find,replace) 
- Returns the search string with all occurences
  of the find string replaced with the replace string
*/
SELECT
	VendorName,
	REPLACE(VendorName, 'e', 'ZZZZ')
FROM
	Vendors

/*
REVERSE(string)
- returns the string in reverse order
*/
SELECT
	VendorName,
	REVERSE(VendorName)
FROM
	Vendors

/*
CHARINDEX(find,search[,start])
- Like indexOf in C#
- Returns an integer of the position of the first 
  occurrence of the "find string" in the "search" string
  starting at the specified position (position starts at 1)
  If the string is not found, it returns 0
  If start position is not specified, it starts at position 1
*/
SELECT
	VendorName,
	CHARINDEX('ey', VendorName)
FROM
	Vendors

/*
PATINDEX(find,search)
- same as CHARINDEX except you can use wildcard characters,
and you cannot choose the starting position
*/
SELECT
	VendorName,
	PATINDEX('%[o, O]office%', VendorName)
FROM
	Vendors

/*
CONCAT(value1,value2[,value3]...)
- returns a string with the concatenated values
*/
SELECT
	CONCAT(VendorName, ' ', VendorCity, ' ', VendorState)
FROM
	Vendors

/*
LOWER(string)
UPPER(string)
- same as ToUpper and ToLower in c#
*/
SELECT
	VendorName,
	LOWER(VendorName),
	UPPER(VendorName)
FROM
	Vendors

/*
SPACE(integer)
- returns a string with the specified number of space characters
*/
PRINT '|' + SPACE(30) + '|'

/*
NUMERIC FUNCTIONS
*/
/*
ROUND(number,length[,function])
- returns the number rounded to the precision specified by length
  if length is positive, digits to the right of decimal
  are rounded.  If length is negative, digits to the left of
  decimal are rounded
  - use the "function" parameter to truncate a number instead of
  round it, by coding a non-zero value for "function"
*/
SELECT ROUND(15.49, 1)

/*
ISNUMERIC(expression)
- returns a value of 1 (true) if expression is numeric,
  and 0 (false) if it is not
*/
SELECT
	VendorName,
	ISNUMERIC(VendorName),
	ISNUMERIC(VendorID)
FROM
	Vendors
	   
/*
CEILING(number)
- returns the largest integer that is greater than or
  equal to the number
FLOOR(number)
- returns the smallest integer that is greater than or
  equal to the number
*/
SELECT 
	CEILING(4.25)
SELECT
	FLOOR(4.25)

/* DATE/TIME FUNCTIONS */
/*
GETDATE() - returns the current date/time
DAY(date) - returns the day of the month as an integer
MONTH(date) - returns the month as an integer
YEAR(date) - returns the year as an integer
*/
SELECT
	GETDATE()
SELECT
	DAY(GETDATE())
SELECT
	MONTH(GETDATE())
SELECT
	YEAR(GETDATE())

/*
DATEADD(datepart,number,enddate)
- returns the date that results from adding the
specified number of datepart units to the date
*** datepart can be month, year, day, and others including
abbreviations - look it up when you need it
*/
SELECT
	DATEADD(M, 2, GETDATE())
--------------------------------------
-- SELECT
--	DATEADD(mm, 2, GETDATE())

-- returns the date 2 months from the current date

/*
DATEDIFF(datepart,startdate,enddate)
-- returns the number of datepart units between the specified
start and end dates
*/
SELECT
	DATEDIFF(SECOND, GETDATE(), '2022-02-18')

/*
CASE function
- similar to c# switch
simple CASE function
*/
SELECT
	InvoiceNumber,
	TermsID,
	CASE TermsID
		WHEN 1 THEN 'Net due 10 days'
		WHEN 2 THEN 'Net due 20 days'
		WHEN 3 THEN 'Net due 30 days'
		WHEN 4 THEN 'Net due 40 days'
		WHEN 5 THEN 'Net due 50 days'
	END Terms
FROM
	Invoices

-- searched CASE function
SELECT 
	VendorName,
	CASE	
		WHEN LEN(VendorName) > 50
			THEN 'Length of vendor name is greater than 50'
		WHEN LEN(VendorName) > 20
			THEN 'Length of vendor name is greater than 20'
		ELSE	
			'Other length message'
	END AS LengtOfName
FROM
	Vendors