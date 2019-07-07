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

--- prüfen ob nach einem COMMIT die GTT wirklich leer ist: es darf keine script mehr ausgegeben werden

select * 
from  PKG_SQL.SP_GET;

/* --- */

--- script1 anlegen

execute
procedure PKG_SQL.SP_SET('select *', 'script1');
     
execute
procedure PKG_SQL.SP_SET('from hummeldummel1', 'script1');

execute
procedure PKG_SQL.SP_SET('where dummel1 is null', 'script1');

--- script2 anlegen

execute
procedure PKG_SQL.SP_SET('select *', 'script2');
     
execute
procedure PKG_SQL.SP_SET('from hummeldummel2', 'script2');

execute
procedure PKG_SQL.SP_SET('where dummel2 is null', 'script2');


/* --- */

--- prüfen ob DEFAULT Script vorhanden: es darf keine script mehr ausgegeben werden
select * 
from  PKG_SQL.SP_GET;

--- prüfen ob script1 vorhanden: es muss script1 ausgegeben werden
select * 
from  PKG_SQL.SP_GET('script1');

--- prüfen ob script1 vorhanden: es muss script2 ausgegeben werden
select * 
from  PKG_SQL.SP_GET('script2');

/* --- */

--- script1 löschen
execute
procedure PKG_SQL.SP_CLEAR('script1');

--- prüfen ob DEFAULT Script vorhanden: es darf keine script mehr ausgegeben werden
select * 
from  PKG_SQL.SP_GET;

--- prüfen ob script1 vorhanden: es darf keine script mehr ausgegeben werden
select * 
from  PKG_SQL.SP_GET('script1');

--- prüfen ob script2 vorhanden: es muss script2 ausgegeben werden
select * 
from  PKG_SQL.SP_GET('script2');

/* --- */

--- select_history_update anlegen

execute
procedure PKG_SQL.SP_SET('select *', 'select_history_update');
     
execute
procedure PKG_SQL.SP_SET('from VW_HISTORY_UPDATE', 'select_history_update');

execute
procedure PKG_SQL.SP_SET('where MAJOR = 0', 'select_history_update');

/* --- */

--- prüfen ob select_history_update vorhanden: es muss select_history_update ausgegeben werden
select * 
from  PKG_SQL.SP_GET('select_history_update');

/* --- */

--- prüfen ob select_history_update ausgeführt wird: es muss select_history_update ausgeführt werden
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
  execute statement PKG_SQL.SF_GET('select_history_update')
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