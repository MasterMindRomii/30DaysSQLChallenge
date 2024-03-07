-- MySQL
DROP TABLE IF EXISTS Day_Indicator;
CREATE TABLE Day_Indicator (
    Product_ID VARCHAR(10),
    Day_Indicator VARCHAR(7),
    Dates DATE
);

INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('04-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('05-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('06-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('07-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('08-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('09-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', STR_TO_DATE('10-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('04-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('05-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('06-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('07-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('08-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('09-Mar-2024', '%d-%b-%Y'));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', STR_TO_DATE('10-Mar-2024', '%d-%b-%Y'));

/* In the given input table DAY_INDICATOR field indicates the day of the week with the first character being Monday, followed by Tuesday and so on.
Write a query to filter the dates column to showcase only those days where day_indicator character for that day of the week is 1 */

SELECT product_id, day_indicator, dates
FROM ( 
		SELECT *,
        CASE WHEN SUBSTRING(day_indicator,(((WEEKDAY(dates)+5)%7)+1),1)='1'
        THEN 'Inc' ELSE 'Exc' END AS Flag FROM Day_Indicator ) BASE 
WHERE Flag='Inc'








