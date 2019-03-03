/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-01                                                        
/* Description: Styleguide Überprüfung
/*   - Package-Header        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-01
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
                                                
/* SPs */
SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG_STYLEGUIDE
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK_KEYWORD(
    AKeyWordToCheck DN_DB_OBJECT = '') 
  RETURNS (
    HIT DN_BOOLEAN,  
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT);

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK 
  RETURNS (
    HIT DN_BOOLEAN,  
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT,
    STYLE_GUIDE_KEYW DN_DB_OBJECT,
    TO_DO DN_DESCRIPTION);

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK_RESERVED(
    AKeyWordToCheck DN_DB_OBJECT = '') 
  RETURNS (
    HIT DN_BOOLEAN,  
    RESERVED DN_DB_OBJECT,
    FOUND_IN DN_COMMENT);
    
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_CHECK_PREFIX
  RETURNS (
    HIT DN_BOOLEAN,
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT,
    MISSING_PREFIX DN_COMMENT);  
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
    'sddl.bootstrap.styleguide.package.header.sql',
    'Package-Header Styleguide installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/