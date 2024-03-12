DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;

-- PROBLEM STATEMENT: Write a sql query to return the footer values from input table, meaning all the last non null values from each field as shown in expected output.

-- Method 1 
SELECT * FROM (
SELECT car FROM FOOTER WHERE car IS NOT NULL ORDER BY id DESC LIMIT 1) Cars 
CROSS JOIN (SELECT length FROM FOOTER WHERE length IS NOT NULL ORDER BY id DESC LIMIT 1) Lenght 
CROSS JOIN (SELECT width FROM FOOTER WHERE width IS NOT NULL ORDER BY id DESC LIMIT 1) Width 
CROSS JOIN (SELECT height FROM FOOTER WHERE height IS NOT NULL ORDER BY id DESC LIMIT 1) Height ;

-- Method 2 

WITH CTE AS (
			SELECT *,
			SUM( CASE WHEN car IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS 'Car_Segment',
			SUM( CASE WHEN length IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS 'Length_Segment',
			SUM( CASE WHEN width IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS 'Width_Segment',
			SUM( CASE WHEN height IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS 'Height_Segment'
			FROM FOOTER ) 
			
SELECT 
FIRST_VALUE(car) OVER(PARTITION BY Car_Segment ORDER BY id ) AS 'New_Car',
FIRST_VALUE(length) OVER(PARTITION BY Length_Segment ORDER BY id ) AS 'New_Length',
FIRST_VALUE(width) OVER(PARTITION BY Width_Segment ORDER BY id ) AS 'New_Width',
FIRST_VALUE(height) OVER(PARTITION BY Height_Segment ORDER BY id ) AS 'New_Height'
FROM CTE 
ORDER BY id DESC 
LIMIT 1 













