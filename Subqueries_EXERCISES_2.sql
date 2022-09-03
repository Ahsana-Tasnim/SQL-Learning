USE HR;
GO
/*
1.Get all employees with a salary higher than the average 
salary of their department (HINT: Correlated Subquery)
*/
SELECT
	last_name,
	first_name,
	salary
FROM
	employees emp1
WHERE
	emp1.salary > (
		SELECT	
			AVG(salary)
		FROM
			employees emp2
		WHERE
			emp1.department_id = emp2.department_id)

/*
2.Get the names of the departments that have more than 
3 employees (Use Correlated Subquery)
*/
SELECT
	department_name
FROM	
	departments
WHERE (
	SELECT	
		COUNT(*)
	FROM
		employees
	WHERE
		employees.department_id = departments.department_id) > 3
ORDER BY
	department_name

-- Do the same as above but this time using HAVING 
SELECT
	department_name
FROM	
	departments
		INNER JOIN employees ON departments.department_id = employees.department_id
GROUP BY
	department_name
HAVING 
	COUNT(*) > 3
ORDER BY
	department_name

/*
3.Get all employees who also manage other employees.  
Return the employee id, manager id, first namd and last name.
Use EXISTS
*/
SELECT
	employee_id,
	manager_id,
	first_name,
	last_name
FROM	
	employees e1
WHERE
	EXISTS (
		SELECT 
			*
		FROM
			employees e2
		WHERE
			e2.manager_id = e1.manager_id)

/*
4.Get all the Order IDs where the customer did not purchase more than
10% of the average quantity sold for a given product (HINT: Correlated Subquery)
*/
USE NORTHWIND;
GO

SELECT
	DISTINCT OrderID
FROM
	[Order Details] od1
WHERE
	Quantity <= (
		SELECT	
			AVG(Quantity) * .1
		FROM
			[Order Details] od2
		WHERE
			od2.ProductID = od1.ProductID)
ORDER BY
	OrderID

/*
6.a list of orders and their customers 
who ordered more than 20 items of product Grandma's 
Boysenberry Spread (ProductID 6) on a single order.
*/
SELECT
	OrderID,
	CustomerID
FROM
	Orders O
WHERE (
	SELECT	
		Quantity
	FROM
		[Order Details] OD
	WHERE
		O.OrderID = OD.OrderID
		AND OD.ProductID = 6) > 20

-- do same thing as above using a HAVING
SELECT
	O.OrderID,
	O.CustomerID
FROM
	Orders O
		INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE
	OD.ProductID = 6
GROUP BY
	O.OrderID,
	O.CustomerID
HAVING
	SUM(Quantity) > 20

/*
7.Return a list of customers who's products
where NOT shipped to the UK.  Use EXISTS
*/
SELECT
	CustomerID,
	CompanyName
FROM
	Customers C
WHERE NOT EXISTS (
	SELECT
		*
	FROM
		Orders O
	WHERE
		C.CustomerID = O.CustomerID
		AND ShipCountry = 'UK')
