/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Erstellt eine Datenbank um sDDL.bootstrap entwickeln zu können    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - DB-Name, IP, Port, Alias, Password, PageSize und Character-Set nach Bedarf anpassen
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Vorhandene Datenbank löschen: Pfad prüfen und eventl. anpassen!
/* GLOIN
SHEll DEL C:\Users\Alfred\Sourcen\db\firebird\simplifyDDL\SIMPLIFYDDL.FDB;
*/

SHEll DEL C:\firebird\db\SDDL_BOOTSTRAP.FDB;


/* Entwicklungsdatenbank erstellen: Alias SIMPLIFYDDL anlegen! */

/* GLOIN
CREATE DATABASE '127.0.0.1/32304:SIMPLIFYDDL'
*/
CREATE DATABASE '127.0.0.1/64304:sDDLbootstrap' 
USER 'SYSDBA' 
PASSWORD 'masterkey' 
PAGE_SIZE 4096 
SET NAMES 'WIN1252'
DEFAULT CHARACTER SET WIN1252 
COLLATION WIN1252;

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/