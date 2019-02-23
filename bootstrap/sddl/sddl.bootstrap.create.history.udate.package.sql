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

SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG$HISTORY_UPDATE
AS
begin
  PROCEDURE SP_HISTORY_UPDATE (
    AMajorNumber DN_MAJOR_NO,
    AMinorNumber DN_MINOR_NO,
    AScript DN_FILENAME,
    ADescription DN_DESCRIPTION);
end^
/*------------------------------------------------------------------------------------------------*/

RECREATE PACKAGE BODY PKG$HISTORY_UPDATE
AS
begin
  PROCEDURE SP_HISTORY_UPDATE (
    AMajorNumber DN_MAJOR_NO,
    AMinorNumber DN_MINOR_NO,
    AScript DN_FILENAME,
    ADescription DN_DESCRIPTION)
  AS
  begin
    if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME='VW_HISTORY_UPDATE')) then
      in autonomous transaction do
        insert
        into VW_HISTORY_UPDATE 
        ( 
          MAJOR,
          MINOR,
          SCRIPT,
          DESCRIPTION
        ) 
        values 
        ( 
          :AMajorNumber, 
          :AMinorNumber, 
          :AScript, 
          :ADescription
        );
  end
  
end^  
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG$HISTORY_UPDATE.SP_HISTORY_UPDATE  
IS 'Vereinfacht den Eintrag in die Tabelle TB_HISTORY_UPDATE';    
/*------------------------------------------------------------------------------------------------*/

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/