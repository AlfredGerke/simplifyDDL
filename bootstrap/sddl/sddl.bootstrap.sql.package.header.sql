/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-07-06                                                       
/* Description: Handling für SQL-Statements implementieren
/*   - Package-Header        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-07-06
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/

/* Interface */
SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG_SQL
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_IS_AVAILABLE (AIdent DN_SQL_IDENT not null default 'DEFAULT')
  RETURNS DN_BOOLEAN;

  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_GET (AIdent DN_SQL_IDENT not null default 'DEFAULT')
  RETURNS DN_SQL_BLOB;
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_SET(AScript DN_SQL_BLOB,
    AIdent DN_SQL_IDENT not null default 'DEFAULT');  
     
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GET (AIdent DN_SQL_IDENT not null default 'DEFAULT')
  RETURNS (
    SQL_STATEMENT DN_SQL_BLOB);    
    
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CLEAR(AIdent DN_SQL_IDENT default null);      
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_EXECUTE(AScript DN_SQL_BLOB default null,
    AClear DN_BOOLEAN default false,
    AIdent DN_SQL_IDENT not null default 'DEFAULT');
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_EXECUTE_ALL;        
    
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/