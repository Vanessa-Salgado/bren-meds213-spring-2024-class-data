
/* TOPIC ONE: INSERTING */
duckdb db;

SELECT * FROM Species;
.maxrows8
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific name', NULL);
SELECT * FROM Species;
-- BE EXPLICIT INTO WHAT COLUMNS YOU ARE INSERTING INTO IT
INSERT INTO Species (Common_name, Scientific_name, Code, Relevance)
    VALUES('thing2', 'another scientific name', 'efgh', NULL);
-- TAke advantage of default values that populate the columns
--THINK ABOUT FRAGILITY
INSERT INTO Species (Common_name, Code) VALUES ('thing3', 'ijkl');
SELECT * FROM Species
.nullvalue -NULL-


/* TOPIC TWO: UPDATE AND DELETE */
-- insert 
UPDATE Species SET Relevance = 'not sure yet' WHERE Relevance IS NULL; 
SELECT * FROM Species;
-- delete 
DELETE FROM Species WHERE Relevance = 'not sure yet';
SELECT * FROM Species;

--this deletes everything 
-- delete all rows in the table "tbl"
--DELETE FROM Species;

-- SAFE DELETE PRACTICE 
SELECT * FROM Species WHERE Relevance = 'Study species';
-- after confirming, then edit the statement
DELETE FROM Species WHERE Relevance = 'Study species';
-- Incomplete statement
-- leave off 'DELETE', THEN ADD IT AFTER VISUAL CONFIRMATION

-- exporting csv 
COPY Species TO 'species_fixed.csv' (HEADER, DELIMITER ','); 

-- importing a csv into a table into a database 
-- two step process
-- 1. create an empty table using constraints 
CREATE TABLE Snow_cover_2 (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Date DATE NOT NULL,
    Plot VARCHAR, -- some Null in the data :/
    Location VARCHAR NOT NULL,
    Snow_cover INTEGER CHECK (Snow_cover > -1 AND Snow_cover < 101),
    Observer VARCHAR
);
-- 2. IMPORT data from csv
COPY 'Snow_cover_2' FROM 'snow_cover_fixedman_JB.csv' (HEADER TRUE);


/* TOPIC THREE: TRIGGERS 
TRIGGERS: An SQL trigger allows you to specify SQL actions that should 
be executed automatically when a specific event occurs in the database. 
*/