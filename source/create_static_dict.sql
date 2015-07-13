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

/* Tables ----------------------------------------------------------------------------------------*/
CREATE TABLE SDDL$DICT_SETTING
(
  SECTION SDDL$DN_SHORT_TEXT,
  IDENT SDDL$DN_SHORT_TEXT,
  RESULT_VALUE SDDL$DN_SHORT_TEXT
);

COMMENT ON TABLE SDDL$DICT_SETTING
IS 'Einstellungen für sDDL, ähnlich einer Inidatei';

COMMENT ON COLUMN SDDL$DICT_SETTING.SECTION
IS 'Gruppe verschiedener Einstellungen';

COMMENT ON COLUMN SDDL$DICT_SETTING.IDENT
IS 'Spezielle Einstellung einer Gruppe';

COMMENT ON COLUMN SDDL$DICT_SETTING.RESULT_VALUE
IS 'Gesuchte Einstellung';

/* ------ */

CREATE TABLE SDDL$DICT_VALID_COMMAND 
(
  ID SDDL$DICT_PRIMARY_KEY,
  CAPTION SDDL$DN_VALID_COMMAND,
  DESCRIPTION SDDL$DN_DESCRIPTION,
  CONSTRAINT PK_DICT_VALID_COMMAND
    PRIMARY KEY (ID),
  CONSTRAINT ALT_DICT_VALID_COMMAND_CAPTION 
    UNIQUE (CAPTION)
);

COMMENT ON TABLE SDDL$DICT_VALID_COMMAND
IS 'Erlaubte SDDL Befehle, ohne { } angeben';

COMMENT ON COLUMN SDDL$DICT_VALID_COMMAND.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DICT_VALID_COMMAND.CAPTION
IS 'SDDL Befehl, ohne { } angeben, Befehlssyntax bezgl. erlaubte Zeichen beachten';

COMMENT ON COLUMN SDDL$DICT_VALID_COMMAND.DESCRIPTION
IS 'Beschreibung des Befehls';

/* ------ */

CREATE TABLE SDDL$DICT_VALID_ARGUMENT 
(
  ID SDDL$DICT_PRIMARY_KEY,
  CAPTION SDDL$DN_VALID_ARGUMENT,
  DESCRIPTION SDDL$DN_DESCRIPTION,
  CONSTRAINT PK_DICT_VALID_ARGUMENT
    PRIMARY KEY (ID),
  CONSTRAINT ALT_DICT_VALID_ARGUMENT_CAPTION 
    UNIQUE (CAPTION) 
);

COMMENT ON TABLE SDDL$DICT_VALID_ARGUMENT
IS 'Erlaubte Argumente eines SDDL Befehls';

COMMENT ON COLUMN SDDL$DICT_VALID_ARGUMENT.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DICT_VALID_ARGUMENT.CAPTION
IS 'Argument eines SDDL Befehls, Befehlssyntax bezgl. erlaubte Zeichen beachten';

COMMENT ON COLUMN SDDL$DICT_VALID_ARGUMENT.DESCRIPTION
IS 'Beschreibung des Argumentes';

/* ------ */

CREATE TABLE SDDL$DICT_REL_CMD_ARG 
(
  COMMAND SDDL$DN_VALID_COMMAND,
  ARGUMENT SDDL$DN_VALID_ARGUMENT,
  ARGUMENT_INDEX SDDL$DN_INDEX,
  CONSTRAINT PK_CODE_REL_COMMAND_ARGUMENT
    PRIMARY KEY (COMMAND, ARGUMENT, ARGUMENT_INDEX),
  CONSTRAINT FK_RC_DICT_REL_CMD_ARG 
    FOREIGN KEY (COMMAND) REFERENCES SDDL$DICT_VALID_COMMAND (CAPTION)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_RA_DICT_REL_CMD_ARG 
    FOREIGN KEY (ARGUMENT) REFERENCES SDDL$DICT_VALID_ARGUMENT (CAPTION)
    ON DELETE CASCADE ON UPDATE CASCADE       
);

COMMENT ON TABLE SDDL$DICT_REL_CMD_ARG
IS 'Befehle mit Argumenten verbinden';

