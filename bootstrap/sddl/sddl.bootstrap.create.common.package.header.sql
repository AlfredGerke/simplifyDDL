/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Common-Procedures and -Functions werden angelegt
/*   - Package-Header        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-26
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/* Create                                   
/*------------------------------------------------------------------------------------------------*/

                                                
/* SPs */
SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG_COMMON
AS
begin
  PROCEDURE SP_GET_CURRENT_USER
  RETURNS (
    WRAPPED_USER_NAME DN_DB_OBJECT);
    
  FUNCTION SF_GET_CURRENT_USER(
    )
  RETURNS DN_DB_OBJECT;      
  
  PROCEDURE SP_SUSPEND_MESSAGE(
    AInfo DN_MESSAGE)
  RETURNS (
    INFO DN_MESSAGE);
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/