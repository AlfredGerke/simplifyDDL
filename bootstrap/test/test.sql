/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Verteilerscript für den Aufruf der Test-Scripte    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Setup für ISQL --------------------------------------------------------------------------------*/
/* ISQL einrichten */                                   
input 'test.isql.setup.sql';

/* Setup für DB ----------------------------------------------------------------------------------*/
                                                                         
/* Connect: Datenbank vorberieten darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';
/* Setup: Datenbank vorbereiten */         
input 'test.db.setup.sql';         

/* Issues testen ---------------------------------------------------------------------------------*/                                           

/* Begin Test: Tabellen vervollständigen */
/* Connect: Tabellen vervollständingen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.example.complete.setup.sql';
input 'test.example.complete.execute.sql';
input 'test.example.complete.teardown.sql';
/* End Test: Tabellen vervollständigen */

/* Begin Test: Constraints anlegen */
/* Connect: Constraints der Tabellen anlegen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.example.constraints.setup.sql';
input 'test.example.constraints.execute.sql';
input 'test.example.constraints.teardown.sql';
/* End Test: Constraints anlegen */

/* Begin Test: Grants verteilen */

/* Connect: Grants verteilen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.example.grants.setup.sql';
input 'test.example.grants.execute.sql';
input 'test.example.grants.teardown.sql';
/* End Test: Grants verteilen */

/* Teardown für DB -------------------------------------------------------------------------------*/                                   
         
/* Connect: Datenbank zurücksetzen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';
/* Teardown: Teardown bezgl. der Datenbank für die Testfälle */         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/