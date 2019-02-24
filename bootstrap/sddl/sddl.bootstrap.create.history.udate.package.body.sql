/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es wird der Package-Body für die Update-History angelegt    
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

/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
RECREATE PACKAGE BODY PKG$HISTORY_UPDATE
AS
begin
  PROCEDURE SP_SET_INFO (
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

COMMENT ON PROCEDURE PKG$HISTORY_UPDATE.SP_SET_INFO  
IS 'Vereinfacht den Eintrag in die Tabelle TB_HISTORY_UPDATE';    
/*------------------------------------------------------------------------------------------------*/

COMMIT WORK;

/*------------------------------------------------------------------------------------------------*/
/* Updatehistory                                   
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG$HISTORY_UPDATE.SP_SET_INFO (0,
    0,
    'sddl.bootstrap.create.history.update.model.sql',
    'Model der Update-History installiert');

  execute
  procedure
  PKG$HISTORY_UPDATE.SP_SET_INFO (0,
    0,
    'sddl.bootstrap.create.history.update.package.header.sql',
    'Package-Header der Update-History installiert');

  execute
  procedure
  PKG$HISTORY_UPDATE.SP_SET_INFO (0,
    0,
    'sddl.bootstrap.create.history.update.package.body.sql',
    'Package-body der Update-History installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/