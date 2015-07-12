/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-11                                                        
/* Purpose: Erstellt die Domains   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*              
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-11
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* Domains ---------------------------------------------------------------------------------------*/
CREATE DOMAIN SDDL$DN_CODE
AS VARCHAR(4000)
DEFAULT ''
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_CODE 
IS 'z. B.: DDL-Code';

/* ------ */

CREATE DOMAIN SDDL$DN_ASSIGNMENT
AS VARCHAR(64)
DEFAULT ''
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_ASSIGNMENT 
IS 'Bezeichner';

/* ------ */

CREATE DOMAIN SDDL$DN_INDEX
AS INTEGER
DEFAULT 0
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_INDEX
IS 'Argumentindex';

/* ------ */

CREATE DOMAIN SDDL$DN_DESCRIPTION
AS VARCHAR(2000);

COMMENT ON DOMAIN SDDL$DN_DESCRIPTION 
IS 'Beschreibung';

/* ------ */

CREATE DOMAIN SDDL$DN_VALID_ARGUMENT
AS VARCHAR(10)
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_VALID_ARGUMENT 
IS 'Erlaubtes Argument';

/* ------ */

CREATE DOMAIN SDDL$DN_VALID_COMMAND
AS VARCHAR(10)
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_VALID_COMMAND 
IS 'Erlaubte Befehle';

/* ------ */

CREATE DOMAIN SDDL$DN_SHORT_TEXT
AS VARCHAR(254)
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_SHORT_TEXT 
IS 'Varchar mit 254 Zeichen';

/* ------ */

CREATE DOMAIN SDDL$DN_OBJ_NAME
AS VARCHAR(31)
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_OBJ_NAME 
IS '31 Zeichen für einen Datenbankobjektnamen';

/* ------ */

CREATE DOMAIN SDDL$DICT_PRIMARY_KEY
AS BIGINT
NOT NULL;

COMMENT ON DOMAIN SDDL$DICT_PRIMARY_KEY 
IS 'Primärschlüssel';

/* ------ */

CREATE DOMAIN SDDL$DN_FOREIGN_KEY
AS BIGINT;

COMMENT ON DOMAIN SDDL$DN_FOREIGN_KEY 
IS 'Fremdschlüssel';

/* ------ */

CREATE DOMAIN SDDL$DN_ORIGIN_TYPE
AS VARCHAR(10)
DEFAULT 'UNKOWN'
NOT NULL
CHECK (VALUE IN ('UNKNOWN', 'TABLE', 'FIELD'));

COMMENT ON DOMAIN SDDL$DN_ORIGIN_TYPE
IS 'Quelle der sDDL Befehle';

/* ------ */

CREATE DOMAIN SDDL$DN_COMMAND_CHAIN
AS VARCHAR(4000)
DEFAULT ''
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_COMMAND_CHAIN
IS 'Befehlskette';

/* ------ */

CREATE DOMAIN SDDL$DN_ORIGINAL_COMMENT
AS VARCHAR(4000)
DEFAULT ''
NOT NULL;

COMMENT ON DOMAIN SDDL$DN_ORIGINAL_COMMENT
IS 'Kommentar ohne Befehlskette';

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/