/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-05                                                    
/* Description: Daten für das StyleGuide-Model    
/*                                                                               
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-05
/*          Script erstellen
/*          ---
/*          Der Custom-User für das Bootstrap kann hier frei gewählt werden
/*   
/*------------------------------------------------------------------------------------------------*/

/* WarnLevel festlegen ---------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare variable warn_level DN_WARN_LEVEL;
begin
  SQL_STATE = '00000';
  SUCCESS = False;

  warn_level = 3;
  
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'HISTORY',
    'LOG',
    'WARN_LEVEL',
    cast(:warn_level as varchar(1))
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);
  
  SUCCESS = True;
  
  suspend;
  
  when any do
  begin
    SQL_STATE = SQLSTATE;
    SUCCESS = False;
  
    suspend;
  end
END^        
SET TERM ; ^

COMMIT WORK;
/* Debug-Status festlegen ------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare variable state_as_bool DN_BOOLEAN;
begin
  SQL_STATE = '00000';
  SUCCESS = False;

  state_as_bool = True;     
             
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'HISTORY',
    'DEBUG',
    'ACTIVE',
    cast(:state_as_bool as varchar(5))
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);
  
  SUCCESS = True;
  
  suspend;
  
  when any do
  begin
    SQL_STATE = SQLSTATE;
    SUCCESS = False;
  
    suspend;
  end
END^        
SET TERM ; ^

COMMIT WORK;
/* Custom-User/-Roles für das Bootstrap definieren -----------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare custom_prefix DN_STRING;
declare user_name DN_FIREBIRD_USER;
declare project_role_all DN_DB_OBJECT;
declare project_role_public DN_DB_OBJECT;
declare project_role_delete DN_DB_OBJECT;
begin
  SQL_STATE = '00000';
  SUCCESS = False;
  
  -- Custom-Prefix kann beliebig gewählt werden
  -- Custom-Prefix wird zum Prefix vom SDDL-User und SDDL-Rollen
  -- Custom-Prefix wird zum Firstname in den SDDL-User Informationen
  -- Custom-Prefix plus User- bzw. Rollen-Suffix dürfen nicht länger als 31 Zeichen sein
  custom_prefix = 'Custom'; 

  -- User-Prefix sollte Custom-Prefix sein, User-Suffix sollte nicht geändert werden
  user_name = Trim(custom_prefix) || '_' || 'USER';

  -- Rollen-Prefix sollte Custom-Prefix sein, Rollen-Suffix sollte nicht geändert werden
  -- :!<--     
  project_role_all = Trim(custom_prefix) || '_' || 'ALL';
  project_role_public = Trim(custom_prefix) || '_' || 'PUBLIC';
  project_role_delete = Trim(custom_prefix) || '_' || 'DELETE';
  -- -->
                   
  /*----------------------------------------------------------------------------------------------*/             
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'CUSTOM.PREFIX',
    :custom_prefix
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);             
             
  /*----------------------------------------------------------------------------------------------*/             
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'USER.NAME',
    Upper(:user_name)
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);

  /*----------------------------------------------------------------------------------------------*/  
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'ROLE.ALL',
    Upper(:project_role_all)
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);    

  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'ROLE.PUBLIC',
    Upper(:project_role_public)
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);
  
  /*----------------------------------------------------------------------------------------------*/  
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'ROLE.DELETE',
    Upper(:project_role_delete)
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);  
  
  SUCCESS = True;
  
  suspend;
  
  when any do
  begin
    SQL_STATE = SQLSTATE;
    SUCCESS = False;
  
    suspend;
  end  
END^        
SET TERM ; ^
/* Festlegen ob Sequencen beim Recursive-Drop gelöscht werden sollen -----------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare do_drop DN_BOOLEAN;
begin
  SQL_STATE = '00000';
  SUCCESS = False;

  do_drop = True;
             
  update or insert
  into VW_SETTING
  (
    CATEGORY_NAME, 
    SECTION_NAME, 
    IDENT, 
    STRING_VALUE
  )
  values
  (
    'CUSTOM',
    'SDDL',
    'DROP.RECURSIVE.SEQUENCE',
    :do_drop
  )
  matching (CATEGORY_NAME, SECTION_NAME, IDENT);
  
  SUCCESS = True;
  
  suspend;
  
  when any do
  begin
    SQL_STATE = SQLSTATE;
    SUCCESS = False;
  
    suspend;
  end                              
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/                                         