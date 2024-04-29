/*
Name: Vanessa Salgado
Assignment 3
*/
----------------------------------------
--              Problem 1 
----------------------------------------

-- Part 1 
--Create table
CREATE TEMP TABLE table_1 (
    num_col real
);

-- inserting values 
INSERT INTO table_1 (num_col)
    VALUES (3),(NULL),(1),(4),(1),(5);

SELECT * FROM table_1;

-- average of `num_col`
SELECT AVG(num_col) AS avg FROM table_1;

/*Answer: 
There was no error and `AVG()` calculated (3+1+4+1+5)/5 as usual.
`AVG()` was not not affected by NULL and not taking into account for the calculation. 
If it did, we would expect the return to be NULL as the average.
*/

-- Part 2 
/*
SELECT SUM(mycolumn)/COUNT(*) FROM mytable;
SELECT SUM(mycolumn)/COUNT(mycolumn) FROM mytable;
Which query above is correct? Please explain why.
*/

SELECT SUM(num_col)/COUNT(*) FROM table_1;
SELECT SUM(num_col)/COUNT(num_col) FROM table_1;

/*Answer:
The second one is correct.
In the first query, it is counting all of the rows, including the row with the NULL value, so the count is 6
In the second one it's counting how many values are in the column, and because there is a NULL, that count is 5
*/

DROP TABLE table_1;