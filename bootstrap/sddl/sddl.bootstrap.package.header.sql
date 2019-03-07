/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Das sDDL.bootstrap wird angelegt
/*   - s. https://github.com/AlfredGerke/simplifyDDL
/*   - s. https://github.com/AlfredGerke/ZABonline
/*   - Package-Header        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/

/* SPs */
SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG_SDDL
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DROP_RECURSIVE (
    AEntity DN_DB_OBJECT,
    ADoRecursive DN_BOOLEAN Default True)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    SQL_STATE DN_SQLSTATE,
    LOG_MESSAGE DN_MESSAGE);  

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_RESTRUCTURE_TABLE (
    ATablename DN_DB_OBJECT,
    AColumn DN_DB_OBJECT,
    APosition DN_INDEX DEFAULT 1)
  RETURNS (
    SUCCESS DN_BOOLEAN); 

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_CATALOG (
    ACatalogname DN_DB_OBJECT,
    ADomain DN_DB_OBJECT DEFAULT 'DN_CAPTION',
    AComment DN_COMMENT DEFAULT '')
  RETURNS (
    SUCCESS DN_BOOLEAN);

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_STAMP (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN);
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_FIELD_DESCRIPTION (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN);
   
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_COMPLETE_TABLE (
    ATablename DN_DB_OBJECT,
    ADoDescription DN_BOOLEAN,
    ADoStamp DN_BOOLEAN,
    ADoComment DN_BOOLEAN,
    AComment DN_COMMENT, 
    ADoPK DN_BOOLEAN DEFAULT True)
  RETURNS (
    SUCCESS DN_BOOLEAN);
   
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_CONSTRAINTS (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE);
    
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_ALL_CONSTRAINTS
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE);
   
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GRANT_ALL;       
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GRANT (
    ADBObject DN_DB_OBJECT);
              
end^  
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.create.package.header.sql',
    'Package-Header des sDDL-Bootstrap installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/