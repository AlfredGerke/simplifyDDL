/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-10                                                        
/* Purpose: Das Script ruft alle notwendingen Scripte auf    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden              
/* - Der Connect der Datenbank sowie die Zuweisung von Context-Inhalten wird nur in diesem Script 
/*   vorgenommen   
/*
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-10
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
CONNECT '127.0.0.1:SIMPLIFYDDL' USER 'SYSDBA' PASSWORD 'masterkey';

/* Input -----------------------------------------------------------------------------------------*/
input 'create_sequences.sql';
input 'create_domains.sql';
input 'create_static_dict.sql';
input 'create_dynamic_dict.sql';

/*------------------------------------------------------------------------------------------------*/
/* Das wars... 
/*------------------------------------------------------------------------------------------------*/