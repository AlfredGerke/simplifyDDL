/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Connect-Script f�r den SYSDBA    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
/* - Ein Datenbank-Connect darf nicht vorhanden sein
/* - IP, Port, Alias und Password nach Bedarf anpassen
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
/* CONNECT '{IP}/{Port}:{Alias oder Datenbankname mit Pfad}' 
/* USER 'SYSDBA' PASSWORD 'Pass';          
/* IP, Port, Alias, User und Passwort hier nur ein Beispiel */              
CONNECT '127.0.0.1/32303:SIMPLIFYDDL' 
USER 'SYSDBA' PASSWORD 'masterkey';

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/