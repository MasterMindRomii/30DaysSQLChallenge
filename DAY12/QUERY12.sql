DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;

/* Given graph shows the hierarchy of employees in a company. 
Write an SQL query to split the hierarchy and show the employees corresponding to their team.*/

WITH RECURSIVE cte_teams AS (
SELECT mng.employee,
CONCAT('Team', ROW_NUMBER() OVER (ORDER BY mng.employee)) AS teams
FROM company root
JOIN company mng ON root.employee = mng.manager
WHERE root.manager IS NULL
),
cte AS (
SELECT c.employee, c.manager, t.teams
FROM company c CROSS JOIN cte_teams t 
WHERE c.manager IS NULL 
UNION 
SELECT c.employee, c.manager, COALESCE(t.teams, cte.teams) AS teams 
FROM company c JOIN cte ON cte.employee = c.manager
LEFT JOIN cte_teams t ON t.employee = c.employee )

SELECT teams, GROUP_CONCAT(employee, ', ') AS members 
FROM cte 
GROUP BY teams
ORDER BY teams;













