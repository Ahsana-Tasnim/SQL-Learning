/*
1. Using MurachCollege, write a SELECT statement that returns one row for each department that has instructors with these columns:
   * The DepartmentName column from the Departments table
   * The count of the instructors in the Instructors table
   * The annual salary of the highest paid instructor in the Instructors table
Sort the result set so the department with the most instructors appears first.
*/
SELECT
	DepartmentName,
	COUNT(*),
	MAX(AnnualSalary)
FROM
	Instructors
		INNER JOIN Departments ON Instructors.DepartmentID = Departments.DepartmentID
GROUP BY
	DepartmentName

/*
2. Using MurachCollege,	write a SELECT statement that returns one row for each instructor that has courses with these columns:
   * The instructor first and last names from the Instructors table in this format: John Doe (Note: If the instructor first name has a null value, the concatenation of the first and last name will result in a null value.)
   * A count of the number of courses in the Courses table
   * The sum of the course units in the Courses table
(Hint: You will need to concatenate the instructor first and last names again in the GROUP BY clause.)
Sort the result set in descending sequence by the total course units for each instructor.
*/
SELECT
	FirstName + ', ' + LastName,
	COUNT(*),
	SUM(CourseUnits)
FROM	
	Courses
		INNER JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID
		INNER JOIN Instructors ON Departments.DepartmentID = Instructors.DepartmentID
GROUP BY
	FirstName + ', ' + LastName
ORDER BY
	SUM(CourseUnits) DESC

/*
3.Using MurachCollege,	write a SELECT statement that returns one row for each course that has students enrolled with these columns:
   * The DepartmentName column from the Departments table
   * The CourseDescription from the Courses table
   * A count of the number of students from the StudentCourses table
Sort the result set by DepartmentName, then by the enrollment for each course.
*/
SELECT
	DepartmentName,
	CourseDescription,
	COUNT(*) AS Enrollment
FROM	
	StudentCourses
		INNER JOIN Courses ON StudentCourses.CourseID = Courses.CourseID
		INNER JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID
GROUP BY
	DepartmentName,
	CourseDescription
ORDER BY
	DepartmentName,
	Enrollment

/*
4.	Using MurachCollege, write a SELECT statement that returns one row for each student that has courses with these columns:
   * The StudentID column from the Students table
   * The sum of the course units in the Courses table
Sort the result set in descending sequence by the total course units for each student.
*/
SELECT
	Students.StudentID,
	SUM(CourseUnits)
FROM	
	Courses
		INNER JOIN StudentCourses ON Courses.CourseID = StudentCourses.CourseID
		INNER JOIN	Students ON StudentCourses.StudentID = Students.StudentID
GROUP BY
	Students.StudentID
ORDER BY
	SUM(CourseUnits) DESC

/*
5.	Modify the solution to exercise 5 so it only includes students who haven’t graduated and who are taking more than nine units.
*/
SELECT
	Students.StudentID,
	SUM(CourseUnits)
FROM	
	Courses
		INNER JOIN StudentCourses ON Courses.CourseID = StudentCourses.CourseID
		INNER JOIN	Students ON StudentCourses.StudentID = Students.StudentID
WHERE
	GraduationDate IS NULL
GROUP BY
	Students.StudentID
HAVING
	SUM(CourseUnits) > 9
ORDER BY
	SUM(CourseUnits) DESC

-- 6. Using NORTHWIND,create a report that shows the customer company name and the number of orders they have placed
-- Only include customers from Germany that have place MORE than 8 orders.
USE Northwind;
GO

SELECT
	CompanyName,
	COUNT(*)
FROM
	Customers
	INNER JOIN Orders ON Customers.CustomerID = Orders.OrderID
WHERE
	UPPER(Customers.Country) = 'GERMANY'
GROUP BY
	CompanyName
HAVING
	COUNT(*) > 8
