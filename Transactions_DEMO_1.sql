USE AP;
GO
/*
You may have a series of sql statements who's results depend on each other.
*/
DECLARE @InvoiceID INT;
INSERT INTO Invoices VALUES(
	34,'ZXA-080','2016-04-30',14092.59,0,0,3,'2016-05-30',NULL);
SET @InvoiceID = SCOPE_IDENTITY();
INSERT INTO InvoiceLineItems VALUES(@InvoiceID, 1, 160, 4447.23, 'HW upgrade');
INSERT INTO InvoiceLineItems VALUES(@InvoiceID, 2, 167, 9645.36, 'HW upgrade');
GO

/*
If the first statement that inserts the invoice is successful, and the 2nd or 3rd are not
do we want the that invoice that got inserted by the first statement to exist in our database without the child records (invoice line items) that we insert in the 2nd and 3rd quereis?
No...and we can prevent that by including the statements in a transaction
*/
DECLARE @InvoiceID INT;
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Invoices VALUES(
			34,'ZXA-080','2016-04-30',14092.59,0,0,3,'2016-05-30',NULL);
		SET @InvoiceID = SCOPE_IDENTITY();
		INSERT INTO InvoiceLineItems VALUES(@InvoiceID, 1, 160, 4447.23, 'HW upgrade');
		INSERT INTO InvoiceLineItems VALUES(@InvoiceID, 2, 167, 9645.36, 'HW upgrade');
		COMMIT TRAN; -- IF NOR ERROR IS RAISED, THIS LINE WILL BE EXECUTED AND THE 3 STATEMENTS ABOOVE WILL BE COMMITTED TO THE DATABASE
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
	ROLLBACK TRAN; --IF ONE OR MORE OF THE STATEMENTS IN THE TRY RAISED AN ERRO, THEN ANY STATEMNET THAT WAS SUCCESSFUL WILL BE UNDONE (ROLLBACK)
	;THROW
END CATCH

