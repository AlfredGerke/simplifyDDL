/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es werden alle notwendigen Domains für das sDDL.bootstrap angelegt    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/


/* Domains für das sDDL.bootstrap ----------------------------------------------------------------*/

CREATE DOMAIN DN_DESCRIBE_RECORD_TYPE
AS SMALLINT
DEFAULT 0
CHECK (VALUE IN (0, 1, 2, 3, 4, 5, 6, 7));

COMMENT ON DOMAIN DN_DESCRIBE_RECORD_TYPE
IS 'Recordtype für SP_DESCRIBE'; 

CREATE DOMAIN DN_DESCRIBE_RECORD_CAPTION
AS VARCHAR(64)
DEFAULT 0
CHECK (VALUE IN ('UNKNOWN', 'HEADER', 'FIELDS', 'CONSTRAINTS', 'INDICES', 'TRIGGER', 'DEPENDENCIES', 'GRANTS'));

COMMENT ON DOMAIN DN_DESCRIBE_RECORD_CAPTION
IS 'RecordtypeCaption für SP_DESCRIBE';

CREATE DOMAIN DN_ENTITY_TYPE_CAPTION
AS VARCHAR(31)
DEFAULT 'UNKNOWN'
CHECK (VALUE IN ('UNKNOWN', 'TABLE', 'GTT', 'VIEW', 'PK CONSTRAINT', 'FK CONSTRAINT', 'ALT CONSTRAINT', 'INDEX', 'SEQUENCE'));

COMMENT ON DOMAIN DN_ENTITY_TYPE_CAPTION
IS 'Auflistung von Entitäten, welche vom sDDL.bootstrap verwaltet werden';

CREATE DOMAIN DN_ENTITY_TYPE
AS SMALLINT;

COMMENT ON DOMAIN DN_ENTITY_TYPE
IS 'Entitätentyp';

CREATE DOMAIN DN_SQLCLASS
AS VARCHAR(2);

COMMENT ON DOMAIN DN_SQLCLASS 
IS 'SQL Klasse (http://www.firebirdsql.org/rlsnotesh/rlsnotes25.html#d0e23524)';

CREATE DOMAIN DN_SQLSTATE
AS VARCHAR(5);

COMMENT ON DOMAIN DN_SQLSTATE 
IS 'SQL Statuscode (http://www.firebirdsql.org/rlsnotesh/rlsnotes25.html#d0e23524)';

CREATE DOMAIN DN_SDDL_COMMAND
AS VARCHAR(254)
NOT NULL;

COMMENT ON DOMAIN DN_SDDL_COMMAND
IS 'Kommando für die Codegenerierung';

CREATE DOMAIN DN_DB_COMMENT
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_DB_COMMENT
IS 'DB-Objekt Kommentar als Varchar';

CREATE DOMAIN DN_MESSAGE
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_MESSAGE
IS 'Information';

CREATE DOMAIN DN_DIMENSION
AS INTEGER;

COMMENT ON DOMAIN DN_DIMENSION
IS 'Länge, Breite, Höhe, etc.';

CREATE DOMAIN DN_PREFIX
AS VARCHAR(3);

COMMENT ON DOMAIN DN_PREFIX
IS 'Prefix (3 Zeichen)';

CREATE DOMAIN DN_PREFIX_EXT
AS VARCHAR(64);

COMMENT ON DOMAIN DN_PREFIX_EXT
IS 'Prefix (64 Zeichen)';

CREATE DOMAIN DN_CAPTION
AS VARCHAR(64);

COMMENT ON DOMAIN DN_CAPTION
IS 'Bezeichnung';

CREATE DOMAIN DN_COMMENT
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_COMMENT
IS 'Kommentar';

CREATE DOMAIN DN_COUNT
AS INTEGER;

COMMENT ON DOMAIN DN_COUNT
IS 'Einfacher Typ für Zähler';

CREATE DOMAIN DN_INDEX
AS INTEGER;

COMMENT ON DOMAIN DN_INDEX
IS 'Einfacher Index für Position, etc.';

CREATE DOMAIN DN_COLUMNLIST_SEPARATOR
AS VARCHAR(1)
DEFAULT ','
CHECK (VALUE IN (',', ';'));

COMMENT ON DOMAIN DN_COLUMNLIST_SEPARATOR
IS 'Spaltenlisten-Separator';
            
/* DN_COLUMNLIST birgt die Gefahr das die Dimension zu klein ist */            
CREATE DOMAIN DN_COLUMNLIST
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_COLUMNLIST
IS 'für einfache Spaltenlisten, Dimension beachten';

/* DN_SQL_STMT birgt die Gefahr das die Dimension zu klein ist */
CREATE DOMAIN DN_SQL_STMT
AS VARCHAR(6000);

COMMENT ON DOMAIN DN_SQL_STMT
IS 'für einfache SQL Statements, Dimension beachten';

CREATE DOMAIN DN_BOOLEAN
AS BOOLEAN
DEFAULT 
FALSE;

COMMENT ON DOMAIN DN_BOOLEAN
IS 'Belegt Boolean immer mit FALSE vor';

CREATE DOMAIN DN_DB_OBJECT
AS VARCHAR(31);

COMMENT ON DOMAIN DN_DB_OBJECT
IS 'Für DB Objecte';

CREATE DOMAIN DN_DB_OBJECT_EXT
AS VARCHAR(63);

