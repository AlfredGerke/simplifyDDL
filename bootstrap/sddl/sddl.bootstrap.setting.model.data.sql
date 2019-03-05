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

/*------------------------------------------------------------------------------------------------*/

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
/*------------------------------------------------------------------------------------------------*/

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
/* Custom-User definieren für das Bootstrap ------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  SQL_STATE DN_SQLSTATE,
  SUCCESS DN_BOOLEAN)
AS
declare project_name DN_STRING;
declare user_name DN_FIREBIRD_USER;
declare project_role_all DN_DB_OBJECT;
declare project_role_public DN_DB_OBJECT;
declare project_role_delete DN_DB_OBJECT;
begin
  project_name = 'Custom';
  user_name = Trim(project_name) || '_' || 'USER';  
  project_role_all = Trim(project_name) || '_' || 'ALL';
  project_role_public = Trim(project_name) || '_' || 'PUBLIC';
  project_role_delete = Trim(project_name) || '_' || 'DELETE';
             
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
    'PROJECT.NAME',
    :project_name
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
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/                                         