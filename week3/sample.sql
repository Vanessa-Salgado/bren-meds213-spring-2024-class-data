---Monday transcript
.open database.db

---
SELECT * FROM Species;
.tables


--- limiting rows 
SELECT * FROM Species LIMIT 5;

SELECT * FROM Species 5 OFFSET 5;

---HOW MANY ROWS
SELECT COUNT(*) FROM Species

---EXCERSICE: what distinc location occur in the site table?
---Order them, Also limit to 3 results 
SELECT DISTINCT LOCATION
FROM site
ORDER BY LOCATION
LIMIT 3;

.maxrow 6
SELECT Location FROM Site;
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM SITE WHERE Area < 200 AND Location LIKE '%USA';
SELECT * FROM SITE WHERE Area < 200 AND Location LIKE '%usa';
--- LIKE is case insensitive in SQL 
--- so far we've only done columns
--- now expressions
SELECT 

....

SELECT DISTINCT Relevance FROM SPECIES;
SELECT COUNT(DISTINCT Relevance) FROM Species;
---MIN, MAX, AVG
SELECT AVG(Area) FROM Site;
--- grouping
SELECT * FROM Site;
---what is the largers are for this location
SELECT * FROM Site;
SELECT Location, MAX(Area)
    FROM Site
    GROUP BY Location;

---adding WHERE clause
SELECT Location, MAX(Area)
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200;
---relational algebra peeks through!
--- any query retruns a table
SELECT COUNT(*) FROM Site;
--- count how mnay rows are in this table
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Site);
---
SELECT * FROM Bird_nests LIMIT 3;
--- are there any species for which we do not have data for
SELECT * FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
---saving queries
CREATE TEMP TABLE t ASDN_Bird_eggs
    SELECT * FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
SELECT * FROM t;
SELECT * FROM t_perm;
DROP TABLE t_perm;
---null processing
SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge <=5;
SELECT COUNT(*) FROM Bird_nests;
...
--or permentantly

Select name, year, site, start, "end"
    LIMIT 3 

SELECT * FROM Camp Assignment JOIN Personnel
    ON Camp_assignement.Observer = Personnel

---multiway join
SELECT * FROM Camp_assignement ca JOIN Personnel P
    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    WHERE ca.Observer = 'lmckinnon'
    LIMIT 3; 
---more on grouping
SELECT Nest_ID, COUNT(*) FROM Bird_eggs GROUP BY Nest_ID