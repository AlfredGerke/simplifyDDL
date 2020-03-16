/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es wird der Package-Header für die Update-History angelegt    
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
CREATE OR ALTER PACKAGE PKG_HISTORY
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_UPDATE_INFO (
    AMajorNumber DN_MAJOR_NO,
    AMinorNumber DN_MINOR_NO,
    AScript DN_FILENAME,
    ADescription DN_DESCRIPTION);

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_WARN_LEVEL (
    AWarnLevel DN_WARN_LEVEL Default 0);
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_SET_LOG_INFORMATION (
    ADescription DN_DESCRIPTION);
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_LOG_WARNING (
    ADescription DN_DESCRIPTION);
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET_LOG_ERROR (
    ADescription DN_DESCRIPTION);    
        
  /*----------------------------------------------------------------------------------------------*/        
  PROCEDURE SP_SET_DEBUG_STATE(
    AState DN_BOOLEAN Default False);
        
  /*----------------------------------------------------------------------------------------------*/      
  PROCEDURE SP_SET_DEBUG (
    ACaption DN_CAPTION,
    ADescription DN_DESCRIPTION = 'keine Information');    
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/