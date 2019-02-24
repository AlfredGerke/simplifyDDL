/*------------------------------------------------------------------------------------------------*/
/* ### Description: 
/*   * Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/*   * Das Script ist für die Ausführung im ISQL erstellt worden              
/*   * Der Connect der Datenbank sowie die Zuweisung von Context-Inhalten wird nur in diesem Script 
/*     vorgenommen   
/*   
/* Initial Developer: AGE
/*
/*------------------------------------------------------------------------------------------------*/
/*
/* Last modified: $Date:$
/* Revision:      $Revision:$
/* Author:        $Author:$
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
input '..\sddl\sddl.bootstrap.create.domains.sql';

input '..\sddl\sddl.bootstrap.create.history.udate.model.sql';
input '..\sddl\sddl.bootstrap.create.history.udate.package.header.sql';
input '..\sddl\sddl.bootstrap.create.history.udate.package.body.sql';

input '..\sddl\sddl.bootstrap.create.setting.model.sql';
input '..\sddl\sddl.bootstrap.create.setting.package.header.sql';
input '..\sddl\sddl.bootstrap.create.setting.package.body.sql';

/*
input '..\sddl\sddl.bootstrap.create.package.header.sql';
input '..\sddl\sddl.bootstrap.create.package.body.sql';
*/

/*------------------------------------------------------------------------------------------------*/
/* Das wars... 
/*------------------------------------------------------------------------------------------------*/