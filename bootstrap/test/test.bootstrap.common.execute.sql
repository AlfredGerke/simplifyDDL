/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-08                                                       
/* Description: Execute für Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-08
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Execute: Test durchführen ---------------------------------------------------------------------*/        

/* SP_GET_CURRENT_USER testen --------------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_GET_CURRENT_USER;
/* SF_GET_CURRENT_USER testen --------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK
RETURNS (
  CURRENT_USER_INFO DN_DB_OBJECT)
AS
begin
  CURRENT_USER_INFO = PKG_COMMON.SF_GET_CURRENT_USER();
  
  suspend;
end^
SET TERM ; ^
/* SP_SUSPEND_MESSAGE testen ---------------------------------------------------------------------*/

select *
from PKG_COMMON.SP_SUSPEND_MESSAGE ('Message');
/* DESCRIBE testen -------------------------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_DESCRIBE ('VW_HISTORY_UPDATE');

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/