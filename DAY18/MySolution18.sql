DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT,
    name VARCHAR(50)
);
INSERT INTO employees VALUES (1, 'Lewis');
INSERT INTO employees VALUES (2, 'Max');
INSERT INTO employees VALUES (3, 'Charles');
INSERT INTO employees VALUES (4, 'Sainz');

DROP TABLE IF EXISTS events;
CREATE TABLE events (
    event_name VARCHAR(50),
    emp_id INT,
    dates DATE
);
INSERT INTO events VALUES ('Product launch', 1, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 3, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 4, '2024-03-01');
INSERT INTO events VALUES ('Conference', 2, '2024-03-02');
INSERT INTO events VALUES ('Conference', 2, '2024-03-03');
INSERT INTO events VALUES ('Conference', 3, '2024-03-02');
INSERT INTO events VALUES ('Conference', 4, '2024-03-02');
INSERT INTO events VALUES ('Training', 3, '2024-03-04');
INSERT INTO events VALUES ('Training', 2, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-05');


-- Find out the employees who attended all company events
WITH CTE AS
(SELECT E1.name,E2.event_name,COUNT(*) AS 'Attended_Event' FROM employees E1
INNER JOIN events E2
ON E1.id = E2.emp_id
WHERE event_name IN ('Product launch','Conference','Training')
GROUP BY E1.name,E2.event_name),
CTE2 AS (
SELECT name,
COUNT(event_name) AS No_Of_Events
FROM CTE
WHERE event_name IN ('Product launch','Conference','Training')
GROUP BY name)

SELECT name,No_Of_Events FROM CTE2 
WHERE No_Of_Events>=3;

-- Other Method 
SELECT E1.name, COUNT(DISTINCT E2.event_name) AS 'No_Of_Event' FROM employees E1
INNER JOIN events E2
ON E1.id = E2.emp_id
GROUP BY E1.name
HAVING COUNT(DISTINCT event_name) = (SELECT COUNT(DISTINCT event_name) FROM events)












