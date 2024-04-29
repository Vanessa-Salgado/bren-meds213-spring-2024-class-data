/*
Name: Vanessa Salgado
Assignment 3
*/
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