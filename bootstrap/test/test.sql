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

/* Begin Test: Common-Package testen */
/* Connect: sollte auch unter eingeschränkten Nutzern funktionieren */
input '..\connect\connect.custom_user.sql';

input 'test.bootstrap.common.setup.sql';
input 'test.bootstrap.common.execute.sql';
input 'test.bootstrap.common.teardown.sql';
/* End Test: Common-Package testen */

/* Begin Test: SQL-Package testen */
/* Connect: sollte auch unter eingeschränkten Nutzern funktionieren */
input '..\connect\connect.custom_user.sql';

input 'test.bootstrap.sql.setup.sql';
input 'test.bootstrap.sql.execute.sql';
input 'test.bootstrap.sql.teardown.sql';
/* End Test: SQL-Package testen */

/* Begin Test: Tabellen vervollständigen */
/* Connect: Tabellen vervollständingen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.bootstrap.complete.setup.sql';
input 'test.bootstrap.complete.execute.sql';
input 'test.bootstrap.complete.teardown.sql';
/* End Test: Tabellen vervollständigen */

/* Begin Test: Constraints anlegen */
/* Connect: Constraints der Tabellen anlegen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.bootstrap.constraints.setup.sql';
input 'test.bootstrap.constraints.execute.sql';
input 'test.bootstrap.constraints.teardown.sql';
/* End Test: Constraints anlegen */

/* Begin Test: Grants verteilen */

/* Connect: Grants verteilen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.bootstrap.grants.setup.sql';
input 'test.bootstrap.grants.execute.sql';
input 'test.bootstrap.grants.teardown.sql';
/* End Test: Grants verteilen */

/* Begin Test:Kataloge testen */
/* Connect: Kataloge anlegen darf ur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.bootstrap.catalog.setup.sql';
input 'test.bootstrap.catalog.execute.sql';
input 'test.bootstrap.catalog.teardown.sql';
/* End Test: SQL-Package testen */


/* Teardown für DB -------------------------------------------------------------------------------*/                                   
         
/* Connect: Datenbank zurücksetzen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';
/* Teardown: Teardown bezgl. der Datenbank für die Testfälle */         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/