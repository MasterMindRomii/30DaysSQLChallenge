drop table if exists item;
create table item
(
	id		int,
	items	varchar(50)
);
insert into item values(1, '22,122,1022');
insert into item values(2, ',6,0,9999');
insert into item values(3, '100,2000,2');
insert into item values(4, '4,44,444,4444');

select * from item;

-- Find length of comma seperated values in items field.
SELECT id, STRING_AGG(LEN(value),',') AS lengths
FROM item
CROSS APPLY STRING_SPLIT(items,',')
GROUP BY id;

