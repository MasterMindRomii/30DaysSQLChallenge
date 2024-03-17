DROP TABLE IF EXISTS user_login;
CREATE TABLE user_login (
    user_id INT,
    login_date DATE
);

INSERT INTO user_login VALUES (1, STR_TO_DATE('01/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('02/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('03/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('06/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('10/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('11/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('12/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('13/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('14/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('20/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('25/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('26/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('27/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('28/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('29/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (1, STR_TO_DATE('30/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (2, STR_TO_DATE('01/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (2, STR_TO_DATE('02/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (2, STR_TO_DATE('03/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (2, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('01/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('02/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('03/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (3, STR_TO_DATE('05/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (4, STR_TO_DATE('01/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (4, STR_TO_DATE('02/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (4, STR_TO_DATE('03/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (4, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));
INSERT INTO user_login VALUES (4, STR_TO_DATE('04/03/2024', '%d/%m/%Y'));

SELECT * FROM user_login;

-- Given is user login table for , identify dates where a user has logged in for 5 or more consecutive days.
-- Return the user id, start date, end date and no of consecutive days, sorting based on user id.
-- If a user logged in consecutively 5 or more times but not spanning 5 days then they should be excluded.

WITH CTE AS (SELECT user_id,login_date,
DENSE_RANK() OVER(PARTITION BY user_id ORDER BY user_id,login_date) AS 'Ranking',
DATE_SUB(login_date, INTERVAL (DENSE_RANK() OVER(PARTITION BY user_id ORDER BY user_id,login_date)) DAY) AS Date_Group
FROM user_login)

SELECT user_id,Date_Group,
MIN(login_date) AS 'Start_Date',
MAX(login_date) AS 'End_Date',
(MAX(login_date)-MIN(login_date))+1 AS 'Consecutive_Days'
FROM CTE
GROUP BY user_id,Date_Group
HAVING (MAX(login_date)-MIN(login_date)) >=4









