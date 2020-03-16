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
                                                                         
/* Connect: Datenbank vorberieten darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';
/* Setup: Datenbank vorbereiten */         
input 'test.db.setup.sql';         

/* Issues testen ---------------------------------------------------------------------------------*/                                           

/* Begin Test: Common-Package testen */
/* Connect: sollte auch unter eingeschr�nkten Nutzern funktionieren */
input '..\connect\connect.custom_user.sql';

input 'test.bootstrap.common.setup.sql';
input 'test.bootstrap.common.execute.sql';
input 'test.bootstrap.common.teardown.sql';
/* End Test: Common-Package testen */

/* Begin Test: SQL-Package testen */
/* Connect: sollte auch unter eingeschr�nkten Nutzern funktionieren */
input '..\connect\connect.custom_user.sql';

input 'test.bootstrap.sql.setup.sql';
input 'test.bootstrap.sql.execute.sql';
input 'test.bootstrap.sql.teardown.sql';
/* End Test: SQL-Package testen */

/* Begin Test: Tabellen vervollst�ndigen */
/* Connect: Tabellen vervollst�ndingen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';

input 'test.bootstrap.complete.setup.sql';
input 'test.bootstrap.complete.execute.sql';
input 'test.bootstrap.complete.teardown.sql';
/* End Test: Tabellen vervollst�ndigen */

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


/* Teardown f�r DB -------------------------------------------------------------------------------*/                                   
         
/* Connect: Datenbank zur�cksetzen darf nur der SYSDBA */
input '..\connect\connect.sysdba.sql';
/* Teardown: Teardown bezgl. der Datenbank f�r die Testf�lle */         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/