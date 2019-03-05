/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-01                                                        
/* Description: Es werden Constraints und Grants angelegt        
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

/* Constraints -----------------------------------------------------------------------------------*/

select SUCCESS, LOG_MESSAGE
from PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS;

COMMIT WORK;
/* Grants ----------------------------------------------------------------------------------------*/

execute
procedure PKG_SDDL.SP_GRANT_ALL;

COMMIT WORK;
/* PREFIX --------------------------------------------------------------------------------------*/

select HIT, OBJECT_NAME, FOUND_IN, MISSING_PREFIX
from PKG_STYLEGUIDE.SP_CHECK_PREFIX; 
    
COMMIT WORK;    
/* KeyWords --------------------------------------------------------------------------------------*/

select HIT, RESERVED, FOUND_IN
from PKG_STYLEGUIDE.SP_CHECK_RESERVED; 
    
COMMIT WORK;    
/* Styleguid -------------------------------------------------------------------------------------*/

select HIT, OBJECT_NAME, FOUND_IN, STYLE_GUIDE_KEYW, TO_DO
from PKG_STYLEGUIDE.SP_CHECK;    

COMMIT WORK;
/* Debugs ----------------------------------------------------------------------------------------*/

select CAPTION, DESCRIPTION
from VW_HISTORY_DEBUG
order by
ID DESC;

COMMIT WORK;
/* Logs ------------------------------------------------------------------------------------------*/

select WARN_LEVEL, DESCRIPTION
from VW_HISTORY_LOG
order by
ID DESC;

COMMIT WORK;
/* Logs ------------------------------------------------------------------------------------------*/

select MAJOR, MINOR, SCRIPT, DESCRIPTION
from VW_HISTORY_UPDATE
order by
ID DESC;

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/