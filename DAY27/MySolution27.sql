drop table if exists vacation_plans;
create table vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);
insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');


drop table if exists leave_balance;
create table leave_balance
(
	emp_id			int,
	balance			int
);
insert into leave_balance values (1, 12);
insert into leave_balance values (2, 10);
insert into leave_balance values (3, 26);
insert into leave_balance values (4, 20);
insert into leave_balance values (5, 14);

/*
PROBLEM STATEMENT: 
Given vacation_plans tables shows the vacations applied by each employee during the year 2024. 
Leave_balance table has the available leaves for each employee.
Write an SQL query to determine if the vacations applied by each employee can be approved or not based on the available leave balance. 
If an employee has enough available leaves then mention the status as "Approved" else mention "Insufficient Leave Balance".
Assume there are no public holidays during 2024. weekends (sat & sun) should be excluded while calculating vacation days. 
*/

select * from vacation_plans;
select * from leave_balance;



-- PostgreSQL
with recursive cte as (
	with cte_data as 
		(select v.id, v.emp_id, v.from_dt, v.to_dt
		, l.balance as leave_balance, count(d.dates) as vacation_days
		, row_number() over(partition by v.emp_id order by v.emp_id,v.id) as rn
		from vacation_plans v
		cross join lateral (select cast(dates as date) as dates, trim(to_char(dates,'Day')) as day
							from generate_series(v.from_dt,v.to_dt,'1 Day') dates) d
		join leave_balance l on l.emp_id=v.emp_id
		where day not in ('Saturday','Sunday')	
		group by v.id, v.emp_id, v.from_dt, v.to_dt, l.balance)
	select *, (leave_balance-vacation_days) as remaining_balance
	from cte_data	
	where rn=1
	union all
	select cd.*, (cte.remaining_balance-cd.vacation_days) as remaining_balance
	from cte 
	join cte_data cd on cd.rn=cte.rn+1 and cd.emp_id=cte.emp_id
	)
select id,emp_id,from_dt,to_dt,leave_balance, vacation_days
, case when remaining_balance < 0 then 'Insufficient Leave Balance' else 'Approved' end as status
from cte

