/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-07                                                        
/* Description: Execute f�r Testfall     
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-07
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Execute: Test durchf�hren ---------------------------------------------------------------------*/        

/* Tabellen �ber Describe anzeigen ---------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_1');

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_2');

COMMIT WORK;
/* Constraints der Tabelle �ber das Bootstrap anlegen --------------------------------------------*/

/* Die Kommentare aller Relationen der DB werden auf sDDL-Befehle durchsucht und entsprechend umgesetzt */
select SUCCESS, LOG_MESSAGE
from PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS;

COMMIT WORK;
/* Tabellen �ber Describe anzeigen ---------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_1');

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_2');

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/