drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);
insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select * from login_details;

/* Given table provides login and logoff details of one user.
Generate a report to reqpresent the different periods (in mins) when user was logged in.*/

WITH RECURSIVE cte AS (
SELECT DISTINCT
FIRST_VALUE(times) OVER (PARTITION BY grp ORDER BY grp, times) AS log_on,
LAST_VALUE(times) OVER (PARTITION BY grp ORDER BY grp, times
					RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_log_on
FROM (SELECT times, status, rn - ROW_NUMBER() OVER (ORDER BY times) AS grp
FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY times) AS rn
FROM login_details) x
WHERE status = 'on') y
),
cte_final AS (
    SELECT log_on, LEAD(times) OVER (ORDER BY times) AS log_off
    FROM login_details l
    LEFT JOIN cte ON cte.last_log_on = l.times
)
SELECT *,TIMESTAMPDIFF(MINUTE, log_on, log_off) AS duration
FROM cte_final
WHERE log_on IS NOT NULL;









