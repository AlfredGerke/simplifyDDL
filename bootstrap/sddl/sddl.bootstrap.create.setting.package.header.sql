/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es wird der Package-Header für Settings angelegt        
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

/* ---------------------------------------------------------------------------------------------- */

SET TERM ^ ;
CREATE OR ALTER PACKAGE PKG_SETTINGS
AS
begin
  PROCEDURE SP_DELETE_BY_IDENT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    USE_TEMP DN_BOOLEAN DEFAULT False);
  
  PROCEDURE SP_DELETE_BY_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN DEFAULT False);
    
  PROCEDURE SP_READ_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_FLOAT,
    USE_TEMP DN_BOOLEAN DEFAULT False) 
    RETURNS (
      RESULT_VALUE DN_FLOAT);   
    
  PROCEDURE SP_READ_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_INTEGER,
    USE_TEMP DN_BOOLEAN DEFAULT False)
  RETURNS (
      RESULT_VALUE DN_INTEGER);      
    
  PROCEDURE SP_READ_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN DEFAULT False)  
    RETURNS (
      IDENT DN_CATEGORY_IDENT,
      STRING_VALUE DN_STRING);
    
  PROCEDURE SP_READ_SECTION_VALUES (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT, 
    USE_TEMP DN_BOOLEAN DEFAULT False)  
    RETURNS (
      STRING_VALUE DN_STRING);
    
  PROCEDURE SP_READ_SECTIONS (
    CATEGORY_NAME DN_CATEGORY,
    USE_TEMP DN_BOOLEAN DEFAULT False)
    RETURNS (
      SECTION_NAME DN_CATEGORY_SECTION);
    
  PROCEDURE SP_READ_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_STRING,
    USE_TEMP DN_BOOLEAN DEFAULT False)   
    RETURNS (
       RESULT_VALUE DN_STRING);
    
  PROCEDURE SP_WRITE_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    FLOAT_VALUE DN_FLOAT,
    USE_TEMP DN_BOOLEAN DEFAULT False);
    
  PROCEDURE SP_WRITE_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    INT_VALUE DN_INTEGER,
    USE_TEMP DN_BOOLEAN DEFAULT False);
    
  PROCEDURE SP_WRITE_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    STRING_VALUE DN_STRING,
    USE_TEMP DN_BOOLEAN DEFAULT False);  
end^
SET TERM ; ^

COMMIT WORK;

/*------------------------------------------------------------------------------------------------*/
/* Updatehistory                                   
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.create.setting.model.sql',
    'Model der Settings installiert');

  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.create.setting.package.header.sql',
    'Package-Header der Settings installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/