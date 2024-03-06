drop table if exists  student_tests;
create table student_tests
(
	test_id		int,
	marks		int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;

-- PROBLEM STATEMENT:
/*You are given a table having the marks of one student in every test. 
You have to output the tests in which the student has improved his performance. 
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, one including the first test score and second excluding it.*/

-- 1st Output
SELECT test_id,marks FROM 
(SELECT test_id,marks,
LAG(marks,1,0) OVER(ORDER BY test_id) AS 'Prev_Test_Marks'
FROM student_tests ) x 
WHERE x.marks>x.Prev_Test_Marks;

-- 2nd Output
SELECT test_id,marks FROM 
(SELECT test_id,marks,
LAG(marks,1,marks) OVER(ORDER BY test_id) AS 'Prev_Test_Marks'
FROM student_tests ) x 
WHERE x.marks>x.Prev_Test_Marks;