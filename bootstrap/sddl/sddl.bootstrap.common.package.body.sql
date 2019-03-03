/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Common-Procedures and -Functions werden angelegt
/*   - Package-Body        
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

/* SPs */
SET TERM ^ ;
RECREATE PACKAGE BODY PKG_COMMON
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GET_CURRENT_USER
  RETURNS (
    WRAPPED_USER_NAME DN_DB_OBJECT)
  AS
  begin
    WRAPPED_USER_NAME = current_user;
    
    Suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_GET_CURRENT_USER(
    )
  RETURNS DN_DB_OBJECT
  AS
  declare wrapped_user_name DN_DB_OBJECT;
  begin
    select WRAPPED_USER_NAME
    from PKG_COMMON.SP_GET_CURRENT_USER
    into :wrapped_user_name;
    
    RETURN wrapped_user_name;
  end
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_SUSPEND_MESSAGE(
    AInfo DN_MESSAGE)
  RETURNS (
    INFO DN_MESSAGE)
  AS
  begin
    INFO = Trim(AInfo);
    
    Suspend;
  end 
end^
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG_COMMON.SP_GET_CURRENT_USER
IS 'Wrapper SP für den CURRENT_USER';

COMMENT ON PROCEDURE PKG_COMMON.SP_SUSPEND_MESSAGE
IS 'Einfach Routine um einen String auszugeben';

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/