/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-11                                                        
/* Purpose: Erstellt das dynamische Dcitionary   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*              
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-11
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* Tables ----------------------------------------------------------------------------------------*/
CREATE TABLE SDDL$DYN_TABLE_COMMENT  
(
  ID SDDL$DICT_PRIMARY_KEY,
  DB_OJB_NAME SDDL$DN_OBJ_NAME,
  ORIGIN_TYPE SDDL$DN_ORIGIN_TYPE,
  COMMAND_CHAIN SDDL$DN_COMMAND_CHAIN,
  ORIGINAL_COMMENT SDDL$DN_ORIGINAL_COMMENT,
  CONSTRAINT PK_DYN_TABLE_COMMENT
    PRIMARY KEY (ID)
);

COMMENT ON TABLE SDDL$DYN_TABLE_COMMENT
IS 'Tabellenkomentare und Befehlsketten: 
Im ersten Schritt werden Befehlsketten und Originalkommentare von einander getrennt.
Sollten in Feldern der Tabelle Befehlsketten gefunden werden, 
muss für die Tabelle ein Eintrag hinterlegt werden,
auch wenn in der Tabelle keine Befehlsketten vorhanden sind';

COMMENT ON COLUMN SDDL$DYN_TABLE_COMMENT.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DYN_TABLE_COMMENT.DB_OJB_NAME
IS 'Name der geparsten Tabelle';

COMMENT ON COLUMN SDDL$DYN_TABLE_COMMENT.ORIGIN_TYPE
IS 'Herkunft von Originalkommentar und Befehlskette, z.B.: TABLE';

COMMENT ON COLUMN SDDL$DYN_TABLE_COMMENT.COMMAND_CHAIN
IS 'Komplette Befehlskette getrennt vom Originalkommentar der Tabelle.
Befehle komplett mit { } angeben, Befehlssyntax bezgl. erlaubte Zeichen beachten';

COMMENT ON COLUMN SDDL$DYN_TABLE_COMMENT.ORIGINAL_COMMENT
IS 'Originalkommentar der Tabelle';

/* ------ */

