USE AP;
GO
/*
A trigger is a special type of procedure that’s invoked, or fired, automatically when an action query Is executed on a table or view.

We an use them to implement business logic, enforce design rules, and prevent data inconsistency, however, there are usually better ways to accomplish these so we should use them sparingly.

Triggers are defined to fire for an insert, update or delete operation (action queries)

Two Types:
AFTER trigger – trigger fires AFTER the action query.  You will commonly see these written using the FOR keywrod.  
INSTEAD OF trigger – fires INSTEAD OF the action query
 

After trigger Example
This trigger will ensure the state code being inserted Uppercase
*/
CREATE TRIGGER Vendors_INSERT_UPDATE
	ON Vendors
	AFTER INSERT, UPDATE --after an insert or update to vendors, this code will run
AS
	UPDATE Vendors
	SET VendorState = UPPER(VendorState)
	WHERE VendorID IN (SELECT VendorID FROM Inserted)
GO

/*
after an insert or update to vendors, this code will run.
Notice the FROM Inserted.  the "Inserted" table is created by the system, and it contains the new rows for insert and update operations

Firing the trigger - The trigger will fire when an insert or update is done on the Vendors table
In this insert statement, the state is set at 'Oh'.  After we run this query, the trigger should change that to 'OH'
*/
INSERT INTO Vendors VALUES(
'Peerless Uniforms, Inc.', '785 S Pixley Rd', NULL, 'Piqua', 'Oh', '45356', '(937) 555-8845', null, null, 4, 550);
GO

/*
Another example
When an invoice is deleted, add it to the invoicearchive table
*/
CREATE TRIGGER Invoices_DELETE
	ON Invoices
	AFTER DELETE
AS
INSERT INTO InvoiceArchive
	(InvoiceID, VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal, CreditTotal, TermsID, InvoiceDueDate, PaymentDate)
	SELECT InvoiceID, VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal, CreditTotal, TermsID, InvoiceDueDate, PaymentDate
	FROM Deleted
GO

-- notice the table this time is called Deleted, not Inserted
DELETE FROM Invoices
WHERE VendorID = 37

/*
Question 8 Chapter 15
*/
CREATE TABLE ShippingLabels
	(VendorName varchar(50),
	VendorAddress1 varchar(50),
	VendorAddress2 varchar(50),
	VendorCity varchar(50),
	VendorState char(2),
	VendorZipCode varchar(20));

GO

CREATE TRIGGER Invoices_Update_Shipping
	ON INvoices
	AFTER INSERT, UPDATE
AS
	INSERT INTO ShippingLabels
	SELECT VendorName, VendorAddress1, VendorAddress2,
		VendorCity, VendorState, VendorZipCode
	FROM
		Vendors INNER JOIN Inserted ON Vendors.VendorID = Inserted.VendorID
	WHERE
		Inserted.InvoiceTotal - Inserted.PaymentTotal - Inserted.CreditTotal = 0
GO

UPDATE Invoices SET
	PaymentTotal = 67.92, PaymentDate = '2022-02-09'
WHERE
	InvoiceID = 100
