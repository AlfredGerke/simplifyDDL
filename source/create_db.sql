/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-10                                                        
/* Purpose: Erstellt eine Datenbank um sDDL entwickeln zu können    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*              
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-10
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* Vorhandene Datenbank löschen: Pfad anpassen! */
SHEll DEL C:\Users\Alfred\Sourcen\db\firebird\simplifyDDL\SIMPLIFYDDL.FDB;

/* Entwicklungsdatenbank erstellen: Alias SIMPLIFYDDL anlegen! */
CREATE DATABASE '127.0.0.1:SIMPLIFYDDL' USER 'SYSDBA' PASSWORD 'masterkey' PAGE_SIZE 4096 DEFAULT CHARACTER SET UTF8 COLLATION UTF8;

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/