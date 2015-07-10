/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-10                                                        
/* Purpose: Das Script ruft alle notwendingen Scripte auf    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden              
/* - Der Connect der Datenbank sowie die Zuweisung von Context-Inhalten wird nur in diesem Script 
/*   vorgenommen   
/*
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-10
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

SET SQL DIALECT 3;

SET NAMES UTF8;

SET AUTOddl on;

SET ECHO on;

SET HEADING on;

SET LIST on;

CONNECT '127.0.0.1:SIMPLIFYDDL' USER 'SYSDBA' PASSWORD 'masterkey';

input 'create_static_dict.sql';

/*------------------------------------------------------------------------------------------------*/
/* Das wars... 
/*------------------------------------------------------------------------------------------------*/