CREATE TABLE SDDL$DYN_FIELD_COMMENT  
(
  ID SDDL$DICT_PRIMARY_KEY,
  TABLE_ID SDDL$DN_FOREIGN_KEY,
  DB_OJB_NAME SDDL$DN_OBJ_NAME,
  ORIGIN_TYPE SDDL$DN_ORIGIN_TYPE,
  COMMAND_CHAIN SDDL$DN_COMMAND_CHAIN,
  ORIGINAL_COMMENT SDDL$DN_ORIGINAL_COMMENT,
  CONSTRAINT PK_DYN_FIELD_COMMENT
    PRIMARY KEY (ID),
  CONSTRAINT FK_FT_DYN_FIELD_COMMENT_TABLE 
    FOREIGN KEY (TABLE_ID) REFERENCES SDDL$DYN_TABLE_COMMENT (ID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

COMMENT ON TABLE SDDL$DYN_FIELD_COMMENT
IS 'Feldkomentare und Befehlsketten: 
Im ersten Schritt werden Befehlsketten und Originalkommentare von einander getrennt';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.ID
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.TABLE_ID
IS 'Fremdschlüssel aus SDDL$DYN_TABLE_COMMENT: 
Für ein Feld muss immer ein Tabelleneintrag in SDDL$DYN_TABLE_COMMENT vorgenommen werden,
auch wenn in der Tabelle keine Befehlskette vorhanden ist';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.DB_OJB_NAME
IS 'Name des geparsten Feldes';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.ORIGIN_TYPE
IS 'Herkunft von Originalkommentar und Befehlskette, z.B.: FIELD';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.COMMAND_CHAIN
IS 'Komplette Befehlskette getrennt vom Originalkommentar des Feldes.
Befehle komplett mit { } angeben, Befehlssyntax bezgl. erlaubte Zeichen beachten';

COMMENT ON COLUMN SDDL$DYN_FIELD_COMMENT.ORIGINAL_COMMENT
IS 'Originalkommentar des Feldes';

/* ------ */

CREATE TABLE SDDL$DYN_PARSED_COMMAND 
(
  ID SDDL$DICT_PRIMARY_KEY,
  TABLE_ID SDDL$DN_FOREIGN_KEY NOT NULL,
  FIELD_ID SDDL$DN_FOREIGN_KEY,
  ORIGIN_TYPE SDDL$DN_ORIGIN_TYPE,
  COMMAND SDDL$DN_VALID_COMMAND,
  EXECUTION_ORDER SDDL$DN_INDEX,
  CONSTRAINT PK_DYN_PARSED_COMMAND
    PRIMARY KEY (ID),
  CONSTRAINT FK_FT_DYN_PARSED_COMMAND 
    FOREIGN KEY (TABLE_ID) REFERENCES SDDL$DYN_TABLE_COMMENT (ID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_FF_DYN_PARSED_COMMAND 
    FOREIGN KEY (FIELD_ID) REFERENCES SDDL$DYN_FIELD_COMMENT (ID)
    ON DELETE SET NULL ON UPDATE CASCADE    
);

COMMENT ON TABLE SDDL$DYN_PARSED_COMMAND 
IS 'Geparste SDDL Befehle:
Im zweiten Schritt werden die Befehlsketten in einzelne Befehle zerlegt und in eine Reihenfolge gebracht.
Der Parser wird die Befehle in notwenige Reihenfolge eintragen s. Feld: EXECUTION_ORDER';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.ID 
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.TABLE_ID 
IS 'Fremdschlüssel aus SDDL$DYN_TABLE_COMMENT:
Es muss immer eine Tabellenreferenz bekannt sein, 
auch dann wenn in der Tabelle keine Befehlskette vorhanden ist, sondern nur in deren Feldern';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.FIELD_ID 
IS 'Fremdschlüssel aus SDDL$DYN_FIELD_COMMENT';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.ORIGIN_TYPE 
IS 'Herkunft von Originalkommentar und geparsten Befehl, z.B.: TABLE oder FIELD';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.COMMAND 
IS 'Fremdschlüssel aus SDDL$DICT_VALID_COMMAND:
Geparster Befehl aus einer Befehlskette einer Tabelle oder eines Feldes.
Befehle ohne { } angeben, Befehlssyntax bezgl. erlaubte Zeichen beachten';

COMMENT ON COLUMN SDDL$DYN_PARSED_COMMAND.EXECUTION_ORDER 
IS 'Ausführungsreihenfolge:
Der Parser wird über die Ausführungsreihenfolge sicher stellen,
das DDL Befehle in der richtigen Reihenfolge erstellt werden.';

/* ------ */

CREATE TABLE SDDL$DYN_ASSIGNMENT 
(
  ID SDDL$DICT_PRIMARY_KEY,
  COMMAND_ID SDDL$DN_FOREIGN_KEY NOT NULL,
  ASSIGNMENT SDDL$DN_ASSIGNMENT,
  CONSTRAINT PK_DYN_ASSIGNMENT
    PRIMARY KEY (ID),
  CONSTRAINT FK_AC_DYN_PARSED_COMMAND 
    FOREIGN KEY (COMMAND_ID) REFERENCES SDDL$DYN_PARSED_COMMAND (ID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ALT_DYN_ASSIGNMENT 
    UNIQUE (COMMAND_ID)        
);

COMMENT ON TABLE SDDL$DYN_ASSIGNMENT 
IS 'Zuweisung zu einem Befehel:
Bezeichner werden mit einem := zugwiesen und von führenden und abschließenden %% Paare eingeschlossen.
In dieser Tabelle werden die Bezeichner ohne %% Paare angegeben';

COMMENT ON COLUMN SDDL$DYN_ASSIGNMENT.ID 
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DYN_ASSIGNMENT.COMMAND_ID
IS 'Fremdschlüssel aus SDDL$DYN_PARSED_COMMAND:
Zu einem SDDL Befehl kann es nur nur einen Bezeichner geben';

COMMENT ON COLUMN SDDL$DYN_ASSIGNMENT.ASSIGNMENT
IS 'Bezeichner ohne %% Paare angeben, Befehlssyntax bezgl. erlaubte Zeichen beachten';

/* ------ */

CREATE TABLE SDDL$DYN_ARGUMENT
(
  ID SDDL$DICT_PRIMARY_KEY,
  COMMAND_ID SDDL$DN_FOREIGN_KEY NOT NULL,
  ARGUMENT_INDEX SDDL$DN_INDEX,
  ARGUMENT SDDL$DN_VALID_ARGUMENT,
  CONSTRAINT PK_DYN_ARGUMENT
    PRIMARY KEY (ID),
  CONSTRAINT FK_AC_DYN_ARGUMENT 
    FOREIGN KEY (COMMAND_ID) REFERENCES SDDL$DYN_PARSED_COMMAND (ID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT UNQ_DYN_ARGUMENT 
    UNIQUE (COMMAND_ID, ARGUMENT_INDEX)    
);

COMMENT ON TABLE SDDL$DYN_ARGUMENT 
IS 'Argument zu einem Befehel:
Argumente werden mit einem Index angegeben der über ein : dem Argument zugwiesen wird,z. B.: 0:DCUC';

COMMENT ON COLUMN SDDL$DYN_ARGUMENT.ID 
IS 'Primärschlüssel';

COMMENT ON COLUMN SDDL$DYN_ARGUMENT.COMMAND_ID
IS 'Fremdschlüssel aus SDDL$DYN_PARSED_COMMAND:
Zu einem SDDL Befehl kann es beliebig viele Argumente geben';

COMMENT ON COLUMN SDDL$DYN_ARGUMENT.ARGUMENT_INDEX
IS 'Argumentindex:
Der Argumentindex wird dem Argument immer voran gestellt, z.B.: 0:DCUC, 0 ist in diesem Fall der Argumentindex.
Der Argumentindex bestimmt die Reihenfolge wie Argument verarbeitet werden müssen.';

COMMENT ON COLUMN SDDL$DYN_ARGUMENT.ARGUMENT
IS 'Argument zu einem SDDL Befehl:
Über Argument wird eine SDDL Befehl Initialisiert. 
z.B.: {FK:=TABELLE.ID;0:DCUC}
FK ist ein SDDL Befehl um einen Fremdschlüssel für die Tabelle TABELLE auf der Spalte ID einzurichten.
0:DCUC ist ein Argument mit dem Index 0, welches bestimmt das der Fremdschlüssel mit der Anweisung 
ON DELETE CASCADE ON UPDATE CASCADE eingerichtet werden soll';

/* Trigger ---------------------------------------------------------------------------------------*/
SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DYN_ARGUMENT_BI FOR SDDL$DYN_ARGUMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DYN_ARGUMENT_ID;  
END^
SET TERM ; ^

/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DYN_ASSIGNMENT_BI FOR SDDL$DYN_ASSIGNMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DYN_ASSIGNMENT_ID;  
END^
SET TERM ; ^

/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DYN_PARSED_COMMAND_BI FOR SDDL$DYN_PARSED_COMMAND
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DYN_PARSED_COMMAND_ID;  
END^
SET TERM ; ^

/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DYN_TABLE_COMMENT_BI FOR SDDL$DYN_TABLE_COMMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DYN_TABLE_COMMENT_ID; 
    
  if (new.ORIGIN_TYPE is null) then
    new.ORIGIN_TYPE = 'TABLE';  
END^
SET TERM ; ^

/* ------ */

SET TERM ^ ;
CREATE TRIGGER SDDL$TRG_DYN_FIELD_COMMENT_BI FOR SDDL$DYN_FIELD_COMMENT
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN 
  if (new.ID is null) then
    new.ID = next value for SDDL$SEQ_DYN_FIELD_COMMENT_ID; 
    
  if (new.ORIGIN_TYPE is null) then
    new.ORIGIN_TYPE = 'FIELD';  
END^
SET TERM ; ^

/* Views -----------------------------------------------------------------------------------------*/
CREATE OR ALTER VIEW SDDL$V_DYN_ARGUMENT (
  ID,
  COMMAND_ID,
  ARGUMENT_INDEX,
  ARGUMENT)
AS
SELECT
  ID,
  COMMAND_ID,
  ARGUMENT_INDEX,
  ARGUMENT
FROM
  SDDL$DYN_ARGUMENT;

COMMENT ON VIEW SDDL$V_DYN_ARGUMENT
IS 'Standardview für SDDL$DYN_ARGUMENT';     

/* ------ */

CREATE OR ALTER VIEW SDDL$V_DYN_TABLE_COMMENT (
  ID,
  DB_OJB_NAME,
  ORIGIN_TYPE,
  COMMAND_CHAIN,
  ORIGINAL_COMMENT)
AS
SELECT
  ID,
  DB_OJB_NAME,
  ORIGIN_TYPE,
  COMMAND_CHAIN,
  ORIGINAL_COMMENT
FROM
  SDDL$DYN_TABLE_COMMENT;
  
COMMENT ON VIEW SDDL$V_DYN_TABLE_COMMENT
IS 'Standardview für SDDL$DYN_TABLE_COMMENT';     
  
/* ------ */  
  
CREATE OR ALTER VIEW SDDL$V_DYN_FIELD_COMMENT (
  ID,
  TABLE_ID,
  DB_OJB_NAME,
  ORIGIN_TYPE,
  COMMAND_CHAIN,
  ORIGINAL_COMMENT)
AS
SELECT
  ID,
  TABLE_ID,
  DB_OJB_NAME,
  ORIGIN_TYPE,
  COMMAND_CHAIN,
  ORIGINAL_COMMENT
FROM
  SDDL$DYN_FIELD_COMMENT;
  
COMMENT ON VIEW SDDL$V_DYN_FIELD_COMMENT
IS 'Standardview für SDDL$DYN_FIELD_COMMENT';  

/* ------ */

CREATE OR ALTER VIEW SDDL$V_DYN_PARSED_COMMAND (
  ID,
  TABLE_ID,
  FIELD_ID,
  ORIGIN_TYPE,
  COMMAND,
  EXECUTION_ORDER)
AS
SELECT
  ID,
  TABLE_ID,
  FIELD_ID,
  ORIGIN_TYPE,
  COMMAND,
  EXECUTION_ORDER
FROM
  SDDL$DYN_PARSED_COMMAND;

COMMENT ON VIEW SDDL$V_DYN_PARSED_COMMAND
IS 'Standardview für SDDL$DYN_PARSED_COMMAND';  

/* ------ */

CREATE OR ALTER VIEW SDDL$V_DYN_ASSIGNMENT (
  ID,
  COMMAND_ID,
  ASSIGNMENT)
AS
SELECT
  ID,
  COMMAND_ID,
  ASSIGNMENT
FROM
  SDDL$DYN_ASSIGNMENT;

COMMENT ON VIEW SDDL$V_DYN_ASSIGNMENT
IS 'Standardview für SDDL$DYN_ASSIGNMENT';  
  
/* SPs -------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/