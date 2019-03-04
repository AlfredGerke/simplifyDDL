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
RECREATE PACKAGE BODY PKG_STYLEGUIDE
AS
begin

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK_KEYWORD(
    AKeyWordToCheck DN_DB_OBJECT) 
  RETURNS (
    HIT DN_BOOLEAN,  
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT)
  AS
  declare relation_name DN_DB_OBJECT;
  begin
    HIT = False;
    OBJECT_NAME = null;
    FOUND_IN = null;
    
    /* Felder in Tabellen und Views */
    for
    select distinct RDB$FIELD_NAME 
    from RDB$RELATION_FIELDS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Felder';
        
        Suspend;
      end
    end  
    
    /* Alle Domains */
    for  
    select distinct RDB$FIELD_NAME 
    from RDB$FIELDS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Domains';
        
        Suspend;
      end  
    end  
    
    /* Alle Sequencen */
    for
    select distinct RDB$GENERATOR_NAME 
    from RDB$GENERATORS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Sequences';
        
        Suspend;
      end    
    end
  
    /* Alle SPs */
    for
    select distinct RDB$PROCEDURE_NAME 
    from RDB$PROCEDURES 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'StoredProcedures';
        
        Suspend;
      end  
    end
    
    for
    select distinct RDB$PARAMETER_NAME 
    from RDB$PROCEDURE_PARAMETERS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Parameters/Returns (SP)';
        
        Suspend;
      end  
    end  
    
    /* Alle SFs */
    for
    select distinct RDB$FUNCTION_NAME 
    from RDB$FUNCTIONS 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'StoredFunction';
        
        Suspend;
      end  
    end
    
    for
    select distinct RDB$FIELD_NAME 
    from RDB$FUNCTION_ARGUMENTS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Arguments (SF)';
        
        Suspend;
      end  
    end  
        
    /* Packages */
    for
    select distinct RDB$PACKAGE_NAME
    from RDB$PACKAGES
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Packages';
        
        Suspend;
      end  
    end           
        
    /* Relations */
    for
    select distinct RDB$RELATION_NAME 
    from RDB$RELATIONS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Tabellen/Views';
        
        Suspend;
      end  
    end
    
    /* Constraints */
    for
    select RDB$CONSTRAINT_NAME
    from RDB$RELATION_CONSTRAINTS 
    into :relation_name
    do
    begin  
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Constraints';
        
        Suspend;
      end
    end
    
    /* Indexe */
    for
    select RDB$INDEX_NAME 
    from RDB$INDICES 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Indices';
        
        Suspend;
      end 
    end
  end
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK 
  RETURNS (
    HIT DN_BOOLEAN,  
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT,
    STYLE_GUIDE_KEYW DN_DB_OBJECT,
    TO_DO DN_DESCRIPTION)
  AS
  begin
    HIT = False;  
    OBJECT_NAME = '';
    FOUND_IN = '';
    STYLE_GUIDE_KEYW = '';
    TO_DO = '';    
  
    for
    select CAPTION, DESCRIPTION 
    from VW_L_INVALID_STYLEGUIDE
    into :STYLE_GUIDE_KEYW, :TO_DO
    do
    begin
      for
      select HIT, OBJECT_NAME, FOUND_IN
      from SP_CHECK_KEYWORD(:STYLE_GUIDE_KEYW)
      into :HIT, :OBJECT_NAME, :FOUND_IN
      do
      begin  
        if (HIT = True) then
          suspend;  
      end    
      
      HIT = False;  
      OBJECT_NAME = '';
      FOUND_IN = '';
      STYLE_GUIDE_KEYW = '';
      TO_DO = '';    
    end      
  end
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_CHECK_RESERVED(
    AKeyWordToCheck DN_DB_OBJECT) 
  RETURNS (
    HIT DN_BOOLEAN,  
    RESERVED DN_DB_OBJECT,
    FOUND_IN DN_COMMENT)
  AS
  declare variable relation_name DN_DB_OBJECT;
  begin
    HIT = False;
    RESERVED = null;
    FOUND_IN = null;
    
    if (Trim(AKeyWordToCheck) = '') then
    begin
      /* Felder in Tabellen und Views */
      for
      select distinct RDB$FIELD_NAME 
      from RDB$RELATION_FIELDS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Felder (VW_L_RESERVED_WORDS)';
          
          Suspend;
        end
        else
        begin
          if (exists(select 1 
                     from RDB$TYPES 
                     where Upper(Trim(RDB$TYPE_NAME))=Upper(Trim(:relation_name)))) 
          then
          begin
            HIT = True;
            RESERVED = relation_name; 
            FOUND_IN = 'Felder (RDB$TYPE_NAME)';
            
            Suspend;     
          end
        end
      end  
      
      /* Alle Domains */
      for  
      select distinct RDB$FIELD_NAME 
      from RDB$FIELDS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Domains';
          
          Suspend;
        end  
      end  
      
      /* Alle Sequencen */
      for
      select distinct RDB$GENERATOR_NAME 
      from RDB$GENERATORS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Sequences';
          
          Suspend;
        end    
      end
    
      /* Alle SPs */
      for
      select distinct RDB$PROCEDURE_NAME 
      from RDB$PROCEDURES 
      where RDB$SYSTEM_FLAG = 0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'StoredProcedures';
          
          Suspend;
        end  
      end
      
      for
      select distinct RDB$PARAMETER_NAME 
      from RDB$PROCEDURE_PARAMETERS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Parameters/Returns';
          
          Suspend;
        end  
      end  
      
      /* Alle SFs */
      for
      select distinct RDB$FUNCTION_NAME 
      from RDB$FUNCTIONS 
      where RDB$SYSTEM_FLAG = 0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'StoredFunctions';
          
          Suspend;
        end    
      end
      
      for
      select distinct RDB$FIELD_NAME 
      from RDB$FUNCTION_ARGUMENTS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Arguments (SF)';
          
          Suspend;
        end  
      end  
          
      /* Packages */
      for
      select distinct RDB$PACKAGE_NAME
      from RDB$PACKAGES
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Packages';
          
          Suspend;
        end        
      end           
        
      /* Relations */
      for
      select distinct RDB$RELATION_NAME 
      from RDB$RELATIONS 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Tabellen/Views';
          
          Suspend;
        end  
      end
      
      /* Constraints */
      for
      select RDB$CONSTRAINT_NAME
      from RDB$RELATION_CONSTRAINTS 
      into
        :relation_name
      do
      begin  
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Constraints';
          
          Suspend;
        end
      end
      
      /* Indexe */
      for
      select RDB$INDEX_NAME 
      from RDB$INDICES 
      where RDB$SYSTEM_FLAG=0
      into :relation_name
      do
      begin
        if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:relation_name)))) 
        then
        begin
          HIT = True;
          RESERVED = relation_name; 
          FOUND_IN = 'Indices';
          
          Suspend;
        end 
      end
    end
    else
    begin
       if (exists(select 1 
                   from VW_L_RESERVED_WORDS 
                   where Upper(Trim(CAPTION))=Upper(Trim(:AKeyWordToCheck)))) 
        then
        begin
          HIT = True;
          RESERVED = AKeyWordToCheck; 
          FOUND_IN = 'OnDemand';
          
          Suspend;
        end   
    end  
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CHECK_PREFIX
  RETURNS (
    HIT DN_BOOLEAN,
    OBJECT_NAME DN_DB_OBJECT,
    FOUND_IN DN_COMMENT,
    MISSING_PREFIX DN_COMMENT)
  AS
  declare relation_name DN_DB_OBJECT;
  declare prefix_to_check DN_COMMENT;
  begin
    HIT = False;
    
    OBJECT_NAME = null;
    FOUND_IN = null;
    
    /* Tabellen und Views */
    prefix_to_check = 'TB';
    for
    select distinct RDB$RELATION_NAME 
    from RDB$RELATIONS 
    where RDB$SYSTEM_FLAG=0
    and RDB$RELATION_TYPE=0
    into :relation_name
    do
    begin
      execute
      procedure PKG_HISTORY.SP_SET_DEBUG(:relation_name, 
        :prefix_to_check);
    
      if (position(Upper(:prefix_to_check) in Upper(Trim(:relation_name))) = 1) then
      begin
        if ((not (position(Upper('_') in Upper(Trim(:relation_name))) = 3)) and 
            (not (position(Upper('L_') in Upper(Trim(:relation_name))) = 3)))        
        then
        begin
          HIT = True;
          OBJECT_NAME = relation_name; 
          FOUND_IN = 'Tables'; 
          
          MISSING_PREFIX = 'TB_ / TBL_';         
          
          Suspend;         
        end
      end
      else      
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Tables'; 
        
        MISSING_PREFIX = 'TB';         
        
        Suspend; 
      end
    end
    
    prefix_to_check = 'TBT_';
    for
    select distinct RDB$RELATION_NAME 
    from RDB$RELATIONS 
    where RDB$SYSTEM_FLAG=0
    and RDB$RELATION_TYPE=5
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Temporary Tables';        
        
        Suspend;
      end
    end    
    
    prefix_to_check = 'VW_';
    for
    select distinct RDB$RELATION_NAME 
    from RDB$RELATIONS 
    where RDB$SYSTEM_FLAG=0
    and RDB$RELATION_TYPE=1
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        MISSING_PREFIX = 'VR_';
        if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
        begin        
          HIT = True;
          OBJECT_NAME = relation_name; 
          FOUND_IN = 'Views';
          
          MISSING_PREFIX = 'VR_ / VW_';        
          
          Suspend;
        end
      end  
    end  
          
    /* Alle Domains */
    prefix_to_check = 'DN_';
    for  
    select distinct RDB$FIELD_NAME 
    from RDB$FIELDS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Domains';        
        
        Suspend;
      end  
    end  
    
    /* Alle Sequencen */
    prefix_to_check = 'SEQ_';
    for
    select distinct RDB$GENERATOR_NAME 
    from RDB$GENERATORS 
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Sequences';        
        
        Suspend;
      end      
    end
  
    /* Alle SPs */
    prefix_to_check = 'SP_';
    for
    select distinct RDB$PROCEDURE_NAME 
    from RDB$PROCEDURES 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Stored Procedures';        
        
        Suspend;
      end        
    end
    
    prefix_to_check = 'A';    
    for
    select distinct RDB$PARAMETER_NAME 
    from RDB$PROCEDURE_PARAMETERS 
    where RDB$SYSTEM_FLAG=0
    and RDB$PARAMETER_TYPE=0 
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Stored Procedure Parameters';        
        
        Suspend;
      end          
    end  
    
    /* Alle SFs */
    prefix_to_check = 'SF_';
    for
    select distinct RDB$FUNCTION_NAME 
    from RDB$FUNCTIONS 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Stored Functions';        
        
        Suspend;
      end            
    end

