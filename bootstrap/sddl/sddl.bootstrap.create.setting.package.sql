/*------------------------------------------------------------------------------------------------*/
/* ### Description: 
/*   * Es wird das Package für Settings angelegt   
/*   * Die aufgerufenen Befehle setzen eine Firebird 3.0.x voraus             
/*   * Ein Connect zu einer Datenbank wird vorausgesetzt                                                                          
/*   
/* Initial Developer: AGE
/*
/*------------------------------------------------------------------------------------------------*/
/*
/* Last modified: $Date:$
/* Revision:      $Revision:$
/* Author:        $Author:$
/*------------------------------------------------------------------------------------------------*/

/* ---------------------------------------------------------------------------------------------- */

SET TERM ^ ;

CREATE OR ALTER PACKAGE PKG$SETTING
AS
begin
  PROCEDURE SP_SETTING_DELETE_BY_IDENT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    USE_TEMP DN_BOOLEAN = 0);
  
  PROCEDURE SP_SETTING_DELETE_BY_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_CATEGORY_FLOAT_VALUE,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE INTEGER,
    USE_TEMP DN_BOOLEAN = 0);   
    
  PROCEDURE SP_SETTING_READ_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_SECTION_VALUES (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT, 
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_SECTIONS (
    CATEGORY_NAME DN_CATEGORY,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_CATEGORY_STRING_VALUE,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_READ_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_CATEGORY_STRING_VALUE,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_WRITE_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    FLOAT_VALUE DN_CATEGORY_FLOAT_VALUE,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_WRITE_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    INT_VALUE INTEGER,
    USE_TEMP DN_BOOLEAN = 0);
    
  PROCEDURE SP_SETTING_WRITE_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    STRING_VALUE DN_CATEGORY_STRING_VALUE,
    USE_TEMP DN_BOOLEAN = 0);  
end^

RECREATE PACKAGE BODY PKG$SETTING
AS
begin
  PROCEDURE SP_SETTING_DELETE_BY_IDENT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    USE_TEMP DN_BOOLEAN = 0)
  AS
  begin
    if (USE_TEMP = 1) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      and ident = :ident;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      and ident = :ident;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_DELETE_BY_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN = 0)
  AS
  begin
    if (USE_TEMP = 1) then  
      delete from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME;  
    else
      delete from VW_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_READ_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_CATEGORY_FLOAT_VALUE,
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      RESULT_VALUE DN_CATEGORY_FLOAT_VALUE)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as DN_CATEGORY_FLOAT_VALUE)
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY
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
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as DN_CATEGORY_FLOAT_VALUE)
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY
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
  PROCEDURE SP_SETTING_READ_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE INTEGER,
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      RESULT_VALUE INTEGER)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY
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
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select cast(STRING_VALUE as integer)
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY
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
  PROCEDURE SP_SETTING_READ_SECTION (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      IDENT DN_CATEGORY_IDENT,
      STRING_VALUE DN_CATEGORY_STRING_VALUE)
  AS
  begin
    if (USE_TEMP = 1) then  
      for 
      select IDENT, STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      into :IDENT, :STRING_VALUE
      do
        suspend;
    else
      for 
      select IDENT, STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      into :IDENT, :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_READ_SECTION_VALUES (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT, 
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      STRING_VALUE DN_CATEGORY_STRING_VALUE)
  AS
  begin
    if (USE_TEMP = 1) then  
      for 
      select STRING_VALUE
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      and IDENT = :IDENT
      into :STRING_VALUE
      do
        suspend;
    else
      for 
      select STRING_VALUE
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY
      and SECTION_NAME = :SECTION_NAME
      and IDENT = :IDENT
      into :STRING_VALUE
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_READ_SECTIONS (
    CATEGORY_NAME DN_CATEGORY,
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      SECTION_NAME DN_CATEGORY_SECTION)
  AS
  begin
    if (USE_TEMP = 1) then
      for 
      select distinct SECTION_NAME
      from VW_T_SETTING
      where CATEGORY_NAME = :CATEGORY
      into :SECTION_NAME
      do
        suspend;    
    else
      for 
      select distinct SECTION_NAME
      from VW_SETTING
      where CATEGORY_NAME = :CATEGORY
      into :SECTION_NAME
      do
        suspend;
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_READ_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    DEFAULT_VALUE DN_CATEGORY_STRING_VALUE,
    USE_TEMP DN_BOOLEAN = 0)
  RETURNS (
      RESULT_VALUE DN_CATEGORY_STRING_VALUE)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select STRING_VALUE
        from VW_T_SETTING
        where CATEGORY_NAME = :CATEGORY
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
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
      begin
        select STRING_VALUE
        from VW_SETTING
        where CATEGORY_NAME = :CATEGORY
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
  PROCEDURE SP_SETTING_WRITE_FLOAT (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    FLOAT_VALUE DN_CATEGORY_FLOAT_VALUE,
    USE_TEMP DN_BOOLEAN = 0)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = cast(:FLOAT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_T_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          cast(:FLOAT_VALUE as varchar(255)),
          null
        );
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = cast(:FLOAT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          cast(:FLOAT_VALUE as varchar(255)),
          null
        );
    end
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_WRITE_INTEGER (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    INT_VALUE INTEGER,
    USE_TEMP DN_BOOLEAN = 0)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = cast(:INT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_T_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          cast(:INT_VALUE as varchar(255)),
          null
        );  
    end
    else
    begin 
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = cast(:INT_VALUE as varchar(255))
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          cast(:INT_VALUE as varchar(255)),
          null
        );
    end
  end
  
  /* ---------------------------------------------------------------------------------------------- */
  PROCEDURE SP_SETTING_WRITE_STRING (
    CATEGORY_NAME DN_CATEGORY,
    SECTION_NAME DN_CATEGORY_SECTION,
    IDENT DN_CATEGORY_IDENT,
    STRING_VALUE DN_CATEGORY_STRING_VALUE,
    USE_TEMP DN_BOOLEAN = 0)
  AS
  begin
    if (USE_TEMP = 1) then  
    begin
      if (exists(select 1 from VW_T_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_T_SETTING 
        set STRING_VALUE = :string_value
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_T_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          :STRING_VALUE,
          null
        );  
    end
    else
    begin
      if (exists(select 1 from VW_SETTING
                 where CATEGORY_NAME = :CATEGORY
                 and SECTION_NAME = :SECTION_NAME
                 and IDENT = :IDENT))
      then
        update VW_SETTING 
        set STRING_VALUE = :string_value
        where CATEGORY_NAME = :CATEGORY
        and SECTION_NAME = :SECTION_NAME
        and IDENT = :IDENT;
      else
        insert 
        into 
        VW_SETTING 
        values
        (
          :CATEGORY,
          :SECTION_NAME,
          :IDENT,
          :STRING_VALUE,
          null
        );
    end
  end
end^  
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/