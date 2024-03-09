drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

-- Write an sql query to merge products per customer for each day as shown in expected output.

SELECT dates, 
       CAST(product_id AS CHAR) AS Products 
FROM orders
UNION ALL
SELECT dates,
       GROUP_CONCAT(CAST(product_id AS CHAR) SEPARATOR ',') AS Products 
FROM orders
GROUP BY customer_id, dates
ORDER BY dates, Products;















