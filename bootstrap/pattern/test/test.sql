/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Verteilerscript f�r den Aufruf der Test-Scripte    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Setup f�r ISQL --------------------------------------------------------------------------------*/
/* ISQL einrichten */                                   
input 'test.isql.setup.sql';

/* Setup f�r DB ----------------------------------------------------------------------------------*/
/* Datenbank vorbereiten */                                                                         
input '..\connect\connect.sysdba.sql';         
input 'test.db.setup.sql';         

/* Issues testen ---------------------------------------------------------------------------------*/                                   
         
/* Begin Test: Beispiel f�r den Aufbau eines Testfalles */
input '..\connect\connect.sysdba.sql';
input 'test.example.1.setup.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.execute.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.teardown.sql';
/* End Test: Beispiel f�r den Aufbau eines Testfalles */

/* Teardown f�r DB -------------------------------------------------------------------------------*/                                   
         
/* Teardown bezgl. der Datenbank f�r die Testf�lle */
input '..\connect\connect.sysdba.sql';         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/