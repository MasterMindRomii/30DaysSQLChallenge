

drop table if exists Q4_data;
create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);


-- Question : Derived Excepted Ouput 

SELECT MIN(id),MIN(name),MIN(location) FROM Q4_data;
-- OR ALSO WE CAN GET AS BELOW 
SELECT MAX(id),MAX(name),MIN(location) FROM Q4_data;