.tables


---count eggs per nest 
SELECT Nest_ID, COUNT(*) FROM Bird_eggs
    GROUP BY Nest_ID
    .maxrows 8;
SELECT Species FROM Bird_nests WHERE Site = "none";
SELECT Species COUNT(*) AS Nest_count
    FROM Bird_nests
    WHERE Site = "none"
    GROUP BY Species
    ORDER BY Species
    LIMIT 2;


---NEST Things; nest queries 
SELECT Species FROM Bird_nests WHERE Site = "none";
    (SELECT Species COUNT(*) AS Nest_count
    FROM Bird_nests
    WHERE Site = "none"
    GROUP BY Species
    ORDER BY Species
    LIMIT 2;) JOIN Species ON Species = Code;

--- Join 'table' on `species_table` = `FOREIRN CODE`

SELECT Scientifi_name, Nest_count FROM
    SELECT * FROM a;
    CREATE * TEMP a
    ---inner join
    SELECT * FROM a JOIN B USING (common);
    SELECT * FROM a INNER JOIN b using (common); 
    ---left or right outer join
    SELECT ( FROM a LEFT JOIN bUSING(Common)
    .nullvalue -NULL- -- default NULL TO display as NULL
    -- .nullvlaue ''
    -- 
    SELECT * FROM a RIGHT JOIN busing (common);
    --
    what species do not have nest data?
    --before
    SELECT * FROM Species
        WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests)
    ---lets do the same thing using an oute rjoing 
SELECT Code, Scientifi_name, Nest_ID, Species, Year
    --any of the species that match Bird_nest 
    --left join: added extra rows wit NULL
    FROM Species LEFT JOIN Bird_nests ON Code = Species;
.nullvalue -NULL-
--CHECK 
SELECT COUNT(*) FROM Bird_nests WHERE Species = 'ruff';
--correct answer
SELECT Code, Scientifi_name, Nest_ID, Species, Year
    FROM Species LEFT JOIN Bird_nests ON Code = Species;
    WHERE Nest_ID ISNULL;

--- a gothca when doing grouping
-- gets repliCATED 
SELECT * FROM Bird_eggs LIMIT 3;
SELECT * FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';
SELECT Nest_ID, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';
    GROUP BY Nest_ID;
    --returns 14.... count 3 tables

-- this doesnt make sense!
---SELECT Nest_ID, COUNT(*), Length 
---    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
---    WHERE Nest_ID = '14eabaage01';
--- this does make sense and will work but not with duckdb
SELECT Nest_ID, Species, COUNT(*), 
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- workaround
SELECT Nest_ID, Species, COUNT(*), 
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID, Species;
-- workaround #2
SELECT Nest_ID, ANY_VALUE(Species), COUNT(*), 
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- Views
SELECT * FROM Camp_assignment;
SELECT Year, Site, Name, Start, "End"
    ON Observer = Abbreviation;
CREATE VIEW v AS
    SELECT Year, Site, Name, Start, "End"
    FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation;
-- a view looks just like a table but its not real 
SELECT * FROM v;
CREATE VIEW v2 AS SELECT COUNT(*) FROM Species;
SELECT * FROM v2; 
-- set opterions; UNION, INTERSECT, EXCEPT 
-- iffy example
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs;
SELECT Book_page, Nest_ID, Egg_num, Length*25.4, Width*25.4, FROM Bird_eggs
    WHERE Book_page = 'b14.6'
    UNION
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs
WHERE Book_page !='b14.6'

--UNION OR UNION ALL(LIKE AN R BIND)
--just mashes talbes together ; not 
