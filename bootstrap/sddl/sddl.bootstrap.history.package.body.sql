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
RECREATE PACKAGE BODY PKG_HISTORY
AS
begin
  PROCEDURE SP_SET_UPDATE_INFO (
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
  
  PROCEDURE SP_SET_LOG_INFO (ADescription DN_DESCRIPTION,
    AWarnLevel DN_WARN_LEVEL)
  AS
  begin
    if (Trim(ADescription) <> '') then
      if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME='VW_HISTORY_LOG')) then
        in autonomous transaction do
          insert
          into VW_HISTORY_LOG 
          ( 
            WARN_LEVEL,
            DESCRIPTION
          ) 
          values 
          ( 
            :AWarnLevel, 
            :ADescription
          );    
  end
  
  PROCEDURE SP_SET_WARN_LEVEL_TO_CONTEXT(AWarnLevel DN_WARN_LEVEL)
  AS
  begin
    RDB$SET_CONTEXT('LOG', 'WARN_LEVEL', cast(AWarnLevel as varchar(1)));  
  end
  
  FUNCTION SF_GET_WARN_LEVEL_BY_CONTEXT(
    )
  RETURNS DN_WARN_LEVEL
  AS
  declare warn_level_as_str varchar(10);
  declare warn_level_as_int integer;
  begin
    warn_level_as_str = RDB$GET_CONTEXT('LOG', 'WARN_LEVEL');
    warn_level_as_int = cast(warn_level_as_str as integer);
    
    if ((warn_level_as_int > 0) and (warn_level_as_int < 4)) then
      RETURN cast(warn_level_as_int as DN_WARN_LEVEL);
    else
      RETURN 0;
   
   when any do
   begin
     execute 
     procedure SP_SET_LOG_INFO SQLSTATE,
       0;
       
     RETURN 0;   
   end   
  end   
  
  PROCEDURE SP_SET_LOG_INFORMATION (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin    
    warn_level = SF_GET_WARN_LEVEL_BY_CONTEXT(); 
  
    if (warn_level > 2) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 3;      
  end
  
  
  PROCEDURE SP_SET_LOG_WARNING (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin    
    warn_level = SF_GET_WARN_LEVEL_BY_CONTEXT(); 
  
    if (warn_level > 1) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 2;        
  end
  
  procedure SP_SET_LOG_ERROR (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin    
    warn_level = SF_GET_WARN_LEVEL_BY_CONTEXT(); 
  
    if (warn_level > 0) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 1;          
  end   
    
  procedure SP_SET_DEBUG (
    ACaption DN_CAPTION,
    ADescription DN_DESCRIPTION)
  AS
  begin
    if (Trim(ACaption) <> '')  then
    begin  
      if ((Trim(ADescription) = '') or (ADescription is null)) then
        ADescription = 'keine Informationen';
      
      if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME='VW_HISTORY_DEUG')) then
        in autonomous transaction do
          insert
          into VW_HISTORY_DEBUG
          ( 
            CAPTION,
            DESCRIPTION
          ) 
          values 
          ( 
            :ACaption, 
            :ADescription
          );
    end    
  end 
end^  
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_UPDATE_INFO  
IS 'Vereinfacht den Eintrag in die Tabelle TB_HISTORY_UPDATE';

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_WARN_LEVEL_TO_CONTEXT
IS 'Setzt den WarnLevel für die Log-Routinen';
  
COMMENT ON FUNCTION PKG_HISTORY.SF_GET_WARN_LEVEL_BY_CONTEXT
IS 'Ermittelt den WarnLevel für die Log-Routinen';

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_LOG_INFORMATION  
IS 'Logeinträge mit dem WarnLevel 2 -> Information';    

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_LOG_WARNING  
IS 'Logeinträge mit dem WarnLevel 1 -> Warnung';    

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_LOG_ERROR  
IS 'Logeinträge mit dem WarnLevel 0 -> Error';    

COMMENT ON PROCEDURE PKG_HISTORY.SP_SET_DEBUG
IS 'Setzt Debug-Einträge';
    
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
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.roles.create.sql',
    'Standard-Benutzer und -Rollen für das Bootstrap installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.domains.create.sql',
    'Domains für das Bootstrap installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.common.package.header.sql',
    'Package-Header der Common -Procedures/-Function installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.common.package.body.sql',
    'Package-Body der Common -Procedures/-Function installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.history.model.create.sql',
    'Model der History installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.history.package.header.sql',
    'Package-Header der History installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.history.package.body.sql',
    'Package-Body der History installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/