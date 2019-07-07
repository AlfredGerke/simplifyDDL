/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-07-06                                                     
/* Description: Execute für einzelnen Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-07-06
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Setup: Test durchführen -----------------------------------------------------------------------*/   

select * 
from  PKG_SQL.SP_GET;

/* --- */

execute
procedure PKG_SQL.SP_SET('select *');
     
execute
procedure PKG_SQL.SP_SET('from hummeldummel');

execute
procedure PKG_SQL.SP_SET('where dummel is null');

/* --- */

select * 
from  PKG_SQL.SP_GET;

/* --- */

execute
procedure PKG_SQL.SP_CLEAR;

select * 
from  PKG_SQL.SP_GET;

/* --- */

execute
procedure PKG_SQL.SP_SET('select *');
     
execute
procedure PKG_SQL.SP_SET('from VW_HISTORY_UPDATE');

execute
procedure PKG_SQL.SP_SET('where MAJOR = 0');

/* --- */

select * 
from  PKG_SQL.SP_GET;

/* --- */

set term ^ ;
execute block
returns (
  ID DN_IDENTIFICATION, 
  MAJOR DN_MAJOR_NO,
  MINOR DN_MINOR_NO,
  SCRIPT DN_FILENAME_SHORT,
  DESCRIPTION DN_DESCRIPTION,
  CRE_USER DN_CURRENT_USER,
  CRE_DATE DN_CURRENT_TIMESTAMP,
  CHG_USER DN_FIREBIRD_USER,
  CHG_DATE DN_TIMESTAMP)
AS
begin
  for 
  execute statement PKG_SQL.SF_GET()
  into 
    :ID, 
    :MAJOR, 
    :MINOR, 
    :SCRIPT, 
    :DESCRIPTION, 
    :CRE_USER, 
    :CRE_DATE, 
    :CHG_USER, 
    :CHG_DATE
  do
    suspend;    
end
^
set term ; ^

                                                                                  
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/