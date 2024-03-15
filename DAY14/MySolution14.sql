DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice (
    serial_no INT,
    invoice_date DATE
);

INSERT INTO invoice VALUES (330115, '2024-03-01');
INSERT INTO invoice VALUES (330120, '2024-03-01');
INSERT INTO invoice VALUES (330121, '2024-03-01');
INSERT INTO invoice VALUES (330122, '2024-03-02');
INSERT INTO invoice VALUES (330125, '2024-03-02');

SELECT * FROM invoice;

/*In the given input table, some of the invoice are missing, write a sql query to identify the missing serial no. 
As an assumption, consider the serial no with the lowest value to be the first generated invoice 
and the highest serial no value to be the last generated invoice.*/

-- Solution 1 
SELECT generate_series(min(serial_no),max(serial_no)) AS 'Missing_Invoices'
FROM invoice
EXCEPT 
SELECT serial_no FROM invoice;

-- Solution 2 
WITH RECURSIVE CTE AS 
(SELECT MIN(serial_no) AS n FROM invoice
UNION 
SELECT n+1 AS n FROM CTE
WHERE n<(SELECT MAX(serial_no) FROM invoice))
SELECT * FROM CTE
EXCEPT 
SELECT serial_no FROM invoice;

-- Note: MySql not support EXCEPT and generate_serial !


