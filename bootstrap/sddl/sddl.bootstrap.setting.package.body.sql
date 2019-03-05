/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es wird der Package-Body für Settings angelegt        
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
RECREATE PACKAGE BODY PKG_SETTINGS
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DELETE_BY_IDENT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      and ident = :AIdent;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      and ident = :AIdent;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_DELETE_BY_SECTION (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_FLOAT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_FLOAT,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_FLOAT)
  AS
  begin
    if (AUseTemp = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as DN_FLOAT)
        from VW_T_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as DN_FLOAT)
        from VW_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;
    end
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_INTEGER (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_INTEGER,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_INTEGER)
  AS
  begin
    if (AUseTemp = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_T_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;
    end  
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_BOOLEAN (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_BOOLEAN,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as DN_BOOLEAN)
        from VW_T_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select cast(STRING_VALUE as DN_BOOLEAN)
        from VW_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;
    end  
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTION (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      IDENT DN_CATEGORY_IDENT,
      STRING_VALUE DN_STRING)
  AS
  begin
    if (AUseTemp = True) then  
      for 
      select IDENT, STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      into :IDENT, :STRING_VALUE
      do
        suspend;
    else
      for 
      select IDENT, STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      into :IDENT, :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTION_VALUES (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT, 
    AUseTemp DN_BOOLEAN)
  RETURNS (
      STRING_VALUE DN_STRING)
  AS
  begin
    if (AUseTemp = True) then  
      for 
      select STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      and IDENT = :AIdent
      into :STRING_VALUE
      do
        suspend;
    else
      for 
      select STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :ACategoryName
      and SECTION_NAME = :ASectionName
      and IDENT = :AIdent
      into :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTIONS (
    ACategoryName DN_CATEGORY,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      SECTION_NAME DN_CATEGORY_SECTION)
  AS
  begin
    if (AUseTemp = True) then
      for 
      select distinct SECTION_NAME
      from VW_T_SETTING
      where CATEGORY_NAME = :ACategoryName
      into :SECTION_NAME
      do
        suspend;    
    else
      for 
      select distinct SECTION_NAME
      from VW_SETTING
      where CATEGORY_NAME = :ACategoryName
      into :SECTION_NAME
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_STRING (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ADefault DN_STRING,
    AUseTemp DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_STRING)
  AS
  begin
    if (AUseTemp = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select STRING_VALUE
        from VW_T_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;  
    end                   
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :ACategoryName
                 and SECTION_NAME = :ASectionName
                 and IDENT = :AIdent))
      then
      begin
        select STRING_VALUE
        from VW_SETTING
        where CATEGORY_NAME = :ACategoryName
        and SECTION_NAME = :ASectionName
        and IDENT = :AIdent
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :ADefault;
    end  
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_FLOAT (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AFloat DN_FLOAT,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      update or insert
      into VW_T_SETTING 
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )
      values
      (                               
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:AFloat as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);        
    else
      update or insert
      into VW_SETTING 
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:AFloat as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);  
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_INTEGER (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AInteger DN_INTEGER,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      update or insert 
      into VW_T_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:AInteger as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);           
    else
      update or insert 
      into VW_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:AInteger as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);  
  end 
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_BOOLEAN (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    ABoolean DN_BOOLEAN,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      update or insert 
      into VW_T_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:ABoolean as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);           
    else
      update or insert 
      into VW_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        Trim(cast(:ABoolean as DN_CATEGORY_STRING_VALUE))
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);  
  end

  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_STRING (
    ACategoryName DN_CATEGORY,
    ASectionName DN_CATEGORY_SECTION,
    AIdent DN_CATEGORY_IDENT,
    AString DN_STRING,
    AUseTemp DN_BOOLEAN)
  AS
  begin
    if (AUseTemp = True) then  
      update or insert 
      into VW_T_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        :AString
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);          
    else
      update or insert 
      into VW_SETTING
      (
        CATEGORY_NAME,
        SECTION_NAME,
        IDENT,
        STRING_VALUE        
      )         
      values
      (
        :ACategoryName,
        :ASectionName,
        :AIdent,
        :AString
      )
      matching (CATEGORY_NAME, SECTION_NAME, IDENT);                  
  end
end^  
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/