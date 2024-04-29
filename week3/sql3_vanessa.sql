/*
Name: Vanessa Salgado
Assignment 3
*/
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

