/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Test-Datenbank vorbereiten    
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

/* DDL: Datenbankobjekte die nur für den Test benötigt werden ------------------------------------*/                                   

SHEll DEL {Dateiname der Testdatenbank, vollständig MIT Pfadangabe};

/* Alias in der database.conf hinterlegen */
CREATE DATABASE '127.0.0.1/32303:{ALIAS oder Dateiname, vollständig MIT Pfadangabe}'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384;
/*DEFAULT CHARACTER SET WIN1252 COLLATION WIN1252;*/

/* Data: Daten die nur für den Test benötigt werden ----------------------------------------------*/                                   

/* Settings: Einstellung von Context-Variablen die nur für den Test benötigt werden --------------*/                                   

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/