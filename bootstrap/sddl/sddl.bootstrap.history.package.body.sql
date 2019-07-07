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
  /*----------------------------------------------------------------------------------------------*/
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
    
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_LOG_INFO (
    ADescription DN_DESCRIPTION,
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
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_SET_WARN_LEVEL (
    AWarnLevel DN_WARN_LEVEL)
  AS
  begin
    if (AWarnLevel is null) then
      AWarnLevel = 0;
      
    execute 
    procedure PKG_SETTINGS.SP_WRITE_BOOLEAN 'HISTORY', 
      'LOG', 
      'WARN_LEVEL', 
      AWarnLevel;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  FUNCTION SF_GET_WARN_LEVEL(
    )
  RETURNS DN_WARN_LEVEL
  AS
  declare warn_level_as_int integer;
  begin
    warn_level_as_int = 0;
    select RESULT_VALUE 
    from PKG_SETTINGS.SP_READ_INTEGER ('HISTORY', 'LOG', 'WARN_LEVEL', 0)
    into :warn_level_as_int;
    
    if ((warn_level_as_int > 0) and (warn_level_as_int < 4)) then
      RETURN cast(warn_level_as_int as DN_WARN_LEVEL);
    else
      RETURN 0;
   
   when any do
   begin
     execute 
     procedure SP_SET_LOG_INFO SQLSTATE,
       1;
       
     RETURN 0;   
   end         
  end  
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_LOG_INFORMATION (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin      
    warn_level = SF_GET_WARN_LEVEL(); 
  
    if (warn_level > 2) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 3;      
  end
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_LOG_WARNING (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin    
    warn_level = SF_GET_WARN_LEVEL(); 
  
    if (warn_level > 1) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 2;        
  end
  
  /*----------------------------------------------------------------------------------------------*/
  procedure SP_SET_LOG_ERROR (
    ADescription DN_DESCRIPTION)
  AS
  declare warn_level DN_WARN_LEVEL;
  begin    
    warn_level = SF_GET_WARN_LEVEL(); 
  
    if (warn_level > 0) then
      execute
      procedure SP_SET_LOG_INFO :ADescription, 1;          
  end   
          
  /*----------------------------------------------------------------------------------------------*/          
  PROCEDURE SP_SET_DEBUG_STATE(
    AState DN_BOOLEAN)
  AS
  begin
    if (AState is null) then
      AState = False;
      
    execute 
    procedure PKG_SETTINGS.SP_WRITE_BOOLEAN 'HISTORY', 
      'DEBUG', 
      'ACTIVE', 
      AState;
  end          
          
  /*----------------------------------------------------------------------------------------------*/    
  FUNCTION SF_GET_DEBUG_STATE(
    )
  RETURNS DN_BOOLEAN
  AS
   declare debug_state DN_BOOLEAN;  
  begin
     debug_state = False;
     select RESULT_VALUE
     from PKG_SETTINGS.SP_READ_BOOLEAN ('HISTORY', 'DEBUG', 'ACTIVE', False)
     into :debug_state;      
     
     RETURN debug_state;
     
     when any do
     begin
       execute 
       procedure SP_SET_LOG_INFO SQLSTATE,
         1;
       
       RETURN False;   
     end        
  end        
          
  /*----------------------------------------------------------------------------------------------*/  
  procedure SP_SET_DEBUG (
    ACaption DN_CAPTION,
    ADescription DN_DESCRIPTION)
  AS
  declare debug_flag DN_BOOLEAN;
  begin
    debug_flag = SF_GET_DEBUG_STATE();
    
    if (debug_flag = True) then
      if (Trim(ACaption) <> '')  then
      begin  
        if ((Trim(ADescription) = '') or (ADescription is null)) then
          ADescription = 'keine Informationen';
        
        if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME='VW_HISTORY_DEBUG')) then
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
 
COMMENT ON FUNCTION PKG_HISTORY.SF_GET_WARN_LEVEL
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

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.context.sql',
    'Conetxt-Variablen eingetragen');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.roles.standard.sql',
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
    'sddl.bootstrap.setting.model.create.sql',
    'Model für die Settings installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.setting.model.data.sql',
    'Daten für die Settings eingetrage');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.setting.package.header.sql',
    'Package-Header für die Settings installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.setting.package.body.sql',
    'Package-Body für die Settings installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.roles.custom.sql',
    'Custom-Benutzer und -Rollen für das Bootstrap installiert');

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