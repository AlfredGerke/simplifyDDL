/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Verteiler-Script für das sDDL.bootstrap    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird über das Connect-Script eingeleitet
/*  
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* ISQL-SET --------------------------------------------------------------------------------------*/
SET SQL DIALECT 3;

SET NAMES WIN1252;

SET AUTOddl on;

SET ECHO on;

SET HEADING on;

SET LIST on;

/* Connect ---------------------------------------------------------------------------------------*/
input '..\connect\connect.sysdba.sql';

/* Input -----------------------------------------------------------------------------------------*/
input '..\sddl\sddl.bootstrap.context.sql';

input '..\sddl\sddl.bootstrap.roles.standard.sql';

input '..\sddl\sddl.bootstrap.domains.create.sql';

input '..\sddl\sddl.bootstrap.common.package.header.sql';
input '..\sddl\sddl.bootstrap.common.package.body.sql';

input '..\sddl\sddl.bootstrap.setting.model.create.sql';
input '..\sddl\sddl.bootstrap.setting.model.data.sql';  
input '..\sddl\sddl.bootstrap.setting.package.header.sql';
input '..\sddl\sddl.bootstrap.setting.package.body.sql';

input '..\sddl\sddl.bootstrap.roles.custom.sql';

input '..\sddl\sddl.bootstrap.history.model.create.sql';
input '..\sddl\sddl.bootstrap.history.package.header.sql';
input '..\sddl\sddl.bootstrap.history.package.body.sql';

input '..\sddl\sddl.bootstrap.sql.model.create.sql';
input '..\sddl\sddl.bootstrap.sql.package.header.sql';
input '..\sddl\sddl.bootstrap.sql.package.body.sql';

input '..\sddl\sddl.bootstrap.package.header.sql';
input '..\sddl\sddl.bootstrap.package.body.sql';

input '..\sddl\sddl.bootstrap.styleguide.model.create.sql';
input '..\sddl\sddl.bootstrap.styleguide.model.data.sql';
input '..\sddl\sddl.bootstrap.styleguide.package.header.sql';
input '..\sddl\sddl.bootstrap.styleguide.package.body.sql';

input '..\sddl\sddl.bootstrap.complete.sql';

/*------------------------------------------------------------------------------------------------*/
/* Das wars... 
/*------------------------------------------------------------------------------------------------*/