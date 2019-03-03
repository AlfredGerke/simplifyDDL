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
  PROCEDURE SP_RESTRUCTURE_TABLE (
    ATablename DN_DB_OBJECT,
    AColumn DN_DB_OBJECT,
    APosition DN_INDEX = 1)
  RETURNS (
    SUCCESS DN_BOOLEAN); 

-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------
--    PROCEDURE SP_EXTRACT_TABLENAME (
--     ATablename DN_DB_OBJECT,
--     APrefix DN_PREFIX)
--   RETURNS (
--     DETERMINED DN_BOOLEAN,
--     TABLENAME DN_DB_OBJECT);
----------------------------------------------------------------------------------------------------

-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------                                                                                                    
--   PROCEDURE SP_GET_COLUMNLIST(
--     ATablename DN_DB_OBJECT,
--     ASeparator DN_COLUMNLIST_SEPARATOR,
--     ADoCR DN_BOOLEAN)
--   returns(
--     COLUMNLIST DN_COLUMNLIST);                                                                      
----------------------------------------------------------------------------------------------------
                        
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------
--   PROCEDURE SP_GET_PRIMKEYLIST (
--     ATablename DN_DB_OBJECT,
--     ASeparator DN_COLUMNLIST_SEPARATOR,
--     ADoCR DN_BOOLEAN)
--   returns (
--     COUNT_PK_FIELDS DN_COUNT,
--     COLUMNLIST DN_COLUMNLIST);
----------------------------------------------------------------------------------------------------
    
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------    
--   PROCEDURE SP_CREATE_STD_TABLE_VIEW_CMT (
--     ATablename DN_DB_OBJECT,
--     AViewname DN_DB_OBJECT);
----------------------------------------------------------------------------------------------------
                                                                                                    
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------                                                                                                    
--   PROCEDURE SP_CREATE_STD_TABLE_VIEW(
--     ATablename DN_DB_OBJECT,
--     AOrderByPrim DN_BOOLEAN) /* wenn True dann USER_VIEW nur ReadOnly */
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
                                                                                                    
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------                                                                                                    
--   PROCEDURE SP_CREATE_TRIGGER_BI (
--     ATablename DN_DB_OBJECT)
--   returns (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
                                                                                                    
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------                                                                                                    
--   PROCEDURE SP_CREATE_SEQUNECE(
--     ATablename DN_DB_OBJECT,
--     AFieldname DN_DB_OBJECT Default 'ID',
--     AComment DN_COMMENT Default '')
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_TBL_CATALOG (
--     ATablename DN_DB_OBJECT,
--     ADomain DN_DB_OBJECT DEFAULT 'DN_CAPTION',
--     AComment DN_COMMENT DEFAULT '', 
--     ACreateUniqueKey DN_BOOLEAN DEFAULT 1)
--   RETURNS (
--     SUCCESS DN_BOOLEAN,
--     CATALOGNAME DN_DB_OBJECT,
--     TABLENAME DN_DB_OBJECT);
----------------------------------------------------------------------------------------------------
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CREATE_CATALOG (
    ACatalogname DN_DB_OBJECT,
    ADomain DN_DB_OBJECT DEFAULT 'DN_CAPTION',
    AComment DN_COMMENT DEFAULT '')
  RETURNS (
    SUCCESS DN_BOOLEAN);

-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_STAMP (
--     ATablename DN_DB_OBJECT)
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_FIELD_DESCRIPTION (
--     ATablename DN_DB_OBJECT)
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_TABLE_COMMENT (
--     ATablename DN_DB_OBJECT,
--     AComment DN_COMMENT)
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_PRIMARY_CONSTRAINT (
--     ATablename DN_DB_OBJECT)
--   RETURNS (
--     SUCCESS DN_BOOLEAN);
----------------------------------------------------------------------------------------------------
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_COMPLETE_TABLE (
    ATablename DN_DB_OBJECT,
    ADoDescription DN_BOOLEAN,
    ADoStamp DN_BOOLEAN,
    ADoComment DN_BOOLEAN,
    AComment DN_COMMENT, 
    ADoPK DN_BOOLEAN)
  RETURNS (
    SUCCESS DN_BOOLEAN);
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CHECK_COMMAND (
--     AGenCommand DN_GEN_COMMAND,
--     AFieldDescription DN_DB_COMMENT)
--   RETURNS (
--     DETERMINED DN_BOOLEAN,
--     FIELDDESCRIPTION DN_DB_COMMENT,
--     TABLENAME DN_DB_OBJECT,
--     FIELDNAME DN_DB_OBJECT,
--     REQUIRED DN_SQL_STMT);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_UNIQUE_KEY(
--     ATablename DN_DB_OBJECT,
--     AFieldname DN_DB_OBJECT,
--     AFieldDescription DN_DB_COMMENT)
--   RETURNS (  
--     SUCCESS DN_BOOLEAN,
--     LOG_MESSAGE DN_MESSAGE);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_UNIQUE_IDX(
--     ATablename DN_DB_OBJECT,
--     AFieldname DN_DB_OBJECT,
--     AFieldDescription DN_DB_COMMENT)
--   RETURNS (  
--     SUCCESS DN_BOOLEAN,
--     LOG_MESSAGE DN_MESSAGE);
----------------------------------------------------------------------------------------------------
    
/*   wird in SP_CREATE_FOREIGN_KEY für die Implementation benötigt, 
     kann aber erst nach SP_CREATE_FOREIGN_KEY selber implementiert werden/
  PROCEDURE SP_CREATE_CONSTRAINTS (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE);
*/    
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_CREATE_FOREIGN_KEY(
--     ATablename DN_DB_OBJECT,
--     AFieldname DN_DB_OBJECT,
--     AFieldDescription DN_DB_COMMENT,
--     AFKTablename DN_DB_OBJECT,
--     AFKFieldname DN_DB_OBJECT,
--     ACondition DN_SQL_STMT)
--   RETURNS (
--     SUCCESS DN_BOOLEAN,
--     LOG_MESSAGE DN_MESSAGE);
----------------------------------------------------------------------------------------------------
  
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
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_VIEW (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     ADeleteRole DN_DB_OBJECT DEFAULT 'SDDL_DELETE',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC');
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_SEQ (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC');
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_EXC (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC');
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_SP (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
--     AAllowLog DN_BOOLEAN = True,
--     AAllowDebug DN_BOOLEAN = True);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_SF (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
--     AAllowLog DN_BOOLEAN = True,
--     AAllowDebug DN_BOOLEAN = True);
----------------------------------------------------------------------------------------------------
  
-- Nur bei Bedarf in den Header aufnehmen ----------------------------------------------------------  
--   PROCEDURE SP_GRANT_PKG (
--     ADBObject DN_DB_OBJECT,  
--     AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
--     APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
--     AAllowLog DN_BOOLEAN = True,
--     AAllowDebug DN_BOOLEAN = True);
----------------------------------------------------------------------------------------------------
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GRANT_ALL;       
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GRANT (
    ADBObject DN_DB_OBJECT);
      
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_CHECK_STYLEGUIDE_KEYW(
    AKeyWordToCheck DN_DB_OBJECT = '') 
  RETURNS (
    HIT DN_BOOLEAN,  
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT);  
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