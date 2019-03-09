/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Execute für Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
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
/* Tabelle über das Bootstrap erweitern ----------------------------------------------------------*/

execute
procedure PKG_SDDL.SP_COMPLETE_TABLE 'TEST_1', /* Name der Tabelle, die erweitert werden soll */
    True, /* wenn True wird das Standardfeld Description angelegt */
    True, /* wenn True wird eine Datensatzstempl (CRE_USER, CRE_DATE, CHG_USER, CHG_DATE) angelegt */
    True, /* wenn True wird ein Kommentar für die Tabelle anleget */
    'Testtabelle No. 1', /* Kommentar für die Tabelle */ 
    True; /* wenn True wird ein Primär-Key-Constraint angelegt */
    
execute
procedure PKG_SDDL.SP_COMPLETE_TABLE 'TEST_2', /* Name der Tabelle, die erweitert werden soll */
    True, /* wenn True wird das Standardfeld Description angelegt */
    True, /* wenn True wird eine Datensatzstempl (CRE_USER, CRE_DATE, CHG_USER, CHG_DATE) angelegt */
    True, /* wenn True wird ein Kommentar für die Tabelle anleget */
    'Testtabelle No. 2', /* Kommentar für die Tabelle */ 
    True; /* wenn True wird ein Primär-Key-Constraint angelegt */

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