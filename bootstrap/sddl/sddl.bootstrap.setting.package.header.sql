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
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DELETE_BY_IDENT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AUseTemp DN_BOOLEAN DEFAULT False);
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DELETE_BY_SECTION (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AUseTemp DN_BOOLEAN DEFAULT False);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_FLOAT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_FLOAT,
    AUseTemp DN_BOOLEAN DEFAULT False) 
    RETURNS (
      RESULT_VALUE DN_FLOAT);   
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_INTEGER (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_INTEGER,
    AUseTemp DN_BOOLEAN DEFAULT False)
  RETURNS (
      RESULT_VALUE DN_INTEGER);      
      
  /*----------------------------------------------------------------------------------------------*/      
  PROCEDURE SP_READ_BOOLEAN (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_BOOLEAN,
    AUseTemp DN_BOOLEAN DEFAULT False)
  RETURNS (
      RESULT_VALUE DN_BOOLEAN);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_SECTION (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AUseTemp DN_BOOLEAN DEFAULT False)  
    RETURNS (
      IDENT DN_CATEGORY_IDENT,
      STRING_VALUE DN_STRING);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_SECTION_VALUES (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT, 
    AUseTemp DN_BOOLEAN DEFAULT False)  
    RETURNS (
      STRING_VALUE DN_STRING);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_SECTIONS (
    ACategoryName DN_CATEGORY,
    AUseTemp DN_BOOLEAN DEFAULT False)
    RETURNS (
      SECTION_NAME DN_CATEGORY_SECTION);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_READ_STRING (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_STRING,
    AUseTemp DN_BOOLEAN DEFAULT False)   
    RETURNS (
       RESULT_VALUE DN_STRING);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_WRITE_FLOAT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AFloat DN_FLOAT,
    AUseTemp DN_BOOLEAN DEFAULT False);
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_WRITE_INTEGER (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AInteger DN_INTEGER,
    AUseTemp DN_BOOLEAN DEFAULT False);
    
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_WRITE_BOOLEAN (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ABoolean DN_BOOLEAN,
    AUseTemp DN_BOOLEAN DEFAULT False);    
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_WRITE_STRING (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AString DN_STRING,
    AUseTemp DN_BOOLEAN DEFAULT False);  
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/