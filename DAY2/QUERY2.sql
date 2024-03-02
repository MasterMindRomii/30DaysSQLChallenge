drop table if exists mountain_huts;
create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;


WITH cte_trails1 AS
    (SELECT t1.hut1 AS start_hut, h1.name AS start_hut_name,
            h1.altitude AS start_hut_altitude, t1.hut2 AS end_hut
     FROM mountain_huts h1
     JOIN trails t1 ON t1.hut1 = h1.id),
     cte_trails2 AS
    (SELECT t2.*, h2.name AS end_hut_name, h2.altitude AS end_hut_altitude,
            CASE WHEN start_hut_altitude > h2.altitude THEN 1 ELSE 0 END AS altitude_flag
     FROM cte_trails1 t2
     JOIN mountain_huts h2 ON h2.id = t2.end_hut),
     cte_final AS
    (SELECT CASE WHEN altitude_flag = 1 THEN start_hut ELSE end_hut END AS start_hut,
            CASE WHEN altitude_flag = 1 THEN start_hut_name ELSE end_hut_name END AS start_hut_name,
            CASE WHEN altitude_flag = 1 THEN end_hut ELSE start_hut END AS end_hut,
            CASE WHEN altitude_flag = 1 THEN end_hut_name ELSE start_hut_name END AS end_hut_name
     FROM cte_trails2)
SELECT c1.start_hut_name AS startpt,
        c1.end_hut_name AS middlept,
        c2.end_hut_name AS endpt
FROM cte_final c1
JOIN cte_final c2 ON c1.end_hut = c2.start_hut;