COMMENT ON DOMAIN DN_DB_OBJECT_EXT
IS 'Für SPs plus Packagesname';

CREATE DOMAIN DN_IDENTIFICATION
AS BIGINT
NOT NULL;

COMMENT ON DOMAIN DN_IDENTIFICATION
IS 'Identification einer Tabelle, Mandatory für IDs von Tabellen';
        
CREATE DOMAIN DN_FILENAME_SHORT 
AS VARCHAR(255);

COMMENT ON DOMAIN DN_FILENAME_SHORT
IS 'Dateiname ohne Pfad';

/* DN_FILENAME Birgt die Gefahr das die Dimension zu klein ist */
CREATE DOMAIN DN_FILENAME 
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_FILENAME
IS 'Dateiname mit Pfad, Dimension beachten';        
        
CREATE DOMAIN DN_DESCRIPTION 
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_DESCRIPTION
IS 'Beschreibung als String';        

CREATE DOMAIN DN_DESC_BLOB
AS BLOB SUB_TYPE TEXT;

COMMENT ON DOMAIN DN_DESC_BLOB
IS 'Beschreibung als Blob';

CREATE DOMAIN DN_CURRENT_USER 
AS VARCHAR(31)
DEFAULT CURRENT_USER
NOT NULL;

COMMENT ON DOMAIN DN_CURRENT_USER
IS 'Aktuller Benutzer, per Default am besten mit "current_user" vorbelegen';        

CREATE DOMAIN DN_CURRENT_TIMESTAMP 
AS TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
NOT NULL;

COMMENT ON DOMAIN DN_CURRENT_TIMESTAMP
IS 'Aktuelle Zeit und Datum';        

CREATE DOMAIN DN_FIREBIRD_USER 
AS VARCHAR(31);

COMMENT ON DOMAIN DN_FIREBIRD_USER
IS 'Firebird Benutzername, im Idealfall ein logischer Benutzer';        

CREATE DOMAIN DN_TIMESTAMP 
AS TIMESTAMP;

COMMENT ON DOMAIN DN_TIMESTAMP
IS 'Zeit und Datum';

CREATE DOMAIN DN_FLOAT AS
FLOAT;

COMMENT ON DOMAIN DN_FLOAT
IS 'Float';

CREATE DOMAIN DN_INTEGER AS
INTEGER;

COMMENT ON DOMAIN DN_INTEGER 
IS 'Integer';

CREATE DOMAIN DN_STRING AS
VARCHAR(4000);

COMMENT ON DOMAIN DN_STRING 
IS 'String, Dimension beachten';
        
CREATE DOMAIN DN_STRING_SHORT AS
VARCHAR(254);

COMMENT ON DOMAIN DN_STRING_SHORT 
IS 'String, Dimension beachten';

CREATE DOMAIN DN_DEBUG_ITEM
AS VARCHAR(4000)
DEFAULT 'keine Information'
NOT NULL;

COMMENT ON DOMAIN DN_DEBUG_ITEM
IS 'Debug-Info';  

CREATE DOMAIN DN_SQL_BLOB
AS BLOB SUB_TYPE TEXT;

COMMENT ON DOMAIN DN_SQL_BLOB
IS 'Umfangreiche SQL-Statements'; 

CREATE DOMAIN DN_SQL_IDENT
AS VARCHAR(64)
DEFAULT 'DEFAULT';

COMMENT ON DOMAIN DN_SQL_IDENT
IS 'Identifizierung für ein Script'; 


/* Domains für TB_HISTORY_UPDATE -----------------------------------------------------------------*/

CREATE DOMAIN DN_MAJOR_NO
AS INTEGER
DEFAULT 0
NOT NULL;

COMMENT ON DOMAIN DN_MAJOR_NO
IS 'Hauptnummer';        

CREATE DOMAIN DN_MINOR_NO
AS INTEGER
DEFAULT 0
NOT NULL;

COMMENT ON DOMAIN DN_MINOR_NO
IS 'Unternummer';

CREATE DOMAIN DN_WARN_LEVEL
AS INTEGER
DEFAULT 0
NOT NULL
CHECK (VALUE IN (0, 1, 2, 3));

COMMENT ON DOMAIN DN_WARN_LEVEL
IS 'Warnlevel: 0=Unknown / 1=Exception / 2=Warning / 3=Info';

/* Domains für TB_SETTINGS -----------------------------------------------------------------------*/

CREATE DOMAIN DN_CATEGORY AS
VARCHAR(128) CHARACTER SET WIN1252;

COMMENT ON DOMAIN DN_CATEGORY
IS 'Kategorie, z.B. Projektname';

CREATE DOMAIN DN_CATEGORY_IDENT AS
VARCHAR(128) CHARACTER SET WIN1252;

COMMENT ON DOMAIN DN_CATEGORY_IDENT
IS 'Ident, vergleichbar mit dem Ident einer Ini-Datei';

CREATE DOMAIN DN_CATEGORY_SECTION AS
VARCHAR(128) CHARACTER SET WIN1252;

COMMENT ON DOMAIN DN_CATEGORY_SECTION
IS 'Section, vergleichbar mit der Section einer Ini-Datei';

CREATE DOMAIN DN_CATEGORY_STRING_VALUE AS
VARCHAR(4069) CHARACTER SET WIN1252;
        
COMMENT ON DOMAIN DN_CATEGORY_STRING_VALUE
IS 'Value, vergleichbar mit dem Value einer Ini-Datei, Dimension beachten';
        
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/