COMMENT ON COLUMN SDDL$DICT_REL_CMD_ARG.COMMAND
IS 'SDDL Befehl';

COMMENT ON COLUMN SDDL$DICT_REL_CMD_ARG.ARGUMENT
IS 'Argument mit einem SDDL Befehl verknüpfen';

COMMENT ON COLUMN SDDL$DICT_REL_CMD_ARG.ARGUMENT_INDEX
IS 'Index mit einem Argument verbinden';

/* ------ */

CREATE TABLE SDDL$CODE_COMMAND 
(
  ID SDDL$DICT_PRIMARY_KEY,
  COMMAND SDDL$DN_VALID_COMMAND,
  DDL_CODE SDDL$DN_CODE,
  DDL_CODE_COMMENT SDDL$DN_ORIGINAL_COMMENT,
  CONSTRAINT PK_CODE_COMMAND
    PRIMARY KEY (ID),
  CONSTRAINT FK_CC_CODE_COMMAND 
    FOREIGN KEY (COMMAND) REFERENCES SDDL$DICT_VALID_COMMAND (CAPTION)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ALT_CODE_COMMAND 
    UNIQUE (COMMAND)                  
);

COMMENT ON TABLE SDDL$CODE_COMMAND
IS 'Befehle mit DDL-Code verbinden:
Wird ein SDDL Befehl vom Parser erkannt wird der hier hinterlegte Code zur Grundlage genommen,
um das DDL-Statement zum SDDL Befehl zu erstellen';

COMMENT ON COLUMN SDDL$CODE_COMMAND.COMMAND
IS 'SDDL Befehl';

COMMENT ON COLUMN SDDL$CODE_COMMAND.DDL_CODE
IS 'DDL-Code für einen SDDL Befehl:
Im DDL-Code können variable Bereich eingerichtet werden (s. SDDL-Code Referenz)';

COMMENT ON COLUMN SDDL$CODE_COMMAND.DDL_CODE_COMMENT
IS 'DDL-Komentar zum SDDL-Code:
Im DDL-Komentar können variable Bereiche eingerichtet werden (s. SDDL-Code Referenz)';

/* ------ */

CREATE TABLE SDDL$CODE_ARGUMENT 
(
  ID SDDL$DICT_PRIMARY_KEY,
  ARGUMENT SDDL$DN_VALID_ARGUMENT,
  DDL_CODE SDDL$DN_CODE,
  DDL_CODE_COMMENT SDDL$DN_ORIGINAL_COMMENT,
  CONSTRAINT PK_CODE_ARGUMENT
    PRIMARY KEY (ID),
  CONSTRAINT FK_AA_CODE_ARGUMENT 
    FOREIGN KEY (ARGUMENT) REFERENCES SDDL$DICT_VALID_ARGUMENT (CAPTION)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ALT_CODE_ARGUMENT 
    UNIQUE (ARGUMENT)                  
);

COMMENT ON TABLE SDDL$CODE_ARGUMENT
IS 'Argumente eines SDDL-Befehls mit DDL-Code verbinden:
Wird ein Argument zu einem SDDL Befehl vom Parser erkannt wird der hier hinterlegte Code zur Grundlage genommen,
um das DDL-Statement für das Argument zu erstellen';

COMMENT ON COLUMN SDDL$CODE_ARGUMENT.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$CODE_ARGUMENT.ARGUMENT
IS 'Argument zu einem SDDL Befehl';

COMMENT ON COLUMN SDDL$CODE_ARGUMENT.DDL_CODE
IS 'DDL-Code für einen SDDL Befehl:
Im DDL-Code können variable Bereich eingerichtet werden (s. SDDL-Code Referenz)';

COMMENT ON COLUMN SDDL$CODE_ARGUMENT.DDL_CODE_COMMENT
IS 'DDL-Komentar zum SDDL-Code:
Im DDL-Komentar können variable Bereiche eingerichtet werden (s. SDDL-Code Referenz)';

/* ------ */

