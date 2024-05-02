CREATE TABLE Species (
    Code TEXT PRIMARY KEY ,
    Common_name TEXT UNIQUE NOT NULL,
    Scientific_name TEXT,
    Relevance TEXT,
);

-- sqlite trigger 
CREATE TRIGGER Update_Species
AFTER INSERT ON Species
FOR EACH ROW 
BEGIN
    UPDATE Species
    SET Scientific_name = NULL
    WHERE Code = new.Code AND Scientific_name = '';
END;

.import --csv -- skip 1 species.csv Species

-- open sqlite3