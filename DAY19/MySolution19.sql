DROP TABLE IF EXISTS pizza_delivery;
CREATE TABLE pizza_delivery 
(
	order_id 			INT,
	order_time 			TIMESTAMP,
	expected_delivery 	TIMESTAMP,
	actual_delivery 	TIMESTAMP,
	no_of_pizzas 		INT,
	price 				DECIMAL
);

select * from pizza_delivery;

-- Given table showcases details of pizza delivery order for the year of 2023.
-- If an order is delayed then the whole order is given for free. Any order that takes 30 minutes more than the expected time is considered as delayed order. 
-- Identify the percentage of delayed order for each month and also display the total no of free pizzas given each month.

-- POSTGRESQL
SELECT TO_CHAR(order_time,'Mon-YYYY') AS period,
    CONCAT(ROUND((CAST(SUM(CASE WHEN CAST(TO_CHAR(actual_delivery-order_time,'MI') AS INT) > 30 
            THEN 1 ELSE 0 END) AS DECIMAL)
    / COUNT(1)) * 100, 1),'%') AS delayed_order_perc,
    SUM(CASE WHEN CAST(TO_CHAR(actual_delivery-order_time,'MI') AS INT) > 30 
            THEN no_of_pizzas ELSE 0 END) AS free_pizzas
FROM pizza_delivery
WHERE actual_delivery IS NOT NULL
GROUP BY TO_CHAR(order_time,'Mon-YYYY') 
ORDER BY EXTRACT(MONTH FROM TO_DATE(TO_CHAR(order_time,'Mon-YYYY'), 'Mon-YYYY'));











