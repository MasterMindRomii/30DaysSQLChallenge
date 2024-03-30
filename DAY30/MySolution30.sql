drop table if exists student_marks;
drop table if exists students;
drop table if exists subjects;

create table students
(
	roll_no		varchar(20) primary key,
	name		varchar(30)		
);
insert into students values('2GR5CS011', 'Maryam');
insert into students values('2GR5CS012', 'Rose');
insert into students values('2GR5CS013', 'Alice');
insert into students values('2GR5CS014', 'Lilly');
insert into students values('2GR5CS015', 'Anna');
insert into students values('2GR5CS016', 'Zoya');


create table student_marks
(
	student_id		varchar(20) primary key references students(roll_no),
	subject1		int,
	subject2		int,
	subject3		int,
	subject4		int,
	subject5		int,
	subject6		int
);
insert into student_marks values('2GR5CS011', 75, NULL, 56, 69, 82, NULL);
insert into student_marks values('2GR5CS012', 57, 46, 32, 30, NULL, NULL);
insert into student_marks values('2GR5CS013', 40, 52, 56, NULL, 31, 40);
insert into student_marks values('2GR5CS014', 65, 73, NULL, 81, 33, 41);
insert into student_marks values('2GR5CS015', 98, NULL, 94, NULL, 90, 20);
insert into student_marks values('2GR5CS016', NULL, 98, 98, 81, 84, 89);


create table subjects
(
	id				varchar(20) primary key,
	name			varchar(30),
	pass_marks  	int check (pass_marks>=30)
);
insert into subjects values('S1', 'Mathematics', 40);
insert into subjects values('S2', 'Algorithms', 35);
insert into subjects values('S3', 'Computer Networks', 35);
insert into subjects values('S4', 'Data Structure', 40);
insert into subjects values('S5', 'Artificial Intelligence', 30);
insert into subjects values('S6', 'Object Oriented Programming', 35);


select * from students;
select * from student_marks;
select * from subjects;

-- Given tables represent the marks scored by engineering students.
-- Create a report to display the following results for each student.
  /*- Student_id, Student name
  - Total Percentage of all marks
  - Failed subjects (must be comma seperated values in case of multiple failed subjects)
  - Result (if percentage >= 70% then 'First Class', if >= 50% & <=70% then 'Second class', if <=50% then 'Third class' else 'Fail'.
  			The result should be Fail if a students fails in any subject irrespective of the percentage marks)
-- The sequence of subjects in student_marks table match with the sequential id from subjects table.*/
-- Students have the option to choose either 4 or 5 subjects only.

with cte_marks as 
		(select student_id, s.name, column1 as subject_code, column2 as marks 
		from student_marks sm
		cross join lateral (values ('subject1', subject1),('subject2', subject2),('subject3', subject3)
								 ,('subject4', subject4),('subject5', subject5),('subject6', subject6)) x
		join students s on s.roll_no=sm.student_id
		where column2 is not null),
	cte_sub as 
		(select subject_code, subject_name, pass_marks
		from (	select column_name as subject_code, row_number() over(order by ordinal_position) as rn
				from information_schema.columns 
				where table_name ='student_marks' 
				and column_name like 'subject%') a
		join (	select row_number() over(order by id) as rn , name as subject_name, pass_marks
				from subjects) b on a.rn=b.rn),
	cte_agg as
		(select student_id, name 
		, round(avg(marks),2) as percentage_marks
		, string_agg(case when marks >= pass_marks then null else subject_name end, ' , ') as failed_subjects
		from cte_marks cm
		join cte_sub cs on cs.subject_code=cm.subject_code
		group by student_id, name )
select * 
, case when failed_subjects is not null then 'Fail'
	   when percentage_marks >= 70 then 'First Class'
	   when percentage_marks between 50 and 70 then 'Second Class'
	   when percentage_marks < 50 then 'Third Class' end as Result
from cte_agg;