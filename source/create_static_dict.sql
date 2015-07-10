/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-10                                                        
/* Purpose: Erstellt das statische Dcitionary   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*              
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-10
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* Domains */
CREATE DOMAIN DICT_SHORT_TEXT
AS VARCHAR(254)
NOT NULL;

COMMENT ON DOMAIN DICT_SHORT_TEXT 
IS 'Varchar mit 254 Zeichen';

/* Tables */
CREATE TABLE SDDL$DICT_SETTING
(
  SECTION DICT_SHORT_TEXT,
  IDENT DICT_SHORT_TEXT,
  RESULT_VALUE DICT_SHORT_TEXT
);

COMMENT ON TABLE SDDL$DICT_SETTING
IS 'Einstellungen für sDDL';

COMMENT ON COLUMN SDDL$DICT_SETTING.SECTION
IS 'Sektion';

COMMENT ON COLUMN SDDL$DICT_SETTING.IDENT
IS 'Ident';

COMMENT ON COLUMN SDDL$DICT_SETTING.RESULT_VALUE
IS 'Value';

/* Views */
CREATE OR ALTER VIEW SDDL$V_DICT_SETTING ( 
  SECTION,
  IDENT,
  RESULT_VALUE)
AS
SELECT
  SECTION,
  IDENT,
  RESULT_VALUE
FROM
  SDDL$DICT_SETTING;

/* SPs */
SET TERM ^ ;
CREATE OR ALTER PROCEDURE SDDL$SP_GET_VALUE(
  ASection DICT_SHORT_TEXT,
  AIdent DICT_SHORT_TEXT,
  ADefault DICT_SHORT_TEXT) 
RETURNS ( 
  RESULT_VALUE DICT_SHORT_TEXT)
AS 
BEGIN
  RESULT_VALUE = ADefault;
  
  select 
    RESULT_VALUE
  from 
    SDDL$V_DICT_SETTING
  where 
    SECTION=:ASection
  and 
    IDENT=:AIdent
  into 
    :RESULT_VALUE;
  
  suspend;
END^
SET TERM ; ^

COMMENT ON PROCEDURE SDDL$SP_GET_VALUE 
IS 'Ermittelt einen Eintrag aus der Setting Tabelle';

SET TERM ^ ;
CREATE OR ALTER PROCEDURE SDDL$SP_SET_VALUE(
  ASection DICT_SHORT_TEXT,
  AIdent DICT_SHORT_TEXT,
  AValue DICT_SHORT_TEXT)
AS 
BEGIN
  update or insert
  into
  SDDL$V_DICT_SETTING
  (
    SECTION,
    IDENT,
    RESULT_VALUE
  )
  values
  (
    :ASection,
    :AIdent,
    :AValue
  )
  matching (SECTION, IDENT);
END^
SET TERM ; ^

COMMENT ON PROCEDURE SDDL$SP_SET_VALUE 
IS 'Fügt einen Eintrag in die Setting Tabelle ein bzw. aktualisiert einen bestehenden Eintrag';

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/