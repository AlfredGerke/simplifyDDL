/*------------------------------------------------------------------------------------------------*/
/* ### Description: 
/*   * Es werden alle DB-Objecte für die Tabelle TB_HISTORY_UPDATE angelegt   
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

/*------------------------------------------------------------------------------------------------*/
CREATE SEQUENCE SEQ_HISTORY_UPDATE_ID;
ALTER SEQUENCE SEQ_HISTORY_UPDATE_ID RESTART WITH 0;      

/*------------------------------------------------------------------------------------------------*/
CREATE TABLE TB_HISTORY_UPDATE(
  ID DN_IDENTIFICATION, 
  MAJOR DN_MAJOR_NO,
  MINOR DN_MINOR_NO,
  SCRIPT DN_FILENAME_SHORT NOT NULL,
  DESCRIPTION DN_DESCRIPTION,
  CRE_USER DN_CURRENT_USER,
  CRE_DATE DN_CURRENT_TIMESTAMP,
  CHG_USER DN_FIREBIRD_USER,
  CHG_DATE DN_TIMESTAMP
);

COMMENT ON TABLE TB_HISTORY_UPDATE
IS 'Updatehistorie';

COMMENT ON COLUMN TB_HISTORY_UPDATE.ID 
IS 'Primärschlüssel';

COMMENT ON COLUMN TB_HISTORY_UPDATE.MAJOR 
IS 'Hauptversion des Updatescriptes';

COMMENT ON COLUMN TB_HISTORY_UPDATE.MINOR 
IS 'Unterversion des Updatescriptes';

COMMENT ON COLUMN TB_HISTORY_UPDATE.SCRIPT 
IS 'Name des Updatescriptes';

COMMENT ON COLUMN TB_HISTORY_UPDATE.DESCRIPTION 
IS 'Beschreibung zum Updatescript';

COMMENT ON COLUMN TB_HISTORY_UPDATE.CRE_USER 
IS 'Erstellt von';

COMMENT ON COLUMN TB_HISTORY_UPDATE.CRE_DATE 
IS 'Erstellt am';

COMMENT ON COLUMN TB_HISTORY_UPDATE.CHG_USER 
IS 'Bearbeitet von';

COMMENT ON COLUMN TB_HISTORY_UPDATE.CHG_DATE 
IS 'Bearbeitet am';

/*------------------------------------------------------------------------------------------------*/
CREATE VIEW VW_HISTORY_UPDATE(
  ID, 
  MAJOR,
  MINOR,
  SCRIPT,
  DESCRIPTION,
  CRE_USER,
  CRE_DATE,
  CHG_USER,
  CHG_DATE)
AS
select
  ID, 
  MAJOR,
  MINOR,
  SCRIPT,
  DESCRIPTION,
  CRE_USER,
  CRE_DATE,
  CHG_USER,
  CHG_DATE
from      
  TB_HISTORY_UPDATE;
  
COMMENT ON VIEW VW_HISTORY_UPDATE 
IS 'Standard Update-View für die Tabelle TP_HISTORY_UPDATE';
  
/*------------------------------------------------------------------------------------------------*/
SET TERM ^ ;
CREATE TRIGGER TRG_HISTORY_UPDATE_BI0 FOR TB_HISTORY_UPDATE ACTIVE
BEFORE INSERT POSITION 0
AS
begin
  if (new.id is null) then
    new.id = next value for SEQ_HISTORY_UPDATE_ID;    
end^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TRG_HISTORY_UPDATE_BU0 FOR TB_HISTORY_UPDATE ACTIVE
BEFORE UPDATE POSITION 0
AS
begin
  new.chg_user = current_user;
  new.chg_date = current_timestamp;
end^
SET TERM ; ^

/*------------------------------------------------------------------------------------------------*/
ALTER TABLE TB_HISTORY_UPDATE ADD PRIMARY KEY (ID);

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/