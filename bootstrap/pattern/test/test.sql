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
/* Datenbank vorbereiten */                                                                         
input '..\connect\connect.sysdba.sql';         
input 'test.db.setup.sql';         

/* Issues testen ---------------------------------------------------------------------------------*/                                   
         
/* Begin Test: Beispiel für den Aufbau eines Testfalles */
input '..\connect\connect.sysdba.sql';
input 'test.example.1.setup.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.execute.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.teardown.sql';
/* End Test: Beispiel für den Aufbau eines Testfalles */

/* Teardown für DB -------------------------------------------------------------------------------*/                                   
         
/* Teardown bezgl. der Datenbank für die Testfälle */
input '..\connect\connect.sysdba.sql';         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/