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
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/                                         