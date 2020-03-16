/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2016-02-07                                                        
/* Purpose: Das Script ruft alle notwendingen Scripte auf    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden              
/* - Der Connect der Datenbank sowie die Zuweisung von Context-Inhalten wird nur in diesem Script 
/*   vorgenommen   
/* - sDDL muss vorhanden sein
/*
/*------------------------------------------------------------------------------------------------*/
/* History: 2016-02-07
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* ISQL-SET -------------------------------------------------------------------------------------------*/
SET SQL DIALECT 3;

SET NAMES UTF8;

SET AUTOddl on;

SET ECHO on;

SET HEADING on;

SET LIST on;

/* Connect ---------------------------------------------------------------------------------------*/
CONNECT '127.0.0.1/32303:SIMPLIFYDDL' USER 'SYSDBA' PASSWORD 'masterkey';

/* Input -----------------------------------------------------------------------------------------*/
input 'insert_settings.sql';
input 'insert_valid_sddl_keywords.sql';

/*------------------------------------------------------------------------------------------------*/
/* Das wars... 
/*------------------------------------------------------------------------------------------------*/