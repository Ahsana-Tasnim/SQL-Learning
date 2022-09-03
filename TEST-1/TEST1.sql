-- 30
SELECT
	FirstName,
	LastName,
	Address,
	HomePhone,
	DOB,
	GPA
FROM	
	Student
WHERE
	GPA > 3.0
ORDER BY
	GPA,
	LastName


--- 31
SELECT
	LastName + ', ' + FirstName AS 'Employee Name',
	(TotalSales * 0.1) + BaseSalary AS 'Total Pay'
FROM	
	Consultant
WHERE
	((TotalSales * 0.1) + BaseSalary > 42000)
	AND Job = 'Sales'


-- 32
UPDATE 
	Consultant
SET
	Job = 'Sales'
WHERE
	FirstName = 'Freddy'
	AND LastName = 'Kruger'


-- 33
DELETE 
	Consultant
WHERE
	LastName = 'Flinstone'
	AND FirstName = 'Fred'


-- 34
INSERT INTO 
	Consultant
	
VALUES
	('Barney', 'Rubble', 23000, 'Sales', 0.25, 0)