--     /* Muss noch geprüft werden wie Results von Parametern unterschieden werden */    
--     for
--     select distinct RDB$FIELD_NAME 
--     from RDB$FUNCTION_ARGUMENTS 
--     where RDB$SYSTEM_FLAG=0
--     into :relation_name
--     do
--     begin
--       if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
--       begin
--         HIT = True;
--         OBJECT_NAME = relation_name; 
--         FOUND_IN = 'Arguments (SF)';
--         
--         Suspend;
--       end  
--     end  
        
    /* Packages */
    prefix_to_check = 'PKG_';    
    for
    select distinct RDB$PACKAGE_NAME
    from RDB$PACKAGES
    where RDB$SYSTEM_FLAG=0
    into :relation_name
    do
    begin
      if (not (position(Upper(:prefix_to_check) in Upper(:relation_name)) = 1)) then
      begin
        HIT = True;
        OBJECT_NAME = relation_name; 
        FOUND_IN = 'Packages';        
        
        Suspend;
      end              
    end           
           
--     /* Muss eingehend geprüft werden wie die Indexe unterschieden werden können         
--     /* Constraints */
--     for
--     select RDB$CONSTRAINT_NAME
--     from RDB$RELATION_CONSTRAINTS 
--     into :relation_name
--     do
--     begin  
--       if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
--       begin
--         HIT = True;
--         OBJECT_NAME = relation_name; 
--         FOUND_IN = 'Constraints';
--         
--         Suspend;
--       end
--     end
--     
--     /* Indexe */
--     for
--     select RDB$INDEX_NAME 
--     from RDB$INDICES 
--     where RDB$SYSTEM_FLAG=0
--     into :relation_name
--     do
--     begin
--       if (position(Upper(:AKeyWordToCheck) in Upper(:relation_name)) > 0) then
--       begin
--         HIT = True;
--         OBJECT_NAME = relation_name; 
--         FOUND_IN = 'Indices';
--         
--         Suspend;
--       end 
--     end  
  end  
end^
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG_STYLEGUIDE.SP_CHECK_RESERVED IS
'Überprüft Felder, Parameter und Ausgabefelder auf reservierte Wörter';

COMMENT ON PROCEDURE PKG_STYLEGUIDE.SP_CHECK IS
'Überprüft Felder, Parameter und Ausgabefelder auf ausgeschlossene StyleGuide-Elemente';

COMMENT ON PROCEDURE PKG_STYLEGUIDE.SP_CHECK_KEYWORD IS
'Prüft Datenmodell auf Abweichungen im StyleGuide anhand eines Schlüsselwortes';

COMMENT ON PROCEDURE PKG_STYLEGUIDE.SP_CHECK_PREFIX IS
'Prüft Datenmodell auf Abweichungen im vorgeschriebenem Prefix';

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.styleguide.package.pody.sql',
    'Package-Body Styleguide installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/