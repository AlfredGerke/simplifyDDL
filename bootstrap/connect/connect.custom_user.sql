/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-08                                                    
/* Description: Connect-Script für den CUSTOM_USER    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect darf nicht vorhanden sein
/* - IP, Port, Alias und Password nach Bedarf anpassen
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-08
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/          

-- GLOIN         
CONNECT '127.0.0.1/32304:SIMPLIFYDDL'
USER 'CUSTOM_USER' 
PASSWORD 'change_on_install'
ROLE 'CUSTOM_ALL';
-- NB
-- CONNECT '127.0.0.1/64304:sDDLbootstrap' 
-- USER 'CUSTOM_USER' 
-- PASSWORD 'change_on_install'
-- ROLE 'CUSTOM_ALL';

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/