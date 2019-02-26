/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Test-Datenbank vorbereiten    
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

/* DDL: Datenbankobjekte die nur f�r den Test ben�tigt werden ------------------------------------*/                                   

SHEll DEL {Dateiname der Testdatenbank, vollst�ndig MIT Pfadangabe};

/* Alias in der database.conf hinterlegen */
CREATE DATABASE '127.0.0.1/32303:{ALIAS oder Dateiname, vollst�ndig MIT Pfadangabe}'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384;
/*DEFAULT CHARACTER SET WIN1252 COLLATION WIN1252;*/

/* Data: Daten die nur f�r den Test ben�tigt werden ----------------------------------------------*/                                   

/* Settings: Einstellung von Context-Variablen die nur f�r den Test ben�tigt werden --------------*/                                   

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/