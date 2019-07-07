/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-07-07                                                        
/* Description: Setup für einzelnen Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-07-07
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Setup: Testfall einrichten --------------------------------------------------------------------*/   

execute
procedure PKG_SDDL.SP_CREATE_CATALOG('CATALOG1', 'DN_SQL_IDENT', 'Testkatalog');

COMMIT WORK;

execute 
procedure PKG_SDDL.SP_GRANT('VW_L_CATALOG1');
                                                                                  
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/