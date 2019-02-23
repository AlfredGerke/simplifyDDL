/* Description: Einstellungen f�r alle Tests einrichten  
/*   - Die aufgerufenen Scripte arbeitet mit Befehlen der SQL-Erweiterung f�r FireBird 3.0.x             
/*   - Verbindungen zur Datenbank m�ssen geschlossen sein
/*------------------------------------------------------------------------------------------------*/
/* Last modified: $Date: 2018-11-12 09:35:07 +0100 (Mo, 12. Nov 2018) $
/* Revision:      $Revision: 374 $
/* Author:        $Author: Alfred $
/*------------------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------------------*/
/* DDL: Datenbankobjekte die nur f�r den Test ben�tigt werden                                   
/*------------------------------------------------------------------------------------------------*/

SHEll DEL {Dateiname der Testdatenbank, vollst�ndig MIT Pfadangabe};

/* Alias in der database.conf hinterlegen */
CREATE DATABASE '127.0.0.1/32303:{ALIAS oder Dateiname, vollst�ndig MIT Pfadangabe}'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384;
/*DEFAULT CHARACTER SET WIN1252 COLLATION WIN1252;*/

/*------------------------------------------------------------------------------------------------*/
/* Data: Daten die nur f�r den Test ben�tigt werden                                   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/* Settings: Einstellung von Context-Variablen die nur f�r den Test ben�tigt werden                                   
/*------------------------------------------------------------------------------------------------*/

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/