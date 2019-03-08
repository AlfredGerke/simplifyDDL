/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-08                                                       
/* Description: Execute f�r Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-08
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Execute: Test durchf�hren ---------------------------------------------------------------------*/        

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