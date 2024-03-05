drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


drop table if exists emp_transaction;
create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);

-- PROBLEM STATEMENT: Using the given Salary, Income and Deduction tables, first write an sql query to populate the Emp_Transaction table as shown below and then generate a salary report as shown.

insert into emp_transaction
select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) end as amount	   
from salary s
cross join (select income as trns_type, percentage from income union 
select deduction as trns_type, percentage from deduction) x;


select * from salary;
select * from income;
select * from deduction;
select * from emp_transaction;

INSERT INTO emp_transaction
SELECT emp_id,emp_name,X.TRNS_TYPE,
(CASE 
		WHEN TRNS_TYPE='Insurance' THEN base_salary * (percentage/100)
		WHEN TRNS_TYPE='Basic' THEN base_salary * (percentage/100)
		WHEN TRNS_TYPE='Allowance' THEN base_salary * (percentage/100)
		WHEN TRNS_TYPE='Others' THEN base_salary * (percentage/100)
		WHEN TRNS_TYPE='Health' THEN base_salary * (percentage/100)
		WHEN TRNS_TYPE='House' THEN base_salary * (percentage/100)
        END) AS 'Amount'
FROM salary 
CROSS JOIN(
SELECT deduction AS 'TRNS_TYPE',CAST(percentage AS DECIMAL) AS 'percentage' FROM deduction
UNION 
SELECT income AS 'TRNS_TYPE',CAST(percentage AS DECIMAL) AS 'percentage' FROM income) X
ORDER BY 2;


SELECT emp_name,
    SUM(CASE WHEN TRNS_TYPE = 'Allowance' THEN Amount ELSE 0 END) AS Allowance,
    SUM(CASE WHEN TRNS_TYPE = 'Insurance' THEN Amount ELSE 0 END) AS Insurance,
    SUM(CASE WHEN TRNS_TYPE = 'Basic' THEN Amount ELSE 0 END) AS Basic,
    SUM(CASE WHEN TRNS_TYPE = 'Others' THEN Amount ELSE 0 END) AS Others,
    SUM(CASE WHEN TRNS_TYPE = 'Health' THEN Amount ELSE 0 END) AS Health,
    SUM(CASE WHEN TRNS_TYPE = 'House' THEN Amount ELSE 0 END) AS House,
    SUM(CASE WHEN TRNS_TYPE IN ('Basic', 'Allowance', 'Others') THEN Amount ELSE 0 END) AS Gross,
    SUM(CASE WHEN TRNS_TYPE NOT IN ('Basic', 'Allowance', 'Others') THEN Amount ELSE 0 END) AS Total_Deduction,
    (SUM(CASE WHEN TRNS_TYPE IN ('Basic', 'Allowance', 'Others') THEN Amount ELSE 0 END) -
    SUM(CASE WHEN TRNS_TYPE NOT IN ('Basic', 'Allowance', 'Others') THEN Amount ELSE 0 END)) AS Net_Pay
FROM emp_transaction
GROUP BY emp_name;






