CREATE TABLE SDDL$CODE_DEFAULT_DOMAIN 
(
  ID SDDL$DICT_PRIMARY_KEY,
  CAPTION SDDL$DN_DB_OBJ,
  DDL_CODE SDDL$DN_CODE_BLOB,
  CONSTRAINT PK_CODE_DEFAULT_DOMAINS
    PRIMARY KEY (ID),
  CONSTRAINT ALT_CODE_DEFAULT_DOMAINS 
    UNIQUE (CAPTION)  
);

COMMENT ON TABLE SDDL$CODE_DEFAULT_DOMAIN
IS 'Standarddomainen:
Für Standardfelder werden die notwendigen Datentypen über Standarddomainen zur Verfügung gestellt';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_DOMAIN.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_DOMAIN.CAPTION
IS 'Name der Domain';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_DOMAIN.DDL_CODE
IS 'Domain DDL Code';

/* ------ */

CREATE TABLE SDDL$CODE_DEFAULT_FIELD 
(
  ID SDDL$DICT_PRIMARY_KEY,
  CAPTION SDDL$DN_DB_OBJ,
  FIELD_DOMAIN SDDL$DN_DB_OBJ,
  RELATIV_POSITION SDDL$DN_INDEX,
  CONSTRAINT PK_CODE_DEFAULT_FIELD
    PRIMARY KEY (ID),
  CONSTRAINT FK_DD_CODE_DEFAULT_FIELD 
    FOREIGN KEY (FIELD_DOMAIN) REFERENCES SDDL$CODE_DEFAULT_DOMAINS (CAPTION)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ALT_CODE_DEFAULT_FIELD 
    UNIQUE (CAPTION)       
);

COMMENT ON TABLE SDDL$CODE_DEFAULT_FIELD
IS 'Standarddomainen:
Für Standardfelder werden die notwendigen Datentypen über Standarddomainen zur Verfügung gestellt';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_FIELD.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_FIELD.CAPTION
IS 'Feldname';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_FIELD.FIELD_DOMAIN
IS 'Domain des Feldes: Ist immer ein Fremdschlüssel aus der Tabelle SDDL$CODE_DEFAULT_DOMAINS';

COMMENT ON COLUMN SDDL$CODE_DEFAULT_FIELD.RELATIV_POSITION
IS 'Relative Postion in der Tabelle';

/* Index -----------------------------------------------------------------------------------------*/
CREATE UNIQUE INDEX SDDL$UNQ_IDX_DICT_REL_CMD_ARG ON SDDL$DICT_REL_CMD_ARG 
(COMMAND, ARGUMENT, ARGUMENT_INDEX);

/* Trigger ---------------------------------------------------------------------------------------*/
SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_CODE_DEFAULT_FIELD_BI FOR SDDL$CODE_DEFAULT_FIELD
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_CODE_DEFAULT_FIELD_ID; 
END^
SET TERM ; ^  
  
/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DEFAULT_DOMAIN_BI FOR SDDL$CODE_DEFAULT_DOMAIN
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_CODE_DEFAULT_DOMAIN_ID; 
END^
SET TERM ; ^  
  
/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_CODE_ARGUMENT_BI FOR SDDL$CODE_ARGUMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_CODE_ARGUMENT_ID; 
END^
SET TERM ; ^  
  
/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_CODE_COMMAND_BI FOR SDDL$CODE_COMMAND
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_CODE_COMMAND_ID; 
END^
SET TERM ; ^  
  
/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DICT_VALID_COMMAND_BI FOR SDDL$DICT_VALID_COMMAND
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DICT_VALID_COMMAND_ID; 
END^
SET TERM ; ^  
  
/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DICT_VALID_ARGUMENT_BI FOR SDDL$DICT_VALID_ARGUMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DICT_VALID_ARGUMENT_ID; 
END^
SET TERM ; ^

/* Views -----------------------------------------------------------------------------------------*/
CREATE OR ALTER VIEW SDDL$V_CODE_DEFAULT_DOMAIN (
  ID,
  CAPTION,
  DDL_CODE)
AS
SELECT
  ID,
  CAPTION,
  DDL_CODE
