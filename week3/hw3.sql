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

----------------------------------------
--              Problem 2
----------------------------------------

-- Part 1
/*
If we want to know which site has the largest area, it’s tempting to say

SELECT Site_name, MAX(Area) FROM Site;
Wouldn’t that be great? But DuckDB gives an error.
 And right it should! This query is conceptually flawed. 
 Please describe what is wrong with this query. Don’t just 
 quote DuckDB’s error message— explain why DuckDB is 
 objecting to performing this query.
*/

/*
Answer: The query is flawed because when using an aggregate fuction like `MAX()`, there should
be some grouping in order for the columns in the `SELECT` statement to know we want 
to fing the maximum `Area ` for each `Site` Name

We would need to use `GROUP BY ` like in the revised example below:
SELECT Site_name, MAX(Area) AS Max_Area
    FROM Site
    GROUP BY Site_name;
*/

-- Part 2
/*
Time for plan B. Find the site name and area of the site having the largest area.
Do so by ordering the rows in a particularly convenient order, and using LIMIT 
to select just the first row. Your result should look like:

┌──────────────┬────────┐
│  Site_name   │  Area  │
│   varchar    │ float  │
├──────────────┼────────┤
│ Coats Island │ 1239.1 │
└──────────────┴────────┘



Answer:  */
SELECT Site_name, MAX(Area) as area_max
    FROM Site
    GROUP BY Site_name -- group by to aggregate by `MAX()`
    ORDER BY -area_max -- reverse order
    LIMIT 1; -- table only returns one value

-- Part 3
/*
Do the same, but use a nested query. 
First, create a query that finds the maximum area. 
Then, create a query that selects the site name 
and area of the site whose area equals the maximum. 

Answer: */
SELECT Site_name, Area FROM Site
    WHERE AREA = (
        SELECT MAX(Area) FROM Site
    );

----------------------------------------
--              Problem 3
----------------------------------------
/*
Compute the average volume of the eggs in each nest, 
And then for the nests of each species compute the maximum of those average volumes, 
And list by species in descending order of maximum volume. 

Answer: */

-- create temp table for the average volume
CREATE TEMP TABLE volume_table AS
SELECT Nest_ID, AVG((3.14/6)*Width^2*Length) AS avg_volume FROM Bird_eggs -- calc avg volume 
    GROUP By Nest_ID;

-- create temp table to get max avg volume
CREATE TEMP TABLE max_avg_vol AS
SELECT Species, MAX(avg_volume) max_avg_vol -- get the max
    FROM Bird_nests JOIN volume_table USING (Nest_ID) -- join the species table to get sci. names
    GROUP BY Species; -- group by Species to get Max per 

-- select columns of final table and join to get species and order
SELECT Scientific_name, max_avg_vol FROM max_avg_vol 
    JOIN species 
    ON Code = Species -- common column in both tables
    ORDER BY -max_avg_vol; -- reverse order
    
-- Attempt of using one query 

WITH volume_table AS (
    SELECT Nest_ID, AVG((3.14/6)*Width^2*Length) AS avg_volume -- calc avg volume
    FROM Bird_eggs
    GROUP BY Nest_ID
),
max_avg_vol AS (
    SELECT Species, MAX(avg_volume) AS max_avg_vol -- get the max
    FROM Bird_nests 
    JOIN volume_table USING (Nest_ID) -- join 
    GROUP BY Species
)
SELECT Scientific_name, max_avg_vol 
FROM max_avg_vol 
JOIN Species ON Code = Species -- join to get species
ORDER BY -max_avg_vol; -- order

