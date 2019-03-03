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
procedure PKG_SDDL.GRANT_ALL;

COMMIT WORK;
/* KeyWords --------------------------------------------------------------------------------------*/

select HIT, RESERVED, FOUND_IN
from PKG_STYLEGUIDE.SP_CHECK_RESERVED; 
    
COMMIT WORK;    
/* Styleguid -------------------------------------------------------------------------------------*/

select HIT, OBJECT_NAME, FOUND_IN, STYLE_GUIDE_KEYW, TO_DO
from SP_STYLEGUID.PKG_STYLEGUIDE;    

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/