FROM
  SDDL$CODE_DEFAULT_DOMAIN;

COMMENT ON VIEW SDDL$V_CODE_DEFAULT_DOMAIN
IS 'Standardview für SDDL$CODE_DEFAULT_DOMAIN';  
  
/* ------ */

CREATE OR ALTER VIEW SDDL$V_CODE_DEFAULT_FIELD (
  ID,
  CAPTION,
  FIELD_DOMAIN,
  RELATIV_POSITION)
AS
SELECT
  ID,
  CAPTION,
  FIELD_DOMAIN,
  RELATIV_POSITION
FROM
  SDDL$CODE_DEFAULT_FIELD;

COMMENT ON VIEW SDDL$V_CODE_DEFAULT_FIELD
IS 'Standardview für SDDL$CODE_DEFAULT_FIELD';  
  
/* ------ */

CREATE OR ALTER VIEW SDDL$V_CODE_COMMAND (
  ID,
  COMMAND,
  DDL_CODE,
  DDL_CODE_COMMENT)
AS
SELECT
  ID,
  COMMAND,
  DDL_CODE,
  DDL_CODE_COMMENT
FROM
  SDDL$CODE_COMMAND;
  
COMMENT ON VIEW SDDL$V_CODE_COMMAND
IS 'Standardview für SDDL$CODE_COMMAND';  
  
/* ------ */

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
  
COMMENT ON VIEW SDDL$V_DICT_SETTING
IS 'Standardview für SDDL$DICT_SETTING';  
  
/* ------ */

CREATE OR ALTER VIEW SDDL$V_DICT_VALID_COMMAND(
  ID,
  CAPTION,
  DESCRIPTION)
AS
SELECT
  ID,
  CAPTION,
  DESCRIPTION
FROM
  SDDL$DICT_VALID_COMMAND;   

COMMENT ON VIEW SDDL$V_DICT_VALID_COMMAND
IS 'Standardview für SDDL$DICT_VALID_COMMAND';

/* ------ */

CREATE OR ALTER VIEW SDDL$V_DICT_VALID_ARGUMENT(
  ID,
  CAPTION,
  DESCRIPTION)
AS
SELECT
  ID,
  CAPTION,
  DESCRIPTION
FROM
  SDDL$DICT_VALID_ARGUMENT;   

COMMENT ON VIEW SDDL$V_DICT_VALID_ARGUMENT
IS 'Standardview für SDDL$DICT_VALID_ARGUMENT';

/* ------ */

CREATE OR ALTER VIEW SDDL$V_DICT_REL_CMD_ARG(
  COMMAND,
  ARGUMENT,
  ARGUMENT_INDEX)
AS
SELECT
  COMMAND,
  ARGUMENT,
  ARGUMENT_INDEX
FROM
  SDDL$DICT_REL_CMD_ARG;
  
COMMENT ON VIEW SDDL$V_DICT_REL_CMD_ARG
IS 'Standardview für SDDL$DICT_REL_CMD_ARG';  

/* SPs -------------------------------------------------------------------------------------------*/
SET TERM ^ ;
CREATE OR ALTER PROCEDURE SDDL$SP_GET_SETTING(
  ASection SDDL$DN_SHORT_TEXT,
  AIdent SDDL$DN_SHORT_TEXT,
  ADefault SDDL$DN_SHORT_TEXT) 
RETURNS ( 
  RESULT_VALUE SDDL$DN_SHORT_TEXT)
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

COMMENT ON PROCEDURE SDDL$SP_GET_SETTING 
IS 'Ermittelt einen Eintrag aus der Setting Tabelle';

/* ------ */

SET TERM ^ ;
CREATE OR ALTER PROCEDURE SDDL$SP_SET_SETTING(
  ASection SDDL$DN_SHORT_TEXT,
  AIdent SDDL$DN_SHORT_TEXT,
  AValue SDDL$DN_SHORT_TEXT)
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

COMMENT ON PROCEDURE SDDL$SP_SET_SETTING 
IS 'Fügt einen Eintrag in die Setting Tabelle ein bzw. aktualisiert einen bestehenden Eintrag';

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/