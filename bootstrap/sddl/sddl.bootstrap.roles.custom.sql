/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es werden Standard-Benutzer und -Rollen für das sDDL.bootstrap angelegt    
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
EXECUTE BLOCK
RETURNS (
  INFO DN_STRING,
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare custom_prefix DN_STRING;
declare user_name DN_FIREBIRD_USER;
declare project_role_all DN_DB_OBJECT;
declare project_role_public DN_DB_OBJECT;
declare project_role_delete DN_DB_OBJECT;
declare sql_stmt DN_SQL_STMT;
begin
  INFO = 'Custom-Einträge in der Settings prüfen';
  SQL_STATE = '00000';
  SUCCESS = False;

  /*----------------------------------------------------------------------------------------------*/
  select RESULT_VALUE
  from PKG_SETTINGS.SP_READ_STRING ('CUSTOM',
    'SDDL',
    'CUSTOM.PREFIX',
    '')
  into :custom_prefix;
  
  if (Trim(custom_prefix) = '') then
    Exit;
  
  /*----------------------------------------------------------------------------------------------*/
  select RESULT_VALUE
  from PKG_SETTINGS.SP_READ_STRING ('CUSTOM',
    'SDDL',
    'USER.NAME',
    '')
  into :user_name;
  
  if (Trim(user_name) = '') then
    Exit;
    
  /*----------------------------------------------------------------------------------------------*/    
  select RESULT_VALUE
  from PKG_SETTINGS.SP_READ_STRING ('CUSTOM',
    'SDDL',
    'ROLE.DELETE',
    '')
  into :project_role_delete;
  
  if (Trim(project_role_delete) = '') then
    Exit;
  
  /*----------------------------------------------------------------------------------------------*/  
  select RESULT_VALUE
  from PKG_SETTINGS.SP_READ_STRING ('CUSTOM',
    'SDDL',
    'ROLE.PUBLIC',
    '')
  into :project_role_public;
    
  if (Trim(project_role_public) = '') then
    Exit;
    
  /*----------------------------------------------------------------------------------------------*/    
  select RESULT_VALUE
  from PKG_SETTINGS.SP_READ_STRING ('CUSTOM',
    'SDDL',
    'ROLE.ALL',
    '')
  into :project_role_all;    
    
  if (Trim(project_role_all) = '') then
    Exit;

  /*----------------------------------------------------------------------------------------------*/
  INFO = 'Custom-User löschen';
  
  if (exists(select 1
             from SEC$USERS
             where SEC$USER_NAME = :user_name)) 
  then
    execute statement 'DROP USER ' || :user_name;
    
  
  /*----------------------------------------------------------------------------------------------*/
  INFO = 'Custom-Roles löschen';
      
  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = :project_role_delete)) 
  then
    execute statement 'DROP ROLE ' || :project_role_delete;    
  
  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = :project_role_public)) 
  then
    execute statement 'DROP ROLE ' || :project_role_public;    

  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = :project_role_public)) 
  then
    execute statement 'DROP ROLE ' || :project_role_all;
   
  /*----------------------------------------------------------------------------------------------*/
  INFO = 'Custom-User anlegen';     
   
  sql_stmt = 'CREATE USER ' || :user_name  || ' PASSWORD ''change_on_install'' FIRSTNAME ''' || :custom_prefix || 
    ''' MIDDLENAME '' Bootstrap '' LASTNAME ''User''';
  execute statement sql_stmt;
  
  INFO = 'Custom-Roles anlegen';
  
  sql_stmt = 'CREATE ROLE ' || :project_role_delete;
  execute statement sql_stmt;

  sql_stmt = 'COMMENT ON ROLE ' || :project_role_delete || ' IS ''Sammelt alle Delete-Rechte''';
  execute statement sql_stmt;
  
  sql_stmt = 'CREATE ROLE ' || :project_role_public;
  execute statement sql_stmt;

  sql_stmt = 'COMMENT ON ROLE ' || :project_role_public || 
    ' IS ''Sammelt alle Select-, Update-, Insert- und Exectue-Rechte''';
  execute statement sql_stmt;
  
  sql_stmt = 'CREATE ROLE ' || :project_role_all;
  execute statement sql_stmt;

  sql_stmt = 'COMMENT ON ROLE ' || :project_role_all || 
    ' IS ''Sammelt alle Select-, Update-, Insert-, Delete- und Exectue-Rechte''';
  execute statement sql_stmt;
  
  INFO = 'Custom-User und -Roles angelegt';
  SUCCESS = True;
  
  suspend;
  
  when any do
  begin
    SUCCESS = False;
    SQL_STATE = SQLSTATE;
    
    suspend;
  end
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/