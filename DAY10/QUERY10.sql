drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);
insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');

select * from auto_repair;

-- How to create second table from first table(image attached) 

WITH CTE AS (
SELECT V.value AS 'Velocity',L.value AS 'Level',COUNT(1) AS No_of_Times FROM auto_repair L
JOIN auto_repair V 
ON L.client=V.client AND L.auto=V.auto AND L.repair_date=V.repair_date
WHERE L.indicator='level' AND V.indicator='velocity'
GROUP BY V.value,L.value
ORDER BY V.value,L.value) 

SELECT Velocity,
COALESCE(SUM(CASE WHEN Level='good' THEN No_of_Times ELSE 0 END)) AS 'Good',
COALESCE(SUM(CASE WHEN Level='wrong' THEN No_of_Times ELSE 0 END)) AS 'Wrong',
COALESCE(SUM(CASE WHEN Level='regular' THEN No_of_Times ELSE 0 END)) AS 'Regular'
FROM CTE 
GROUP BY Velocity












