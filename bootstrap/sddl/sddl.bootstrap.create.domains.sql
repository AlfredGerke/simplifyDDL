/*------------------------------------------------------------------------------------------------*/
/* ###Description: 
/*   * Es wirden alle notwendigen Domains für das sDDL angelegt
/*   * Die aufgerufenen Befehle setzen eine Firebird 3.0.x voraus             
/*   * Ein Connect zu einer Datenbank wird vorausgesetzt                                                                          
/*   
/* Initial Developer: AGE
/*
/*------------------------------------------------------------------------------------------------*/
/*
/* Last modified: $Date:$
/* Revision:      $Revision:$
/* Author:        $Author:$
/*------------------------------------------------------------------------------------------------*/

/* Domains für das sDDL-Bootstrap ----------------------------------------------------------------*/

CREATE DOMAIN DN_SQLCLASS
AS VARCHAR(2);

COMMENT ON DOMAIN DN_SQLCLASS 
IS 'SQL Klasse (http://www.firebirdsql.org/rlsnotesh/rlsnotes25.html#d0e23524)';

CREATE DOMAIN DN_SQLSTATE
AS VARCHAR(5);

COMMENT ON DOMAIN DN_SQLSTATE 
IS 'SQL Statuscode (http://www.firebirdsql.org/rlsnotesh/rlsnotes25.html#d0e23524)';

CREATE DOMAIN DN_GEN_COMMAND
AS VARCHAR(254)
NOT NULL;

COMMENT ON DOMAIN DN_GEN_COMMAND
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
IS 'Kürzel';

CREATE DOMAIN DN_PREFIX_PLUS
AS VARCHAR(64);

COMMENT ON DOMAIN DN_PREFIX_PLUS
IS 'Kürzel';

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
IS 'Einfacher Typ für Position/Index';

CREATE DOMAIN DN_COLUMNLIST_SEPARATOR
AS VARCHAR(1)
DEFAULT ','
CHECK (VALUE IN (',', ';'));

COMMENT ON DOMAIN DN_COLUMNLIST_SEPARATOR
IS 'Separator';
            
/* DN_COLUMNLIST birgt die Gefahr das die Dimension zu klein ist */            
CREATE DOMAIN DN_COLUMNLIST
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_COLUMNLIST
IS 'Spaltenliste';

/* DN_SQL_STMT birgt die Gefahr das die Dimension zu klein ist */
CREATE DOMAIN DN_SQL_STMT
AS VARCHAR(6000);

COMMENT ON DOMAIN DN_SQL_STMT
IS 'für einfache SQL Statements';

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

CREATE DOMAIN DN_IDENTIFICATION
AS BIGINT
NOT NULL;

COMMENT ON DOMAIN DN_IDENTIFICATION
IS 'Identification einer Tabelle';
        
CREATE DOMAIN DN_FILENAME_SHORT 
AS VARCHAR(255);

COMMENT ON DOMAIN DN_FILENAME_SHORT
IS 'Dateiname ohne Pfad';

CREATE DOMAIN DN_FILENAME 
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_FILENAME
IS 'Dateiname';        
        
CREATE DOMAIN DN_DESCRIPTION 
AS VARCHAR(4000);

COMMENT ON DOMAIN DN_DESCRIPTION
IS 'Beschreibung';        

CREATE DOMAIN DN_CURRENT_USER 
AS VARCHAR(31)
DEFAULT CURRENT_USER
NOT NULL;

COMMENT ON DOMAIN DN_CURRENT_USER
IS 'Aktuller Benutzer';        

CREATE DOMAIN DN_CURRENT_TIMESTAMP 
AS TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
NOT NULL;

COMMENT ON DOMAIN DN_CURRENT_TIMESTAMP
IS 'Aktuelle Zeit und Datum';        

CREATE DOMAIN DN_FIREBIRD_USER 
AS VARCHAR(31);

COMMENT ON DOMAIN DN_FIREBIRD_USER
IS 'Firebird Benutzername';        

CREATE DOMAIN DN_TIMESTAMP 
AS TIMESTAMP;

COMMENT ON DOMAIN DN_TIMESTAMP
IS 'Zeit und Datum';        

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

/* Domains für TB_SETTINGS -----------------------------------------------------------------------*/

CREATE DOMAIN DN_CATEGORY AS
VARCHAR(128) CHARACTER SET WIN1252;

CREATE DOMAIN DN_CATEGORY_IDENT AS
VARCHAR(128) CHARACTER SET WIN1252;

CREATE DOMAIN DN_CATEGORY_SECTION AS
VARCHAR(128) CHARACTER SET WIN1252;

CREATE DOMAIN DN_CATEGORY_STRING_VALUE AS
VARCHAR(4069) CHARACTER SET WIN1252;
        
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/