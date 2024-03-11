drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		float
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.4);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;

/*In the given input table, 
There are hotel ratings which are either too high or too low compared 
to the standard ratings the hotel receives each year. 
Write a query to identify and exclude these outlier records as shown in expected output below. 
Your output should follow the same order of records as shown.*/

WITH CTE AS (
SELECT hotel,year,rating,
AVG(rating) OVER(PARTITION BY hotel) AS 'Avg_Rating',
(rating-AVG(rating) OVER(PARTITION BY hotel)) AS 'diff_rating'
FROM hotel_ratings)

SELECT hotel,year,rating FROM (
SELECT hotel,year,rating,
CASE WHEN hotel='Radisson Blu' THEN 
		RANK() OVER(PARTITION BY hotel ORDER BY diff_rating DESC)
        ELSE RANK() OVER(PARTITION BY hotel ORDER BY diff_rating ASC) END 
AS 'Ranking'
FROM CTE ) AS Base 
WHERE Ranking<>1
ORDER BY hotel DESC,year ASC


