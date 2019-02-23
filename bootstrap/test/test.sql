/*------------------------------------------------------------------------------------------------*/
/* Description: Batchscript zum Ausf�hrne von beliebigen Testscripten
/*   - Die aufgerufenen Scripte arbeite mit Befehlen der SQL-Erweiterung f�r FireBird 3.0.x             
/*   - Verbindungen zur Datenbank m�ssen geschlossen sein
/*------------------------------------------------------------------------------------------------*/
/* Last modified: $Date: 2018-11-12 09:35:07 +0100 (Mo, 12. Nov 2018) $
/* Revision:      $Revision: 374 $
/* Author:        $Author: Alfred $
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/* Setup f�r ISQL                                   
/*------------------------------------------------------------------------------------------------*/          

input 'test.isql.setup.sql';

/*------------------------------------------------------------------------------------------------*/
/* Setup f�r DB                                   
/*------------------------------------------------------------------------------------------------*/          
                                       
input '..\connect\connect.sysdba.sql';         
input 'test.db.setup.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Issues testen                                   
/*------------------------------------------------------------------------------------------------*/          
         
/* Begin Test: Beispiel f�r den Aufbau eines Testfalles */
input '..\connect\connect.sysdba.sql';
input 'test.example.1.setup.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.execute.sql';

input '..\connect\connect.sysdba.sql';
input 'test.example.1.teardown.sql';
/* End Test: Beispiel f�r den Aufbau eines Testfalles */

/*------------------------------------------------------------------------------------------------*/
/* Teardown f�r DB                                   
/*------------------------------------------------------------------------------------------------*/          
         
/* Einstellungen f�r die Testf�lle */
input '..\connect\connect.sysdba.sql';         
input 'test.db.teardown.sql';         

/*------------------------------------------------------------------------------------------------*/
/* Das wars... -----------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/