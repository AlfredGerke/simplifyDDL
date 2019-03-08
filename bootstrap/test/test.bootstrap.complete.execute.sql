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

/* Tabelle über das Bootstrap erweitern ----------------------------------------------------------*/

execute
procedure PKG_SDDL.SP_COMPLETE_TABLE 'TEST_1',
    True,
    True,
    True,
    'Testtabelle No. 1', 
    True;
    
execute
procedure PKG_SDDL.SP_COMPLETE_TABLE 'TEST_2',
    True,
    True,
    True,
    'Testtabelle No. 2', 
    True;                                                        

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/