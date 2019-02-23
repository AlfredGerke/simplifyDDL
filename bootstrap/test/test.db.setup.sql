/* Description: Einstellungen für alle Tests einrichten  
/*   - Die aufgerufenen Scripte arbeitet mit Befehlen der SQL-Erweiterung für FireBird 3.0.x             
/*   - Verbindungen zur Datenbank müssen geschlossen sein
/*------------------------------------------------------------------------------------------------*/
/* Last modified: $Date: 2018-11-12 09:35:07 +0100 (Mo, 12. Nov 2018) $
/* Revision:      $Revision: 374 $
/* Author:        $Author: Alfred $
/*------------------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------------------*/
/* DDL: Datenbankobjekte die nur für den Test benötigt werden                                   
/*------------------------------------------------------------------------------------------------*/

SHEll DEL {Dateiname der Testdatenbank, vollständig MIT Pfadangabe};

/* Alias in der database.conf hinterlegen */
CREATE DATABASE '127.0.0.1/32303:{ALIAS oder Dateiname, vollständig MIT Pfadangabe}'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384;
/*DEFAULT CHARACTER SET WIN1252 COLLATION WIN1252;*/

/*------------------------------------------------------------------------------------------------*/
/* Data: Daten die nur für den Test benötigt werden                                   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/* Settings: Einstellung von Context-Variablen die nur für den Test benötigt werden                                   
/*------------------------------------------------------------------------------------------------*/

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/