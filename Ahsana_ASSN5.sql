
DROP DATABASE IF EXISTS MyWebDB;
GO

CREATE DATABASE MyWebDB;
GO

USE MyWebDB;
GO

CREATE TABLE Users (
	UserID INT NOT NULL PRIMARY KEY IDENTITY,
	EmailAddress NVARCHAR(100),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
	ProductID INT NOT NULL PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(100) NOT NULL
);

CREATE TABLE Downloads (
	DownloadID INT PRIMARY KEY NOT NULL IDENTITY,
	UserID INT NOT NULL,
	DownloadDate DATETIME2 NOT NULL,
	[FileName] NVARCHAR(256),
	ProductID INT NOT NULL,
	CONSTRAINT FK_Downloads_Users FOREIGN KEY (UserID) REFERENCES Users (UserID),
	CONSTRAINT FK_Downloads_Products FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
GO

INSERT INTO Users
VALUES
	('johnsmith@gmail.com', 'John', 'Smith'),
	('janedoe@yahoo.com', 'Jane', 'Doe');

	INSERT INTO Products
	VALUES
		('Local Mucic Vol 1'),
		('Local Music Vol 2');

	INSERT INTO Downloads
	VALUES
		(1, GETDATE(), 'one_hours_town.mp3', 2),
		(2, GETDATE(), 'petals_are_falling.mp3', 1),
		(2, GETDATE(), 'turn_signal.mp3', 2);

SELECT 
	EmailAddress,
	FirstName,
	LastName,
	DownloadDate,
	[FileName],
	ProductName
FROM
	Users
		INNER JOIN Downloads ON Users.UserID = Downloads.UserID
		INNER JOIN Products ON Downloads.ProductID = Products.ProductID
ORDER BY
	EmailAddress DESC,
	ProductName ASC;

GO

ALTER TABLE Products
ADD 
	Price DECIMAL(5,2) DEFAULT 9.99,
	DateAdded DATETIME2;
GO

INSERT INTO Products (Productname, DateAdded)
VALUES('Test Product', GETDATE());

SELECT * FROM Products;

ALTER TABLE Users
ALTER COLUMN Firstname NVARCHAR(20) NOT NULL;
GO

UPDATE Users SET FirstName = NULL;

UPDATE Users SET FirstName = 'aaaaaaaaaaaaaaaaaaaaa';

GO