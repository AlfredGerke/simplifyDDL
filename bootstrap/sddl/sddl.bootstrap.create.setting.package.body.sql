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
RECREATE PACKAGE BODY PKG$SETTINGS
AS
begin
  PROCEDURE SP_DELETE_BY_IDENT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    USE_TEMP DN_BOOLEAN)
  AS
  begin
    if (USE_TEMP = True) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      and ident = :ident;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      and ident = :ident;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_DELETE_BY_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN)
  AS
  begin
    if (USE_TEMP = True) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_FLOAT,
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_FLOAT)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as DN_FLOAT)
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as DN_FLOAT)
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;
    end
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_INTEGER,
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_INTEGER)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;
    end  
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      IDENT DN_CATEGORY_IDENT,
      STRING_VALUE DN_STRING)
  AS
  begin
    if (USE_TEMP = True) then  
      for 
      select IDENT, STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      into :IDENT, :STRING_VALUE
      do
        suspend;
    else
      for 
      select IDENT, STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      into :IDENT, :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTION_VALUES (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT, 
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      STRING_VALUE DN_STRING)
  AS
  begin
    if (USE_TEMP = True) then  
      for 
      select STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      and IDENT = :IDENT
      into :STRING_VALUE
      do
        suspend;
    else
      for 
      select STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      and SECTION_NAME = :SECTION_NAME
      and IDENT = :IDENT
      into :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_SECTIONS (
    CATEGORY_NAME DN_CATEGORY,
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      SECTION_NAME DN_CATEGORY_SECTION)
  AS
  begin
    if (USE_TEMP = True) then
      for 
      select distinct SECTION_NAME
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      into :SECTION_NAME
      do
        suspend;    
    else
      for 
      select distinct SECTION_NAME
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY_NAME
      into :SECTION_NAME
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_READ_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_STRING,
    USE_TEMP DN_BOOLEAN)
  RETURNS (
      RESULT_VALUE DN_STRING)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select STRING_VALUE
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select STRING_VALUE
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT
        into :RESULT_VALUE;
      end
      else
        RESULT_VALUE = :DEFAULT_VALUE;
    end  
  
    suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    FLOAT_VALUE DN_FLOAT,
    USE_TEMP DN_BOOLEAN)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = cast(:FLOAT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_T_SETTING 
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          cast(:FLOAT_VALUE as varchar(255))
        );
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = cast(:FLOAT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_SETTING
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )         
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          cast(:FLOAT_VALUE as varchar(255))
        );
    end
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    INT_VALUE DN_INTEGER,
    USE_TEMP DN_BOOLEAN)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = cast(:INT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_T_SETTING
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )         
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          cast(:INT_VALUE as varchar(255))
        );  
    end
    else
    begin 
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = cast(:INT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_SETTING
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )                  
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          cast(:INT_VALUE as varchar(255))
        );
    end
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_WRITE_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    STRING_VALUE DN_STRING,
    USE_TEMP DN_BOOLEAN)
  AS
  begin
    if (USE_TEMP = True) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = :string_value
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_T_SETTING
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )         
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          :STRING_VALUE
        );  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY_NAME
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = :string_value
        where CATEGORY_NAME = :CATEGORY_NAME
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into VW_SETTING
        (
          CATEGORY_NAME,
          SECTION_NAME,
          IDENT,
          STRING_VALUE        
        )         
        values
        (
          :CATEGORY_NAME,
          :SECTION_NAME,
          :IDENT,
          :STRING_VALUE
        );
    end
  end
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
  PKG$HISTORY_UPDATE.SP_SET_INFO (0,
    0,
    'sddl.bootstrap.create.setting.package.body.sql',
    'Package-body der Settings installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/