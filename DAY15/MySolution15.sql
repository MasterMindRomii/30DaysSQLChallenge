DROP TABLE IF EXISTS Friends;

CREATE TABLE Friends
(
	Friend1 	VARCHAR(10),
	Friend2 	VARCHAR(10)
);
INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;

-- From the given friends, find the no of mutual friends !
WITH all_friends AS 
(SELECT Friend1,Friend2 FROM Friends
UNION 
SELECT Friend2,Friend1 FROM Friends)
SELECT DISTINCT f.*,
COUNT(af.Friend2) OVER(PARTITION BY f.Friend1,f.Friend2 ORDER BY f.Friend1,f.Friend2 
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Mutual_Friends'
FROM Friends f
LEFT JOIN all_friends af
ON f.Friend1=af.Friend1 AND 
af.Friend2 IN (SELECT af2.Friend2 FROM all_friends af2 WHERE af2.Friend1=f.Friend2)
ORDER BY 1










