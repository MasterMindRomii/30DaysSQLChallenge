drop table if exists covid_cases;
create table covid_cases
(
    cases_reported int,
    dates date    
);
insert into covid_cases values(20124,STR_TO_DATE('10/01/2020','%d/%m/%Y'));
insert into covid_cases values(40133,STR_TO_DATE('15/01/2020','%d/%m/%Y'));
insert into covid_cases values(65005,STR_TO_DATE('20/01/2020','%d/%m/%Y'));
insert into covid_cases values(30005,STR_TO_DATE('08/02/2020','%d/%m/%Y'));
insert into covid_cases values(35015,STR_TO_DATE('19/02/2020','%d/%m/%Y'));
insert into covid_cases values(15015,STR_TO_DATE('03/03/2020','%d/%m/%Y'));
insert into covid_cases values(35035,STR_TO_DATE('10/03/2020','%d/%m/%Y'));
insert into covid_cases values(49099,STR_TO_DATE('14/03/2020','%d/%m/%Y'));
insert into covid_cases values(84045,STR_TO_DATE('20/03/2020','%d/%m/%Y'));
insert into covid_cases values(100106,STR_TO_DATE('31/03/2020','%d/%m/%Y'));
insert into covid_cases values(17015,STR_TO_DATE('04/04/2020','%d/%m/%Y'));
insert into covid_cases values(36035,STR_TO_DATE('11/04/2020','%d/%m/%Y'));
insert into covid_cases values(50099,STR_TO_DATE('13/04/2020','%d/%m/%Y'));
insert into covid_cases values(87045,STR_TO_DATE('22/04/2020','%d/%m/%Y'));
insert into covid_cases values(101101,STR_TO_DATE('30/04/2020','%d/%m/%Y'));
insert into covid_cases values(40015,STR_TO_DATE('01/05/2020','%d/%m/%Y'));
insert into covid_cases values(54035,STR_TO_DATE('09/05/2020','%d/%m/%Y'));
insert into covid_cases values(71099,STR_TO_DATE('14/05/2020','%d/%m/%Y'));
insert into covid_cases values(82045,STR_TO_DATE('21/05/2020','%d/%m/%Y'));
insert into covid_cases values(90103,STR_TO_DATE('25/05/2020','%d/%m/%Y'));
insert into covid_cases values(99103,STR_TO_DATE('31/05/2020','%d/%m/%Y'));
insert into covid_cases values(11015,STR_TO_DATE('03/06/2020','%d/%m/%Y'));
insert into covid_cases values(28035,STR_TO_DATE('10/06/2020','%d/%m/%Y'));
insert into covid_cases values(38099,STR_TO_DATE('14/06/2020','%d/%m/%Y'));
insert into covid_cases values(45045,STR_TO_DATE('20/06/2020','%d/%m/%Y'));
insert into covid_cases values(36033,STR_TO_DATE('09/07/2020','%d/%m/%Y'));
insert into covid_cases values(40011,STR_TO_DATE('23/07/2020','%d/%m/%Y'));    
insert into covid_cases values(25001,STR_TO_DATE('12/08/2020','%d/%m/%Y'));
insert into covid_cases values(29990,STR_TO_DATE('26/08/2020','%d/%m/%Y'));    
insert into covid_cases values(20112,STR_TO_DATE('04/09/2020','%d/%m/%Y'));    
insert into covid_cases values(43991,STR_TO_DATE('18/09/2020','%d/%m/%Y'));    
insert into covid_cases values(51002,STR_TO_DATE('29/09/2020','%d/%m/%Y'));    
insert into covid_cases values(26587,STR_TO_DATE('25/10/2020','%d/%m/%Y'));    
insert into covid_cases values(11000,STR_TO_DATE('07/11/2020','%d/%m/%Y'));    
insert into covid_cases values(35002,STR_TO_DATE('16/11/2020','%d/%m/%Y'));    
insert into covid_cases values(56010,STR_TO_DATE('28/11/2020','%d/%m/%Y'));    
insert into covid_cases values(15099,STR_TO_DATE('02/12/2020','%d/%m/%Y'));    
insert into covid_cases values(38042,STR_TO_DATE('11/12/2020','%d/%m/%Y'));    
insert into covid_cases values(73030,STR_TO_DATE('26/12/2020','%d/%m/%Y'));    


/*Given table contains reported covid cases in 2020. 
Calculate the percentage increase in covid cases each month versus cumulative cases as of the prior month.
Return the month number, and the percentage increase rounded to one decimal. Order the result by the month.*/

WITH CTE AS (
SELECT MONTH(dates) AS 'Month',
SUM(cases_reported) AS 'Monthly_Cases'
FROM covid_cases
GROUP BY Month),
CTE2 AS (
SELECT *,
SUM(Monthly_Cases) OVER(ORDER BY Month) AS 'Total_Cases'
FROM CTE)

SELECT Month, 
CASE 
	WHEN Month>1 THEN CAST(ROUND((Monthly_Cases/LAG(Total_Cases) OVER(ORDER BY Month))*100,1) AS CHAR)
	ELSE '-' 
END AS 'Percentage_Change'
FROM CTE2 




















