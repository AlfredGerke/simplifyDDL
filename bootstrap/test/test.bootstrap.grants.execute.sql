/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-07                                                        
/* Description: Execute für Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-07
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Execute: Test durchführen ---------------------------------------------------------------------*/        

/* Tabellen über Describe anzeigen ---------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_1');

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_2');

COMMIT WORK;
/* Grants  über das Bootstrap anlegen --------------------------------------------*/

/* Alle Grants werden gemäß der Konventionen des sDDL.bootstrap vergeben */
execute 
procedure PKG_SDDL.SP_GRANT_ALL;

COMMIT WORK;
/* Tabellen über Describe anzeigen ---------------------------------------------------------------*/

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_1');

select * 
from PKG_COMMON.SP_DESCRIBE ('TEST_2');

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/