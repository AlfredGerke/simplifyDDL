/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Das sDDL.bootstrap wird angelegt
/*   - s. https://github.com/AlfredGerke/simplifyDDL
/*   - s. https://github.com/AlfredGerke/ZABonline        
/*   - Package-Body
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
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
RECREATE PACKAGE BODY PKG_SDDL
AS
begin
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GET_CUSTOM_ROLES
  RETURNS (
    SUCCESS DN_BOOLEAN,
    ROLE_ALL DN_DB_OBJECT,
    ROLE_PUBLIC DN_DB_OBJECT,
    ROLE_DELETE DN_DB_OBJECT)
  AS
  begin
    SUCCESS = False;  
    
    ROLE_ALL = 'SDDL_ALL';
    ROLE_PUBLIC = 'SDDL_PUBLIC';
    ROLE_DELETE = 'SDDL_DELETE';  
  
    select Trim(RESULT_VALUE)
    from PKG_SETTINGS.SP_READ_STRING('CUSTOM',
      'SDDL',
      'ROLE.ALL',
      'SDDL_ALL')
    into :ROLE_ALL;
    
    select Trim(RESULT_VALUE)
    from PKG_SETTINGS.SP_READ_STRING('CUSTOM',
      'SDDL',
      'ROLE.PUBLIC',
      'SDDL_PUBLIC')
    into :ROLE_PUBLIC;  

    select Trim(RESULT_VALUE)
    from PKG_SETTINGS.SP_READ_STRING('CUSTOM',
      'SDDL',
      'ROLE.DELETE',
      'SDDL_DELETE')
    into :ROLE_DELETE;
    
    if ((Trim(:ROLE_ALL) <> '') and 
        (Trim(:ROLE_PUBLIC) <> '') and 
        (Trim(:ROLE_DELETE) <> '')) 
    then
      SUCCESS = True;
    
    suspend;
    
    when any do
    begin
      ROLE_ALL = 'SDDL_ALL';
      ROLE_PUBLIC = 'SDDL_PUBLIC';
      ROLE_DELETE = 'SDDL_DELETE';
        
      SUCCESS = False;
      
      suspend;
    end  
  end  

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DROP_TABLE (
    ATable DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    SQL_STATE DN_SQLSTATE,
    LOG_MESSAGE DN_MESSAGE)
  AS
  begin
    SUCCESS = False;
    SQL_STATE = '00000';
    LOG_MESSAGE = 'keine Information';
    
    /* Tabelle l�schen */
    
    /* Pr�fung ob L�schung erfolgreich */
     
    SUCCESS = True;
    
    suspend;
    
    when any do
    begin
      SUCCESS = False;
      SQL_STATE = SQLSTATE;
      LOG_MESSAGE = 'Fehler beim L�schen einer Tabelle';

      suspend;
    end
  end  
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DROP_VIEW (
    AView DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    SQL_STATE DN_SQLSTATE,
    LOG_MESSAGE DN_MESSAGE)
  AS
  begin
    SUCCESS = False;
    SQL_STATE = '00000';
    LOG_MESSAGE = 'keine Information';
    
    /* View l�schen */
    
    /* Pr�fung ob L�schung erfolgreich */
     
    SUCCESS = True;
    
    suspend;
    
    when any do
    begin
      SUCCESS = False;
      SQL_STATE = SQLSTATE;
      LOG_MESSAGE = 'Fehler beim L�schen einer View';

      suspend;
    end  
  end  
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DROP_SEQ (
    ASF DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    SQL_STATE DN_SQLSTATE,
    LOG_MESSAGE DN_MESSAGE)
  AS
  begin
    SUCCESS = False;
    SQL_STATE = '00000';
    LOG_MESSAGE = 'keine Information';
    
    /* SEQ l�schen */
    
    /* Pr�fung ob L�schung erfolgreich */
     
    SUCCESS = True;
    
    suspend;
    
    when any do
    begin
      SUCCESS = False;
      SQL_STATE = SQLSTATE;
      LOG_MESSAGE = 'Fehler beim L�schen einer Sequence';

      suspend;
    end  
  end      

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_DROP_RECURSIVE (
    AEntity DN_DB_OBJECT,
    ADoRecursive DN_BOOLEAN)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    SQL_STATE DN_SQLSTATE,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare drop_sequence DN_BOOLEAN;
  begin
    SUCCESS = False;
    SQL_STATE = '00000';
    LOG_MESSAGE = 'keine Information';
    
    :drop_sequence = False;
    select RESULT_VALUE
    from PKG_SETTINGS.SP_READ_BOOLEAN ('CUSTOM', 
      'SDDL', 
      'DROP.RECURSIVE.SEQUENCE', 
      False)
    into :drop_sequence;
       
    suspend;
    
    when any do
    begin
      SUCCESS = False;
      SQL_STATE = SQLSTATE;
      LOG_MESSAGE = 'Fehler beim L�schen einer Entit�t';

      suspend;
    end    
  end  
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_RESTRUCTURE_TABLE (
    ATablename DN_DB_OBJECT,
    AColumn DN_DB_OBJECT,
    APosition DN_INDEX)
  RETURNS (
    SUCCESS DN_BOOLEAN)
  AS
    --- declare sql_stmt DN_SQL_STMT;
  begin
    SUCCESS = False;
    
    execute 
    procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :ATABLENAME || ' ALTER COLUMN ' || :AColumn || 
      ' POSITION ' || :APosition);
    
    /* 
      sql_stmt = 'ALTER TABLE ' || :ATABLENAME || ' ALTER COLUMN ' || :AColumn || ' POSITION ' || :APosition; 
      execute statement sql_stmt;
    */
  
    SUCCESS = True;
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_EXTRACT_TABLENAME (
    ATablename DN_DB_OBJECT,
    APrefix DN_PREFIX)
  RETURNS (
    DETERMINED DN_BOOLEAN,
    TABLENAME DN_DB_OBJECT )
  AS
  declare variable idx DN_COUNT;
  declare variable table_name DN_DB_OBJECT;
  declare variable len DN_DIMENSION;
  declare variable pre_fix DN_PREFIX_EXT;
  begin
    DETERMINED = False;
    TABLENAME = ATABLENAME;
  
    /* pr�fe auf normale Tabelle */
    pre_fix = Trim(APrefix) || '_'; 
    idx = position(:pre_fix in :ATablename);
    if (idx <> 1) then
    begin
      /* pr�fe auf Katalog */
      pre_fix = Trim(APrefix) || 'L_';
      idx = position(:pre_fix in :ATablename);
      if (idx <> 1) then
      begin
        /* pr�fe auf Relation */
        pre_fix = Trim(APrefix) || 'R_';
        idx = position(:pre_fix in :ATablename);
        if (idx <> 1) then
        begin
          /* pr�fe Prefix pur */
          pre_fix = Trim(APrefix);
          idx = position(:pre_fix in :ATablename);
        end
        else
          pre_fix = Trim(APrefix); /* Das L in TBL soll im Namen enthalten bleiben */
      end
      else
        pre_fix = Trim(APrefix); /* Das L in TBL soll im Namen enthalten bleiben */
    end
                           
    if (idx = 1) then
    begin
      len = char_length(:pre_fix);                     
      table_name = substring(:ATablename from len+1);
    end  
    else
      table_name = ATablename;
      
    if (Trim(Upper(table_name)) <> Trim(Upper(ATablename))) then
      DETERMINED = True;
      
    if (DETERMINED = True) then
      TABLENAME = table_name;  
      
    suspend;      
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GET_COLUMNLIST(
    ATablename DN_DB_OBJECT,
    ASeparator DN_COLUMNLIST_SEPARATOR,
    ADoCR DN_BOOLEAN)
  returns(
    COLUMNLIST DN_COLUMNLIST)
  as
  declare variable field_name DN_DB_OBJECT;
  begin
    COLUMNLIST = '';
    
    for
    select Trim(RDB$FIELD_NAME)
    from RDB$RELATION_FIELDS 
    where UPPER(RDB$RELATION_NAME)=UPPER(:ATablename)
    order by RDB$FIELD_POSITION   
    into 
      :field_name
    do
    begin
      if (exists(select 1 from RDB$TYPES where RDB$TYPE_NAME=:field_name)) then
        field_name = '"' || :field_name || '"';
    
      if (columnlist <> '') then
      begin
        columnlist = columnlist || :ASEPARATOR || ' ';
        if (:ADoCR = True) then
          columnlist = columnlist || ascii_char(13);
      end  
        
      COLUMNLIST = columnlist || :field_name;  
    end 
    
    suspend; 
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GET_PRIMKEYLIST (
    ATablename DN_DB_OBJECT,
    ASeparator DN_COLUMNLIST_SEPARATOR,
    ADoCR DN_BOOLEAN)
  returns (
    COUNT_PK_FIELDS DN_COUNT,
    COLUMNLIST DN_COLUMNLIST)
  as
  declare variable field_name DN_DB_OBJECT;
  declare variable pk_index_name DN_DB_OBJECT;
  begin
    COUNT_PK_FIELDS = 0;
    COLUMNLIST = '';
    
    select RDB$INDEX_NAME
    from RDB$RELATION_CONSTRAINTS
    where RDB$RELATION_NAME=:ATablename
    and RDB$CONSTRAINT_TYPE='PRIMARY KEY'
    into :pk_index_name;
  
    select count(RDB$FIELD_NAME) 
    from RDB$INDEX_SEGMENTS 
    where UPPER(RDB$INDEX_NAME)=UPPER(:pk_index_name) 
    into :COUNT_PK_FIELDS;
    
    if ((COUNT_PK_FIELDS is null) or (COUNT_PK_FIELDS = 0)) then
    begin
      suspend;
      exit;
    end
    
    for
    select Trim(RDB$FIELD_NAME) 
    from RDB$INDEX_SEGMENTS 
    where UPPER(RDB$INDEX_NAME)=UPPER(:pk_index_name) 
    into :field_name
    do  
    begin
      if (exists(select 1 from RDB$TYPES where RDB$TYPE_NAME=:field_name)) then
        field_name = '"' || :field_name || '"';
    
      if (columnlist <> '') then
      begin
        columnlist = columnlist || :ASeparator || ' ';
        if (:ADoCR = True) then
          columnlist = columnlist || ascii_char(13);
      end  
        
      COLUMNLIST = columnlist || :field_name;  
    end   
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_STD_TABLE_VIEW_CMT (
    ATablename DN_DB_OBJECT,
    AViewname DN_DB_OBJECT)  
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable field_name DN_DB_OBJECT;
  declare variable field_description DN_DB_COMMENT;
  declare variable idx DN_COUNT;
  begin
    field_description = null;
    
    for
    select Trim(RDB$FIELD_NAME),
           cast(Trim(RDB$DESCRIPTION) as VARCHAR(4000))
    from RDB$RELATION_FIELDS 
    where UPPER(RDB$RELATION_NAME)=UPPER(:ATablename)
    order by RDB$FIELD_POSITION   
    into :field_name, :field_description
    do
    begin  
      if (field_description is not null) then
      begin
      
        idx = -1;
        while (idx <> 0) do
        begin
          idx = position('}' in Trim(Upper(:field_description)));
          if (idx > 0) then
            field_description = substring(:field_description from idx+1);
        end   
      
        execute
        procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :AViewname || '.' || :field_name || 
          ' IS ''' || :field_description || '''');
      
        /*
        sql_stmt = 'COMMENT ON COLUMN ' || :AViewname || '.' || :field_name || 
          ' IS ''' || :field_description || '''';
  
        execute statement sql_stmt;
        */
      end  
      
      field_description = null;
    end
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_STD_TABLE_VIEW(
    ATablename DN_DB_OBJECT,
    AOrderByPrim DN_BOOLEAN) /* wenn True dann USER_VIEW nur ReadOnly */
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  declare variable columnlist DN_COLUMNLIST;
  declare variable interfacelist DN_COLUMNLIST;
  declare variable implementationlist DN_COLUMNLIST;
  declare variable pk_columnlist DN_COLUMNLIST;
  declare variable pk_columncount DN_COUNT;
  declare variable table_name DN_DB_OBJECT;
  declare variable determined DN_BOOLEAN;
  begin
    SUCCESS = False;  
  
    determined = False;
    table_name = null;
    
    select DETERMINED, TABLENAME
    from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
    into :determined, :table_name;
        
    if (:AOrderByPrim = True) then
      relation_name = 'VR_' || :table_name;
    else
      relation_name = 'VW_' || :table_name;  
      
    --- sql_stmt = '';
    interfacelist = '';
    implementationlist = '';
  
    select Trim(columnlist) 
    from SP_GET_COLUMNLIST(:ATablename, ',', True) 
    into :columnlist;
    
    if (Trim(columnlist) <> '') then
    begin
      interfacelist = '(' || :columnlist || ')';
      implementationlist = :columnlist; 
    end
    else
    begin
      interfacelist = '';
      implementationlist = '*';   
    end  
    
    /*
    sql_stmt = 'create or alter view ' || :relation_name || :interfacelist || 
      ' as ' || ascii_char(13) || 'select ' || ascii_char(13) || :implementationlist 
      || ascii_char(13) || 'from' || ascii_char(13) || :ATablename;
    */
    
    execute
    procedure PKG_SQL.SP_SET('create or alter view ' || :relation_name || :interfacelist || 
      ' as ' || ascii_char(13) || 'select ' || ascii_char(13) || :implementationlist 
      || ascii_char(13) || 'from' || ascii_char(13) || :ATablename);
    
    if (:AOrderByPrim = True) then
    begin 
      select count_pk_fields, Trim(columnlist) 
      from SP_GET_PRIMKEYLIST(:ATablename, ',', True) 
      into :pk_columncount, :pk_columnlist;
      
      if (pk_columncount > 0) then
        --- sql_stmt = sql_stmt || ' order by ' || :pk_columnlist;
        execute
        procedure PKG_SQL.SP_SET(' order by ' || :pk_columnlist);     
    end
      
    --- execute statement sql_stmt;
    execute
    procedure PKG_SQL.SP_EXECUTE;
    
    /*
    if (:AOrderByPrim = True) then
      sql_stmt = 'COMMENT ON VIEW ' || :relation_name || 
        ' IS ''Standard Readonly-View f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_STD_TABLE_VIEW)''';
    else
      sql_stmt = 'COMMENT ON VIEW ' || :relation_name || 
        ' IS ''Standard Update-View f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_STD_TABLE_VIEW)''';
    */

    if (:AOrderByPrim = True) then
      execute
      procedure PKG_SQL.SP_SET('COMMENT ON VIEW ' || :relation_name || 
        ' IS ''Standard Readonly-View f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_STD_TABLE_VIEW)''');
    else
      execute
      procedure PKG_SQL.SP_SET('COMMENT ON VIEW ' || :relation_name || 
        ' IS ''Standard Update-View f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_STD_TABLE_VIEW)''');

    --- execute statement sql_stmt;
    execute
    procedure PKG_SQL.SP_EXECUTE;
    
    execute
    procedure
      SP_CREATE_STD_TABLE_VIEW_CMT :ATablename,
        :relation_name;
       
    SUCCESS = True; 
      
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_TRIGGER_BI (
    ATablename DN_DB_OBJECT)
  returns (
    SUCCESS DN_BOOLEAN)
  as
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  declare variable sequence_name DN_DB_OBJECT;
  declare variable table_name DN_DB_OBJECT;
  declare variable determined DN_BOOLEAN;
  begin
    SUCCESS = False;
    
    determined = False;
    table_name = null;
    
    select DETERMINED, TABLENAME
    from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
    into :determined, :table_name; 
      
    table_name = Trim(substring(:table_name from 1 for 24));  
    
    relation_name = 'TRG_' || :table_name || '_BI';
    sequence_name = 'SEQ_' || :table_name || '_ID';
    
    if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME=:relation_name)) then
    begin   
      SUCCESS = False;
    end
    else
    begin
      if (exists(select 1 from RDB$GENERATORS where RDB$GENERATOR_NAME=:sequence_name)) then
      begin   
  
    /* Die eigent�mliche Formatierung des DDL-Codes sorgt f�r ein einfach lesbares Format des 
       fertigen Triggercodes in der DB */
    /*    
        sql_stmt = 'CREATE TRIGGER ' || :relation_name || ' FOR ' || :ATablename
                   || ' ACTIVE BEFORE INSERT POSITION 0
  as
  declare variable curr_user DN_DB_OBJECT;
  begin
    if (new.id is null) then
      new.id = next value for ' || :sequence_name || ';
  
    if (new.cre_user is null) then
    begin  
      new.cre_user = PKG_COMMON.SF_GET_CURRENT_USER();
    end  
  end ';       
     */
     
        /* Die eigent�mliche Formatierung des DDL-Codes sorgt f�r ein einfach lesbares Format des 
           fertigen Triggercodes in der DB */
     
        execute
        procedure PKG_SQL.SP_EXECUTE('CREATE TRIGGER ' || :relation_name || ' FOR ' || :ATablename
                   || ' ACTIVE BEFORE INSERT POSITION 0
  as
  declare variable curr_user DN_DB_OBJECT;
  begin
    if (new.id is null) then
      new.id = next value for ' || :sequence_name || ';
  
    if (new.cre_user is null) then
    begin  
      new.cre_user = PKG_COMMON.SF_GET_CURRENT_USER();
    end  
  end ');
        
        --- execute statement sql_stmt;
           
        /*   
        sql_stmt = 'COMMENT ON TRIGGER ' || :relation_name || 
          ' IS ''Before-Insert-Trigger f�r die Tabelle ' || :ATablename || 
          ' (created by SP_CREATE_TRIGGER_BI)''';
        */  
          
        --- execute statement sql_stmt;
        
        execute
        procedure PKG_SQL.SP_EXECUTE('COMMENT ON TRIGGER ' || :relation_name || 
          ' IS ''Before-Insert-Trigger f�r die Tabelle ' || :ATablename || 
          ' (created by SP_CREATE_TRIGGER_BI)''');
          
        SUCCESS = True;
      end
      else
        SUCCESS = False; 
    end
      
    suspend;
  end    
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_TRIGGER_BU (
    ATablename DN_DB_OBJECT)
  returns (
    SUCCESS DN_BOOLEAN)
  as
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  declare variable determined DN_BOOLEAN;
  declare variable table_name DN_DB_OBJECT;
  begin
    SUCCESS = False;
    
    determined = False;
    table_name = null;
    
    select DETERMINED, TABLENAME
    from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
    into :determined, :table_name; 
    
    table_name = Trim(substring(:table_name from 1 for 24));  
    relation_name = 'TRG_' || :table_name || '_BU';
    
    if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME=:relation_name)) then
    begin   
      SUCCESS = False;
    end
    else
    begin
  
  /* Die eigent�mliche Formatierung des DDL-Codes sorgt f�r ein einfach lesbares Format des 
     fertigen Triggercodes in der DB */
  /*   
      sql_stmt = 'CREATE TRIGGER ' || :relation_name || ' FOR ' || :ATablename
                 || ' ACTIVE BEFORE UPDATE POSITION 0
  as
  declare variable curr_user DN_DB_OBJECT;
  begin
    new.chg_user = PKG_COMMON.SF_GET_CURRENT_USER();
    new.chg_date = current_timestamp;
  end ';
  */
  ---    execute statement sql_stmt;
      
    /* Die eigent�mliche Formatierung des DDL-Codes sorgt f�r ein einfach lesbares Format des 
       fertigen Triggercodes in der DB */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('CREATE TRIGGER ' || :relation_name || ' FOR ' || :ATablename
                 || ' ACTIVE BEFORE UPDATE POSITION 0
  as
  declare variable curr_user DN_DB_OBJECT;
  begin
    new.chg_user = PKG_COMMON.SF_GET_CURRENT_USER();
    new.chg_date = current_timestamp;
  end ');
      
      /*   
      sql_stmt = 'COMMENT ON TRIGGER ' || :relation_name || 
        ' IS ''Before-Update-Trigger f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_TRIGGER_BU)''';
        
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON TRIGGER ' || :relation_name || 
        ' IS ''Before-Update-Trigger f�r die Tabelle ' || :ATablename || 
        ' (created by SP_CREATE_TRIGGER_BU)''');      
        
      SUCCESS = True;  
    end
      
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_SEQUNECE(
    ATablename DN_DB_OBJECT,
    AFieldname DN_DB_OBJECT Default 'ID',
    AComment DN_COMMENT Default '')
  RETURNS (
    SUCCESS DN_BOOLEAN)    
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  declare variable table_name DN_DB_OBJECT;
  declare variable determined DN_BOOLEAN;
  begin
    SUCCESS = False;
  
    determined = False;
    table_name = null;
    
    select DETERMINED, TABLENAME
    from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
    into :determined, :table_name; 
      
    table_name = Trim(substring(:table_name from 1 for 24));  
    
    relation_name = 'SEQ_' || :table_name || '_' || :AFieldname;
      
    if (exists(select 1 from RDB$GENERATORS where RDB$GENERATOR_NAME=:relation_name)) then
    begin   
      SUCCESS = False;
    end
    else
    begin
      /*
      sql_stmt = 'CREATE SEQUENCE ' || :relation_name;  
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('CREATE SEQUENCE ' || :relation_name);
      
      /*
      sql_stmt = 'ALTER SEQUENCE ' || :relation_name || ' RESTART WITH 0';
      execute statement sql_stmt;
      */

      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER SEQUENCE ' || :relation_name || ' RESTART WITH 0');
      
      /*
      if (Trim(AComment) = '') then
        sql_stmt = 'COMMENT ON SEQUENCE ' || :relation_name || 
          ' IS ''Sequence f�r das Feld ' || :AFieldname || ' der Tabelle ' || :ATablename || 
          ' (created by SP_CREATE_SEQUNECE)''';
      else
        sql_stmt = 'COMMENT ON SEQUENCE ' || :relation_name || 
          ' IS ''' || :AComment || 
          ' (created by SP_CREATE_SEQUNECE)''';     
    
      execute statement sql_stmt;
      */
      
      if (Trim(AComment) = '') then
        execute
        procedure PKG_SQL.SP_SET('COMMENT ON SEQUENCE ' || :relation_name || 
          ' IS ''Sequence f�r das Feld ' || :AFieldname || ' der Tabelle ' || :ATablename || 
          ' (created by SP_CREATE_SEQUNECE)''');
      else
        execute
        procedure PKG_SQL.SP_SET('COMMENT ON SEQUENCE ' || :relation_name || 
          ' IS ''' || :AComment || 
          ' (created by SP_CREATE_SEQUNECE)''');
          
      execute
      procedure PKG_SQL.SP_EXECUTE;         
        
      SUCCESS = True;  
    end
      
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_TBL_CATALOG (
    ATablename DN_DB_OBJECT,
    ADomain DN_DB_OBJECT DEFAULT 'DN_CAPTION',
    AComment DN_COMMENT DEFAULT '', 
    ACreateUniqueKey DN_BOOLEAN DEFAULT True)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    CATALOGNAME DN_DB_OBJECT,
    TABLENAME DN_DB_OBJECT)
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  declare variable cat_comment DN_COMMENT;
  declare variable cat_name DN_DB_OBJECT;
  BEGIN
    SUCCESS = False;
    CATALOGNAME = null;
    TABLENAME = null;
    
    /*cat_name = 'CAT_' || Upper(ATablename); 
    relation_name = 'TB_' || Upper(cat_name);*/
    cat_name = 'L_' || Upper(ATablename); 
    relation_name = 'TB' || Upper(cat_name);
    cat_comment = AComment;
  
    if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME=:relation_name)) then
    begin
      SUCCESS = False;
    end
    else
    begin
      /*
      sql_stmt = 'CREATE TABLE ' || :relation_name || ' (
      ID  DN_IDENTIFICATION,
      CAPTION ' || :ADomain || ',
      DESCRIPTION DN_DESCRIPTION,
      CRE_USER DN_FIREBIRD_USER,
      CRE_DATE DN_CURRENT_TIMESTAMP,
      CHG_USER DN_FIREBIRD_USER,
      CHG_DATE DN_TIMESTAMP
  )';
      execute statement sql_stmt;
      */     
      execute
      procedure PKG_SQL.SP_EXECUTE('CREATE TABLE ' || :relation_name || ' (
      ID  DN_IDENTIFICATION,
      CAPTION ' || :ADomain || ',
      DESCRIPTION DN_DESCRIPTION,
      CRE_USER DN_FIREBIRD_USER,
      CRE_DATE DN_CURRENT_TIMESTAMP,
      CHG_USER DN_FIREBIRD_USER,
      CHG_DATE DN_TIMESTAMP
  )');
      
      /*
      sql_stmt = 'COMMENT ON TABLE ' || :relation_name || ' IS ''Katalog: ' || :relation_name || 
        ' f�r ' || :cat_comment || ' (created by SP_CREATE_TBL_CATALOG)''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON TABLE ' || :relation_name || ' IS ''Katalog: ' || :relation_name || 
        ' f�r ' || :cat_comment || ' (created by SP_CREATE_TBL_CATALOG)''');

      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.ID IS ''Prim�rschl�ssel''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.ID IS ''Prim�rschl�ssel''');

      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CAPTION IS ''Bezeichnung''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CAPTION IS ''Bezeichnung''');

      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.DESCRIPTION IS ''Beschreibung''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.DESCRIPTION IS ''Beschreibung''');
      
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CRE_USER IS ''Erstellt von''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CRE_USER IS ''Erstellt von''');
 
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CRE_DATE IS ''Erstellt am''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CRE_DATE IS ''Erstellt am''');
  
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CHG_USER IS ''Ge�ndert von''';
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CHG_USER IS ''Ge�ndert von''');
      
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CHG_DATE IS ''Ge�ndert am''';    
      execute statement sql_stmt;
      */    
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CHG_DATE IS ''Ge�ndert am''');
      
      /*      
      sql_stmt = 'ALTER TABLE ' || :relation_name || ' ADD CONSTRAINT PK_' || :cat_name ||
        ' PRIMARY KEY (ID)';      
      execute statement sql_stmt;
      */
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :relation_name || ' ADD CONSTRAINT PK_' || :cat_name ||
        ' PRIMARY KEY (ID)');
      
      if (:ACreateUniqueKey = True) then
      begin
        /*
        sql_stmt = 'ALTER TABLE ' || :relation_name || ' ADD CONSTRAINT ALT_' || :cat_name || 
          ' UNIQUE (CAPTION) USING INDEX ALT_IDX_' || :cat_name;
        execute statement sql_stmt;
        */
        execute
        procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :relation_name || ' ADD CONSTRAINT ALT_' || :cat_name || 
          ' UNIQUE (CAPTION) USING INDEX ALT_IDX_' || :cat_name);        
      end    
      else
      begin
        /*
        sql_stmt = 'CREATE UNIQUE INDEX ALT_' || :cat_name || ' ON ' || :relation_name || 
          '(CAPTION)';        
        execute statement sql_stmt;
        */
        execute
        procedure PKG_SQL.SP_EXECUTE('CREATE UNIQUE INDEX ALT_' || :cat_name || ' ON ' || :relation_name || 
          '(CAPTION)');

        /*
        sql_stmt = 'COMMENT ON INDEX ALT_' || :cat_name || ' IS ''(created by SP_CREATE_TBL_CATALOG)''';    
        execute statement sql_stmt;
        */
        execute
        procedure PKG_SQL.SP_EXECUTE('COMMENT ON INDEX ALT_' || :cat_name || ' IS ''(created by SP_CREATE_TBL_CATALOG)''');                    
      end  
           
      CATALOGNAME = cat_name;
      TABLENAME = relation_name;     
                 
      SUCCESS = True;  
    end      
  
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_CATALOG (
    ACatalogname DN_DB_OBJECT,
    ADomain DN_DB_OBJECT,
    AComment DN_COMMENT)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable relation_name DN_DB_OBJECT;
  declare variable cat_comment DN_COMMENT;
  declare variable domain_name DN_DB_OBJECT;
  declare variable cat_name DN_DB_OBJECT;
  declare variable table_name DN_DB_OBJECT;
  BEGIN
    SUCCESS = False;
    cat_name = null;
    table_name = null;
    
    relation_name = Upper(ACatalogname);
    cat_comment = AComment;  
    domain_name = ADomain;
  
    /* Katalog anlegen */
    select SUCCESS, CATALOGNAME, TABLENAME 
    from SP_CREATE_TBL_CATALOG(:relation_name, :domain_name, :cat_comment, True) 
    into :SUCCESS, :cat_name, :table_name; 
   
    /* Standardview anlegen */
    if (SUCCESS = True) then
      select SUCCESS 
      from SP_CREATE_STD_TABLE_VIEW(:table_name, False) 
      into :SUCCESS;
    
    /* Sequence anlegen */
    if (SUCCESS = True) then
      select SUCCESS 
      from SP_CREATE_SEQUNECE(:table_name) 
      into :SUCCESS;
     
    /* Trigger anlegen */
    if (SUCCESS = True) then
      select SUCCESS 
      from SP_CREATE_TRIGGER_BI(:table_name) 
      into :SUCCESS;
    
    if (SUCCESS = True) then
      select SUCCESS 
      from SP_CREATE_TRIGGER_BU(:table_name) 
      into :SUCCESS;
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_STAMP (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable relation_name DN_DB_OBJECT;
  --- declare variable sql_stmt DN_SQL_STMT;
  begin
    SUCCESS = False;
    
    relation_name = ATablename;
  
    if (exists(select 1 
               from RDB$RELATION_FIELDS 
               where RDB$FIELD_NAME='CRE_USER' and RDB$RELATION_NAME=:relation_name)) 
    then
    begin
      SUCCESS = False;
    end
    else
    begin
      /*
      sql_stmt = 
        'ALTER TABLE ' || :relation_name || ' ADD CRE_USER DN_FIREBIRD_USER, ADD CRE_DATE DN_CURRENT_TIMESTAMP, ' ||
        'ADD CHG_USER DN_FIREBIRD_USER, ADD CHG_DATE DN_TIMESTAMP';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :relation_name || ' ADD CRE_USER DN_FIREBIRD_USER, ADD CRE_DATE DN_CURRENT_TIMESTAMP, ' ||
        'ADD CHG_USER DN_FIREBIRD_USER, ADD CHG_DATE DN_TIMESTAMP');
      
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CRE_USER IS ''Erstellt von''';
      execute statement sql_stmt;
      */

      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CRE_USER IS ''Erstellt von''');
  
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CRE_DATE IS ''Erstellt am''';
      execute statement sql_stmt;
      */

      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CRE_DATE IS ''Erstellt am''');
  
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CHG_USER IS ''Ge�ndert von''';
      execute statement sql_stmt;
      */

      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CHG_USER IS ''Ge�ndert von''');
  
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.CHG_DATE IS ''Ge�ndert am''';    
      execute statement sql_stmt;
      */    

      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.CHG_DATE IS ''Ge�ndert am''');
            
      SUCCESS = True;  
    end      
  
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_FIELD_DESCRIPTION (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable relation_name DN_DB_OBJECT;
  --- declare variable sql_stmt DN_SQL_STMT;
  begin
    SUCCESS = False;
    
    relation_name = ATablename;
  
    if (exists(select 1 
               from RDB$RELATION_FIELDS 
               where RDB$FIELD_NAME='DESCRIPTION' and RDB$RELATION_NAME=:relation_name)) 
    then
    begin
      SUCCESS = False;
    end
    else
    begin
      /*
      sql_stmt = 'ALTER TABLE ' || :relation_name || ' ADD DESCRIPTION DN_DESCRIPTION';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :relation_name || ' ADD DESCRIPTION DN_DESCRIPTION');
      
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :relation_name || '.DESCRIPTION IS ''Beschreibung''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :relation_name || '.DESCRIPTION IS ''Beschreibung''');      
  
      SUCCESS = True;  
    end      
  
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_TABLE_COMMENT (
    ATablename DN_DB_OBJECT,
    AComment DN_COMMENT)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable relation_name DN_DB_OBJECT;
  --- declare variable sql_stmt DN_SQL_STMT;
  begin
    SUCCESS = False;
    
    relation_name = ATablename;
  
    if (not exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME=:relation_name)) then
    begin
      SUCCESS = False;
    end
    else
    begin
      /*
      sql_stmt = 'COMMENT ON TABLE ' || :relation_name || ' IS ''' || :AComment || '''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON TABLE ' || :relation_name || ' IS ''' || :AComment || '''');
  
      SUCCESS = True;  
    end      
  
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_PRIMARY_CONSTRAINT (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable relation_name DN_DB_OBJECT;
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable determined DN_BOOLEAN;
  begin
    SUCCESS = False;
    
    if (not exists(select 1 
                   from RDB$RELATION_FIELDS 
                   where RDB$FIELD_NAME='ID' and RDB$RELATION_NAME=:ATablename)) 
    then
    begin
      SUCCESS = False;
    end
    else
    begin
      determined = False;
      relation_name = null;
  
      select DETERMINED, TABLENAME
      from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
      into :determined, :relation_name;
        
      if (:determined = False) then
        relation_name = ATablename;    
    
      /*
      sql_stmt = 'ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT PK_' || :relation_name ||
        ' PRIMARY KEY (ID)';      
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT PK_' || :relation_name ||
        ' PRIMARY KEY (ID)');
      
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :ATablename || '.ID IS ''Prim�rschl�ssel''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :ATablename || '.ID IS ''Prim�rschl�ssel''');      
      
      SUCCESS = True;  
    end      
  
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_COMPLETE_TABLE (
    ATablename DN_DB_OBJECT,
    ADoDescription DN_BOOLEAN,
    ADoStamp DN_BOOLEAN,
    ADoComment DN_BOOLEAN,
    AComment DN_COMMENT, 
    ADoPK DN_BOOLEAN)
  RETURNS (
    SUCCESS DN_BOOLEAN)  
  AS
  declare variable table_name DN_DB_OBJECT;
  begin
    SUCCESS = False;
    
    table_name = ATablename;
    
    /* Beschreibung anlegen */
    if (:ADoDescription = True) then
    begin
      select SUCCESS
      from SP_CREATE_FIELD_DESCRIPTION(:table_name)
      into :SUCCESS;
        
      if (SUCCESS = False) then
      begin
        suspend;
        exit;
      end  
     end   
    
    /* Stempel anlegen */
    if (:ADoStamp = True) then
    begin
      select SUCCESS
      from SP_CREATE_STAMP(:table_name) 
      into :SUCCESS;
        
      if (SUCCESS = False) then
      begin
        suspend;
        exit;
      end      
    end      
      
    /* Kommentar anlegen */    
    if ((:ADoComment = True) and (Trim(AComment) <> '')) then
    begin
      select SUCCESS
      from SP_CREATE_TABLE_COMMENT(:table_name, :AComment)
      into :SUCCESS;
        
      if (SUCCESS = False) then
      begin
        suspend;
        exit;
      end      
    end      
        
    /* Prim�rschl�ssel anlegen */
    if (:ADoPK = True) then
    begin
      select SUCCESS
      from SP_CREATE_PRIMARY_CONSTRAINT(:table_name)
      into :SUCCESS;
  
      if (SUCCESS = False) then
      begin
        suspend;
        exit;
      end      
    end          
    
    /* Standardview anlegen */
    if (SUCCESS = True) then
      select SUCCESS 
      from SP_CREATE_STD_TABLE_VIEW(:table_name, False) 
      into :SUCCESS;
    
    /* Sequence anlegen */
    if ((SUCCESS = True) and (:ADoPK = True)) then
      select SUCCESS 
      from SP_CREATE_SEQUNECE(:table_name) 
      into :SUCCESS;
     
    /* Trigger anlegen */
    if ((SUCCESS = True) and (:ADoPK = True)) then
      select SUCCESS 
      from SP_CREATE_TRIGGER_BI(:table_name) 
      into :SUCCESS;
    
    if ((SUCCESS = True) and (:ADoStamp = True)) then  
      select SUCCESS 
      from SP_CREATE_TRIGGER_BU(:table_name) 
      into :SUCCESS;
    
    suspend; 
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CHECK_COMMAND (
    AGenCommand DN_SDDL_COMMAND,
    AFieldDescription DN_DB_COMMENT)
  RETURNS (
    DETERMINED DN_BOOLEAN,
    FIELDDESCRIPTION DN_DB_COMMENT,
    TABLENAME DN_DB_OBJECT,
    FIELDNAME DN_DB_OBJECT,
    REQUIRED DN_SQL_STMT)
  AS
  declare variable gen_command DN_SDDL_COMMAND;
  declare variable idx DN_COUNT;
  declare variable idx2 DN_COUNT;
  declare variable idx3 DN_COUNT;
  declare variable idx4 DN_COUNT;
  declare variable idx5 DN_COUNT;
  declare variable len DN_DIMENSION;
  declare variable field_description DN_DB_COMMENT;
  declare variable field_name DN_SDDL_COMMAND;
  begin
    DETERMINED = False;
    FIELDDESCRIPTION = AFieldDescription;
    TABLENAME = null;
    FIELDNAME = null;
    REQUIRED = null;  
    
    gen_command = AGenCommand;
    field_description = AFieldDescription;
    
    /*--------------------------------------------------------------------------------------------*/
    gen_command = '{UNIQUE.KEY}';
    if (gen_command = Trim(Upper(AGenCommand))) then
    begin
      idx = position(:gen_command in Trim(Upper(:field_description)));
      if (idx = 1) then
       begin
         len = char_length(:gen_command);
         FIELDDESCRIPTION = substring(:field_description from len+1);
         
         if (Trim(FIELDDESCRIPTION) = '') then
           FIELDDESCRIPTION = 'Alternativer Prim�rschl�ssel';
         
         DETERMINED = True;
         
         suspend;
         exit;
       end  
    end
    
    /*--------------------------------------------------------------------------------------------*/
    gen_command = '{UNIQUE.IDX}';
    if (gen_command = Trim(Upper(AGenCommand))) then
    begin
      idx = position(:gen_command in Trim(Upper(:field_description)));
      if (idx = 1) then
       begin
         len = char_length(:gen_command);
         FIELDDESCRIPTION = substring(:field_description from len+1);
         
         if (Trim(FIELDDESCRIPTION) = '') then
           FIELDDESCRIPTION = 'Quelle f�r einen eindeutigen Einspalten-Index';
         
         DETERMINED = True;
         
         suspend;
         exit;
       end  
    end   
    
    /*--------------------------------------------------------------------------------------------*/
    gen_command = '{FK:=';
    if (gen_command = Trim(Upper(AGenCommand))) then
    begin
      idx = position(:gen_command in Trim(Upper(:field_description)));
      if (idx = 1) then
       begin
         idx2 = position('}' in Trim(Upper(:field_description)));     
          
         if (idx2 > 0) then 
         begin 
           gen_command = substring(field_description from 1 for idx2);
              
           len = char_length(:gen_command);
           FIELDDESCRIPTION = substring(:field_description from len+1);
           
           idx3 = position('=' in gen_command);
           
           if (idx3 = 5) then 
           begin 
             field_name = substring(gen_command from idx3+1 for (idx2-(idx3+1)));
             
             idx4 = position('.' in field_name);
             idx5 = position(';' in field_name);
             if (idx5 > 0) then
             begin
               len = char_length(:field_name);
               
               REQUIRED = Upper(Trim(substring(:field_name from idx5+1 for len)));
               field_name = substring(:field_name from 1 for idx5-1);
             end
             else
               REQUIRED = 'DCUC';
             
             len = char_length(:field_name);
             
             FIELDNAME = substring(:field_name from idx4+1 for len);
             TABLENAME = substring(:field_name from 1 for idx4-1);
           
             if (Trim(FIELDDESCRIPTION) = '') then
               FIELDDESCRIPTION = 'Fremdschl�ssel der Tabelle ' || TABLENAME;
           
             DETERMINED = True;
          
             suspend;
             exit;                  
           end        
         end
       end  
    end
    
    /*--------------------------------------------------------------------------------------------*/
    --gen_command = '{REL:='; 
    
    /*--------------------------------------------------------------------------------------------*/
    --gen_command = '{CAT:=';
    
    suspend;     
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_UNIQUE_KEY(
    ATablename DN_DB_OBJECT,
    AFieldname DN_DB_OBJECT,
    AFieldDescription DN_DB_COMMENT)
  RETURNS (  
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare variable determined DN_BOOLEAN;
  declare variable table_name DN_DB_OBJECT;
  declare variable index_name DN_DB_OBJECT;
  declare variable index_name_fix DN_SDDL_COMMAND;
  declare variable constraint_name DN_DB_OBJECT;
  declare variable constraint_name_fix DN_SDDL_COMMAND;
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable counter DN_COUNT;
  begin
    SUCCESS = False;
    LOG_MESSAGE = null; 
  
    /* Ist auf dem Feld schon ein Unique Constraint vorhanden? */
    if (not exists(select 1
                   from RDB$RELATION_CONSTRAINTS a, RDB$INDEX_SEGMENTS b
                   where a.RDB$RELATION_NAME=:ATablename
                   and b.RDB$FIELD_NAME=:AFieldname  
                   and a.RDB$CONSTRAINT_TYPE = 'UNIQUE'
                   and b.RDB$INDEX_NAME=a.RDB$INDEX_NAME))
    then
    begin
  
      determined = False;
      table_name = null;
      
      select DETERMINED, TABLENAME
      from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
      into :determined, :table_name;
        
      if (:determined = False) then
        table_name = ATablename;  
        
      /* Eindeutigen Unique-Constraint-Namen finden */  
      constraint_name_fix = 'ALT_' || :table_name;    
      constraint_name = Trim(substring(constraint_name_fix from 1 for 31));
      counter = 0;
      while (exists(select 1 
                    from RDB$RELATION_CONSTRAINTS 
                    where RDB$CONSTRAINT_NAME =:constraint_name)) 
      do
      begin
        counter = counter + 1;        
        constraint_name = Trim(substring(constraint_name_fix from 1 for 30)) || 
          Trim(CAST(counter AS varchar(4)));
      end
      
      /* Eindeutigen Index-Namen finden */
      index_name_fix = 'ALT_IDX_' || :table_name;   
      index_name = Trim(substring(index_name_fix from 1 for 31));    
      counter = 0;
      while (exists(select 1 
                    from RDB$INDEX_SEGMENTS 
                    where RDB$INDEX_NAME =:index_name)) 
      do
      begin
        counter = counter + 1;  
        index_name = Trim(substring(index_name_fix from 1 for 30)) || 
          Trim(CAST(counter AS varchar(4)));      
      end    
      
      /*
      sql_stmt = 'ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT ' || :constraint_name || 
        ' UNIQUE (' || :AFieldname ||') USING INDEX ' || :index_name;         
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT ' || :constraint_name || 
        ' UNIQUE (' || :AFieldname ||') USING INDEX ' || :index_name);
        
      /*                                                                         
      sql_stmt = 'COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
        :AFieldDescription || '''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
        :AFieldDescription || '''');          
      
      SUCCESS = True;
      LOG_MESSAGE = 'Ok';
    end
    begin
      SUCCESS = True;
      LOG_MESSAGE = 'Ein Unique Constraint f�r Tabelle ' || Trim(:ATablename) || ' f�r die Spalte ' || 
        Trim(:AFieldname) || ' ist schon vorhanden';
    end
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_UNIQUE_IDX(
    ATablename DN_DB_OBJECT,
    AFieldname DN_DB_OBJECT,
    AFieldDescription DN_DB_COMMENT)
  RETURNS (  
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare variable determined DN_BOOLEAN;
  declare variable table_name DN_DB_OBJECT;
  declare variable index_name DN_DB_OBJECT;
  declare variable index_name_fix DN_SDDL_COMMAND;
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable counter DN_COUNT;
  begin
    SUCCESS = False;
    LOG_MESSAGE = null; 
    
    /* Ist auf dem Feld schon ein eindeutiger Einspalten-Index vorhanden? */
    if (not exists(select 1 
                   from RDB$RELATION_FIELDS a
                        join RDB$INDICES b on (a.RDB$RELATION_NAME=b.RDB$RELATION_NAME)
                        join RDB$INDEX_SEGMENTS c on (b.RDB$INDEX_NAME=c.RDB$INDEX_NAME)
                   where (a.RDB$SYSTEM_FLAG=0
                         and a.RDB$FIELD_NAME=:ATablename
                         and a.RDB$RELATION_NAME=:AFieldname) 
                   and (b.RDB$SYSTEM_FLAG=0
                        and b.RDB$UNIQUE_FLAG=1
                        and b.RDB$SEGMENT_COUNT=1)  
                   and (c.RDB$FIELD_NAME=a.RDB$FIELD_NAME)))
    then
    begin  
      determined = False;
      table_name = null;
      select
        DETERMINED,
        TABLENAME
      from
        SP_EXTRACT_TABLENAME(:ATablename,
          'TB')
      into
        :determined,
        :table_name;
        
      if (:determined = False) then
        table_name = ATablename;  
          
      /* Eindeutigen Index-Namen finden */
      index_name_fix = 'UNQ_IDX_' || :table_name;   
      index_name = Trim(substring(index_name_fix from 1 for 31));    
      counter = 0;
      while (exists(select 1 
                    from RDB$INDEX_SEGMENTS 
                    where RDB$INDEX_NAME =:index_name)) 
      do
      begin
        counter = counter + 1;  
        index_name = Trim(substring(index_name_fix from 1 for 30)) || 
          Trim(CAST(counter AS varchar(4)));      
      end    
      
      /*
      sql_stmt = 'CREATE UNIQUE INDEX ' || :index_name || ' ON ' || :ATablename || ' ('|| :AFieldname || ')' ;   
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('CREATE UNIQUE INDEX ' || :index_name || ' ON ' || :ATablename || ' ('|| :AFieldname || ')');
        
      /*                                                                         
      sql_stmt = 'COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
        :AFieldDescription || '''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
        :AFieldDescription || '''');          
      
      SUCCESS = True;
      LOG_MESSAGE = 'Ok';
    end
    begin
      SUCCESS = True;
      LOG_MESSAGE = 'Ein eindeutiger Einspalten-Index f�r Tabelle ' || Trim(:ATablename) || ' f�r die Spalte ' || 
        Trim(:AFieldname) || ' ist schon vorhanden';
    end
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_FOREIGN_KEY(
    ATablename DN_DB_OBJECT,
    AFieldname DN_DB_OBJECT,
    AFieldDescription DN_DB_COMMENT,
    AFKTablename DN_DB_OBJECT,
    AFKFieldname DN_DB_OBJECT,
    ACondition DN_SQL_STMT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare variable constraint_name DN_DB_OBJECT;
  declare variable constraint_name_fix DN_SDDL_COMMAND;
  declare variable table_name DN_DB_OBJECT;
  declare variable fk_table_name DN_DB_OBJECT;
  declare variable short_relation_name DN_DB_OBJECT;
  declare variable counter DN_COUNT;
  declare variable determined DN_BOOLEAN;
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable fk_condition DN_SQL_STMT;
  begin
    SUCCESS = False;
    LOG_MESSAGE = null;
    
    /* Ist auf dem Feld schon ein Unique Constraint vorhanden? */  
    if (not exists(select 1
                   from RDB$RELATION_CONSTRAINTS a, RDB$INDEX_SEGMENTS b
                   where a.RDB$RELATION_NAME=:ATablename
                   and b.RDB$FIELD_NAME=:AFieldname  
                   and a.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
                   and b.RDB$INDEX_NAME=a.RDB$INDEX_NAME))
    then
    begin      
      determined = False;
      table_name = null;
      
      select DETERMINED, TABLENAME
      from SP_EXTRACT_TABLENAME(:ATablename, 'TB')
      into :determined, :table_name;
        
      if (:determined = False) then
        table_name = ATablename;  
    
      determined = False;
      fk_table_name = null;
      
      select DETERMINED, TABLENAME
      from SP_EXTRACT_TABLENAME(:AFKTablename, 'TB')
      into :determined, :fk_table_name;
        
      if (:determined = False) then
        fk_table_name = AFKTablename;    
      
      /* Existiert ein Prim�r- bzw. Unique-Key auf der engegebenen Spalte? */
      if (not exists(select 1
                     from RDB$RELATION_CONSTRAINTS a, RDB$INDEX_SEGMENTS b
                     where a.RDB$RELATION_NAME=:AFKTablename
                     and b.RDB$FIELD_NAME=:AFKFieldname  
                     and a.RDB$CONSTRAINT_TYPE in ('UNIQUE', 'PRIMARY KEY')
                     and b.RDB$INDEX_NAME=a.RDB$INDEX_NAME))
      then
      begin
        /* Wenn nicht, dann alle Constraints der Zieltabelle zuerst anlegen */
        for
        select SUCCESS, LOG_MESSAGE
        from SP_CREATE_CONSTRAINTS(:AFKTablename)
        into :SUCCESS, :LOG_MESSAGE
        do
        begin
          /* 
             Pr�fen ob bei SUCCESS=FALSE abgebrochen werden soll. s. folgende Zeilen 
             Pr�fung: Da es vorkommen kann das die SP_CREATE_CONSTRAINTS kein Resultset zur�ck liefert,
                      ist es nicht sinnvoll inherhalb des begin-end Blockes SUCCESS auf False abzugragen
          */           
        end
          
        if (SUCCESS = False) then
        begin
          LOG_MESSAGE = 'F�r die Tabelle ' || Trim(:AFKTablename) || ' konnte kein Constraint mit der Spalte ' || 
            Trim(:AFKFieldname) || ' angelegt werden';
            
          suspend;  
          exit;
        end
      end
                                    
      short_relation_name = Upper(substring(table_name from 1 for 1) || substring(fk_table_name from 1 for 1));
    
      /* Eindeutigen Foreign-Constraint-Namen finden */
      constraint_name_fix = 'FK_' || :short_relation_name || '_' || table_name;
      constraint_name = Trim(substring(constraint_name_fix from 1 for 31));  
      counter = 0;
      
      while (exists(select 1 from RDB$RELATION_CONSTRAINTS where RDB$CONSTRAINT_NAME =:constraint_name)) do
      begin
        counter = counter + 1;  
        constraint_name = Trim(substring(constraint_name_fix from 1 for 30)) || 
          Trim(CAST(counter AS varchar(4)));
      end
    
      ACondition = Upper(Trim(ACondition));
    
      if (ACondition = 'DCUC') then
        fk_condition = 'DELETE CASCADE ON UPDATE CASCADE';
      else        
      if (ACondition = 'DNUC') then
        fk_condition = 'DELETE SET NULL ON UPDATE CASCADE';
      else
      if (ACondition = 'DCUN') then
        fk_condition = 'DELETE CASCADE ON UPDATE SET NULL';
      else
      if (ACondition = 'DNUN') then
        fk_condition = 'DELETE SET NULL ON UPDATE SET NULL';
      else  
        fk_condition = 'DELETE CASCADE ON UPDATE CASCADE';
    
      /*
      sql_stmt = 'ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT ' || :constraint_name || 
        ' FOREIGN KEY (' || :AFieldname || ') REFERENCES ' || :AFKTablename || ' (' || :AFKFieldname || 
        ') ON ' || :fk_condition; ---||DELETE SET NULL ON UPDATE CASCADE';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('ALTER TABLE ' || :ATablename || ' ADD CONSTRAINT ' || :constraint_name || 
        ' FOREIGN KEY (' || :AFieldname || ') REFERENCES ' || :AFKTablename || ' (' || :AFKFieldname || 
        ') ON ' || :fk_condition);
    
      /*
      sql_stmt = 'COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
          :AFieldDescription || '''';
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('COMMENT ON COLUMN ' || :ATablename || '.' || :AFieldname || ' IS ''' || 
          :AFieldDescription || '''');
      
      SUCCESS = True;
      LOG_MESSAGE = 'Ok';
    end
    else
    begin
      SUCCESS = True;
      LOG_MESSAGE = 'Ein Foregin Constraint f�r Tabelle ' || Trim(:ATablename) || ' f�r die Spalte ' || 
        Trim(:AFieldname) || ' ist schon vorhanden';
    end
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_CONSTRAINTS (
    ATablename DN_DB_OBJECT)
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare table_name DN_DB_OBJECT;
  declare field_description DN_DB_COMMENT;
  declare field_name DN_DB_OBJECT;
  declare gen_command DN_SDDL_COMMAND;
  declare idx DN_COUNT;
  declare len DN_DIMENSION;
  declare fk_table_name DN_DB_OBJECT;
  declare fk_field_name DN_DB_OBJECT;
  declare found_command_unique_key DN_BOOLEAN;
  declare found_command_foreign_key DN_BOOLEAN;
  declare found_command_unique_idx DN_BOOLEAN;
  declare found_command_relation DN_BOOLEAN;
  declare found_command_catalog DN_BOOLEAN;
  declare first_try DN_BOOLEAN;
  declare fk_condition DN_SQL_STMT;
  begin
    SUCCESS = False;
    LOG_MESSAGE = null;
    
    table_name = ATablename;
    
    if (exists(select 1 from RDB$RELATIONS where RDB$RELATION_NAME=:ATablename)) then
    begin
      for
      select Trim(RDB$FIELD_NAME), cast(Trim(RDB$DESCRIPTION) as VARCHAR(4000))
      from RDB$RELATION_FIELDS 
      where UPPER(RDB$RELATION_NAME)=UPPER(:ATablename)
      order by RDB$FIELD_POSITION   
      into :field_name, :field_description
      do
      begin
        SUCCESS = False;
        LOG_MESSAGE = null;
        first_try = True;
        found_command_foreign_key = False;
        found_command_unique_key = False;
        found_command_relation = False;
        found_command_catalog = False;
        
        while ((found_command_foreign_key <> False) or 
               (found_command_unique_key <> False) or
               (found_command_relation <> False) or
               (found_command_catalog <> False) or                
               (:first_try = True)) 
        do
        begin
          first_try = False;
             
          /*--------------------------------------------------------------------------------------*/
          gen_command = '{UNIQUE.KEY}';
          
          found_command_unique_key = False;
          fk_table_name = null;
          fk_field_name = null;
          
          select DETERMINED, FIELDDESCRIPTION, TABLENAME, FIELDNAME
          from SP_CHECK_COMMAND (:gen_command, :field_description)
          into :found_command_unique_key, :field_description, :fk_table_name, :fk_field_name;
    
          if (:found_command_unique_key = True) then
          begin         
            select SUCCESS, LOG_MESSAGE
            from SP_CREATE_UNIQUE_KEY(:table_name, :field_name, :field_description)
            into :SUCCESS, :LOG_MESSAGE;
            
            SUSPEND;
          end
          
          /*--------------------------------------------------------------------------------------*/          
          gen_command = '{UNIQUE.IDX}';
          
          found_command_unique_idx = False;
          fk_table_name = null;
          fk_field_name = null;
          
          select DETERMINED, FIELDDESCRIPTION, TABLENAME, FIELDNAME
          from SP_CHECK_COMMAND (:gen_command, :field_description)
          into :found_command_unique_idx, :field_description, :fk_table_name, :fk_field_name;
    
          if (:found_command_unique_idx = True) then
          begin         
            select SUCCESS, LOG_MESSAGE
            from SP_CREATE_UNIQUE_IDX(:table_name, :field_name, :field_description)
            into :SUCCESS, :LOG_MESSAGE;
            
            SUSPEND;
          end        
    
          /*--------------------------------------------------------------------------------------*/    
          gen_command = '{FK:=';
          
          found_command_foreign_key = False;        
          fk_table_name = null;
          fk_field_name = null;
          
          select DETERMINED, FIELDDESCRIPTION, TABLENAME, FIELDNAME, REQUIRED
          from SP_CHECK_COMMAND (:gen_command, :field_description)
          into :found_command_foreign_key, :field_description, :fk_table_name, :fk_field_name, :fk_condition;
            
          if (:found_command_foreign_key = True) then
          begin         
            select SUCCESS, LOG_MESSAGE
            from SP_CREATE_FOREIGN_KEY(:table_name,
                   :field_name,
                   :field_description,
                   :fk_table_name,
                   :fk_field_name,
                   :fk_condition)
            into :SUCCESS, :LOG_MESSAGE;
            
            SUSPEND;
          end
          
          /*--------------------------------------------------------------------------------------*/
          gen_command = '{CAT:=';

          found_command_catalog = False;        
          fk_table_name = null;
          fk_field_name = null;
          
          select DETERMINED, FIELDDESCRIPTION, TABLENAME, FIELDNAME, REQUIRED
          from SP_CHECK_COMMAND (:gen_command, :field_description)
          into :found_command_catalog, :field_description, :fk_table_name, :fk_field_name, :fk_condition;
          
--           if (:found_command_catalog = True) then
--           begin         
--             select SUCCESS, LOG_MESSAGE
--             from SP_CREATE_CATALOG_BY_FIELD()
--             into :SUCCESS, :LOG_MESSAGE;
--             
--             SUSPEND;
--           end

          /*--------------------------------------------------------------------------------------*/
          gen_command = '{REL:=';

          found_command_relation = False;        
          fk_table_name = null;
          fk_field_name = null;
          
          select DETERMINED, FIELDDESCRIPTION, TABLENAME, FIELDNAME, REQUIRED
          from SP_CHECK_COMMAND (:gen_command, :field_description)
          into :found_command_relation, :field_description, :fk_table_name, :fk_field_name, :fk_condition;
          
--           if (:found_command_relation = True) then
--           begin         
--             select SUCCESS, LOG_MESSAGE
--             from SP_CREATE_RELATION_BY_FIELD()
--             into :SUCCESS, :LOG_MESSAGE;
--             
--             SUSPEND;
--           end
          
          
        end                     
      end   
    end
    else
    begin
      LOG_MESSAGE = :ATablename || ' ist nicht vorhanden';
      
      suspend;
    end
  end  
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CREATE_ALL_CONSTRAINTS
  RETURNS (
    SUCCESS DN_BOOLEAN,
    LOG_MESSAGE DN_MESSAGE)
  AS
  declare variable table_name DN_DB_OBJECT;
  begin
    for
    select distinct rn.RDB$RELATION_NAME
    from RDB$RELATIONS rn, RDB$TYPES t
    where rn.RDB$SYSTEM_FLAG = 0
    and rn.RDB$RELATION_TYPE=t.RDB$TYPE
    and ((t.RDB$TYPE_NAME='RELATION')
         or
         (t.RDB$TYPE_NAME='GLOBAL_TEMPORARY_DELETE')) 
      
    into :table_name  
    do
    begin
      for
      select SUCCESS, LOG_MESSAGE
      from SP_CREATE_CONSTRAINTS(:table_name)
      into :SUCCESS, :LOG_MESSAGE
      do
      begin
        suspend;
      end  
    end 
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_VIEW (
    ADBObject DN_DB_OBJECT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    ADeleteRole DN_DB_OBJECT DEFAULT 'SDDL_DELETE',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC')
  AS
  -- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  begin 
    if (position(Upper('VR') in Upper(:ADBObject)) = 1) then
    begin
      /*
      sql_stmt = 'GRANT SELECT ON ' || :ADBObject || ' TO ' || :AAllRole;
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('GRANT SELECT ON ' || :ADBObject || ' TO ' || :AAllRole);
      
      /*
      sql_stmt = 'GRANT SELECT ON ' || :ADBObject || ' TO ' || :APublicRole;
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('GRANT SELECT ON ' || :ADBObject || ' TO ' || :APublicRole);      
    end  
    else
    begin
      /*
      sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || :ADBObject || ' TO ' || :AAllRole;
      execute statement sql_stmt;
      */

      execute
      procedure PKG_SQL.SP_EXECUTE('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || :ADBObject || ' TO ' || :AAllRole);      
      
      /*
      sql_stmt = 'GRANT SELECT, INSERT, UPDATE ON ' || :ADBObject || ' TO ' || :APublicRole;
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('GRANT SELECT, INSERT, UPDATE ON ' || :ADBObject || ' TO ' || :APublicRole);

      /*
      sql_stmt = 'GRANT DELETE ON ' || :ADBObject || ' TO ' || :ADeleteRole;
      execute statement sql_stmt;
      */
      
      execute
      procedure PKG_SQL.SP_EXECUTE('GRANT DELETE ON ' || :ADBObject || ' TO ' || :ADeleteRole);      
    end
    
    /*
    sql_stmt = 'GRANT SELECT ON ' || :ADBObject || ' TO PUBLIC';
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT SELECT ON ' || :ADBObject || ' TO PUBLIC');   
            
    for 
    select RDB$RELATION_NAME
    from RDB$VIEW_RELATIONS  
    where RDB$VIEW_NAME=:ADBObject
    into :relation_name
    do
    begin
      --- sql_stmt = null;
      
      /*
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then 
        sql_stmt = 'GRANT SELECT ON ' || :relation_name || ' TO ' || :ADBObject;
      else
      if (position(Upper('VW') in Upper(Trim(:relation_name))) = 1) then            
        sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || :relation_name || ' TO ' || :ADBObject;
      else
      if (position(Upper('T') in Upper(Trim(:relation_name))) = 1) then
      begin 
        if (position(Upper('VR') in Upper(:ADBObject)) = 1) then
          sql_stmt = 'GRANT SELECT ON ' || Trim(:relation_name) || ' TO ' || :ADBObject;
        else
          sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO ' || :ADBObject;    
      end
      */
      
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then 
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT ON ' || :relation_name || ' TO ' || :ADBObject);
      else
      if (position(Upper('VW') in Upper(Trim(:relation_name))) = 1) then            
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || :relation_name || ' TO ' || :ADBObject);       
      else
      if (position(Upper('T') in Upper(Trim(:relation_name))) = 1) then
      begin 
        if (position(Upper('VR') in Upper(:ADBObject)) = 1) then
          execute
          procedure PKG_SQL.SP_SET('GRANT SELECT ON ' || Trim(:relation_name) || ' TO ' || :ADBObject);                
        else
          execute
          procedure PKG_SQL.SP_SET('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO ' || :ADBObject);                             
      end
    
      /*
      if (sql_stmt is not null) then
        execute statement sql_stmt;
      */  
      
      if (PKG_SQL.SF_IS_AVAILABLE() = True) then  
        execute
        procedure PKG_SQL.SP_EXECUTE;
    end  
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_SEQ (
    ADBObject DN_DB_OBJECT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC')
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  begin 
    /*
    sql_stmt = 'GRANT USAGE ON SEQUENCE ' || :ADBObject || ' TO ' || :AAllRole;
    execute statement sql_stmt;
    */    
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT USAGE ON SEQUENCE ' || :ADBObject || ' TO ' || :AAllRole);
  
    /*
    sql_stmt = 'GRANT USAGE ON SEQUENCE ' || :ADBObject || ' TO ' || :APublicRole;   
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT USAGE ON SEQUENCE ' || :ADBObject || ' TO ' || :APublicRole);      
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_EXC (
    ADBObject DN_DB_OBJECT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC')
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  begin 
    /*
    sql_stmt = 'GRANT USAGE ON EXCEPTION ' || :ADBObject || ' TO ' || :AAllRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT USAGE ON EXCEPTION ' || :ADBObject || ' TO ' || :AAllRole);        
    
    /*
    sql_stmt = 'GRANT USAGE ON EXCEPTION ' || :ADBObject || ' TO ' || :APublicRole;   
    execute statement sql_stmt;
    */  
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT USAGE ON EXCEPTION ' || :ADBObject || ' TO ' || :APublicRole);      
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_SP (
    ADBObject DN_DB_OBJECT_EXT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
    AAllowHistory DN_BOOLEAN = True)
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  begin 
    /*
    sql_stmt = 'GRANT EXECUTE ON PROCEDURE ' || :ADBObject || ' TO ' || :AAllRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PROCEDURE ' || :ADBObject || ' TO ' || :AAllRole);
    
    /*
    sql_stmt = 'GRANT EXECUTE ON PROCEDURE ' || :ADBObject || ' TO ' || :APublicRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PROCEDURE ' || :ADBObject || ' TO ' || :APublicRole);      
    
    for
    select a.RDB$DEPENDED_ON_NAME
    from RDB$DEPENDENCIES a 
    where RDB$DEPENDENT_NAME = :ADBObject
    and a.RDB$DEPENDED_ON_NAME like 'V%'  
    into :relation_name
    do
    begin
      /* Eventuell zuerst pr�fen ob :relation_name tats�chlich eine VIEW ist */
    
      /*
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        sql_stmt = 'GRANT SELECT ON ' || Trim(:relation_name) || ' TO PROCEDURE ' || :ADBObject;
      else
        sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO PROCEDURE ' || :ADBObject;        
          
      execute statement sql_stmt;  
      */
      
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT ON ' || Trim(:relation_name) || ' TO PROCEDURE ' || :ADBObject);
      else
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO PROCEDURE ' || :ADBObject);                    
      
      execute
      procedure PKG_SQL.SP_EXECUTE;
    
      if (:AAllowHistory = True) then
      begin
        /*
        sql_stmt = 'GRANT EXECUTE ON PACKAGE PKG_HISTORY TO PROCEDURE ' || :ADBObject;
        execute statement sql_stmt;
        */
        
        execute
        procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PACKAGE PKG_HISTORY TO PROCEDURE ' || :ADBObject);                  
      end
    end
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_SF (
    ADBObject DN_DB_OBJECT_EXT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
    AAllowHistory DN_BOOLEAN = True)
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  begin
    /*
    sql_stmt = 'GRANT EXECUTE ON FUNCTION ' || :ADBObject || ' TO ' || :AAllRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON FUNCTION ' || :ADBObject || ' TO ' || :AAllRole);
    
    /*
    sql_stmt = 'GRANT EXECUTE ON FUNCTION ' || :ADBObject || ' TO ' || :APublicRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON FUNCTION ' || :ADBObject || ' TO ' || :APublicRole);      
    
    for
    select a.RDB$DEPENDED_ON_NAME
    from RDB$DEPENDENCIES a 
    where RDB$DEPENDENT_NAME = :ADBObject
    and a.RDB$DEPENDED_ON_NAME like 'V%'  
    into :relation_name
    do
    begin
      /* Eventuell zuerst pr�fen ob :relation_name tats�chlich eine VIEW ist */
    
      /*
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        sql_stmt = 'GRANT SELECT ON ' || Trim(:relation_name) || ' TO FUNCTION ' || :ADBObject;
      else
        sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO FUNCTION ' || :ADBObject;
          
      execute statement sql_stmt;
      */  

      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT ON ' || Trim(:relation_name) || ' TO FUNCTION ' || :ADBObject);
      else
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO FUNCTION ' || :ADBObject);
      
      execute
      procedure PKG_SQL.SP_EXECUTE;
            
      if (:AAllowHistory = True) then
      begin
        /*
        sql_stmt = 'GRANT EXECUTE ON PACKAGE PKG_HISTORY TO FUNCTION ' || :ADBObject;
        execute statement sql_stmt;
        */
        
        execute
        procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PACKAGE PKG_HISTORY TO FUNCTION ' || :ADBObject);                  
      end
    end
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_PKG (
    ADBObject DN_DB_OBJECT,  
    AAllRole DN_DB_OBJECT DEFAULT 'SDDL_ALL',
    APublicRole DN_DB_OBJECT DEFAULT 'SDDL_PUBLIC',
    AAllowHistory DN_BOOLEAN = True)
  AS
  --- declare variable sql_stmt DN_SQL_STMT;
  declare variable relation_name DN_DB_OBJECT;
  begin 
    /*
    sql_stmt = 'GRANT EXECUTE ON PACKAGE ' || :ADBObject || ' TO ' || :AAllRole;
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PACKAGE ' || :ADBObject || ' TO ' || :AAllRole);
    
    /*
    sql_stmt = 'GRANT EXECUTE ON PACKAGE ' || :ADBObject || ' TO ' || :APublicRole;   
    execute statement sql_stmt;
    */
    
    execute
    procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PACKAGE ' || :ADBObject || ' TO ' || :APublicRole);        
    
    for
    select distinct RDB$DEPENDED_ON_NAME
    from RDB$DEPENDENCIES 
    where RDB$DEPENDENT_NAME = :ADBObject
    and RDB$DEPENDED_ON_NAME like 'V%'  
    into :relation_name
    do
    begin
      /* Eventuell zuerst pr�fen ob :relation_name tats�chlich eine VIEW ist */
    
      /*
      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        sql_stmt = 'GRANT SELECT ON ' || Trim(:relation_name) || ' TO PACKAGE ' || :ADBObject;
      else
        sql_stmt = 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO PACKAGE ' || :ADBObject;
          
      execute statement sql_stmt;
      */

      if (position(Upper('VR') in Upper(Trim(:relation_name))) = 1) then
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT ON ' || Trim(:relation_name) || ' TO PACKAGE ' || :ADBObject);
      else
        execute
        procedure PKG_SQL.SP_SET('GRANT SELECT, INSERT, UPDATE, DELETE ON ' || Trim(:relation_name) || ' TO PACKAGE ' || :ADBObject);
      
      execute
      procedure PKG_SQL.SP_EXECUTE;       
      
      if ((:AAllowHistory = True) and (Upper(Trim(:ADBOBject)) <> 'PKG_HISTORY')) then
      begin
        /*
        sql_stmt = 'GRANT EXECUTE ON PACKAGE PKG_HISTORY TO PACKAGE ' || :ADBObject;
        execute statement sql_stmt;
        */
        
        execute
        procedure PKG_SQL.SP_EXECUTE('GRANT EXECUTE ON PACKAGE PKG_HISTORY TO PACKAGE ' || :ADBObject);                  
      end
    end  
  end
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT_ALL
  AS
  declare relation_name DN_DB_OBJECT;
  declare package_name DN_DB_OBJECT;
  declare role_all DN_DB_OBJECT;
  declare role_public DN_DB_OBJECT;
  declare role_delete DN_DB_OBJECT;
  declare success DN_DB_OBJECT; 
  begin
    success = False;
  
    select SUCCESS, ROLE_ALL, ROLE_PUBLIC, ROLE_DELETE
    from SP_GET_CUSTOM_ROLES
    into :success, :role_all, :role_public, :role_delete;
    
    if (success = False) then
    begin
      role_all = 'SDDL_ALL';
      role_public = 'SDDL_PUBLIC';
      role_delete = 'SDDL_DELETE';  
    end 
 
    for
    select distinct RDB$PROCEDURE_NAME, RDB$PACKAGE_NAME 
    from RDB$PROCEDURES 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name, :package_name
    do
    begin
      if ((Trim(package_name) = '') or (package_name is null)) then
        execute
        procedure
          SP_GRANT_SP (Trim(:relation_name), :role_all, :role_public);
    end
     
    for
    select distinct RDB$FUNCTION_NAME, RDB$PACKAGE_NAME  
    from RDB$FUNCTIONS 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name, :package_name 
    do
    begin
      if ((Trim(package_name) = '') or (package_name is null)) then    
        execute
        procedure
          SP_GRANT_SF (Trim(:relation_name), :role_all, :role_public);
    end
  
    for
    select distinct RDB$PACKAGE_NAME 
    from RDB$PACKAGES 
    where RDB$SYSTEM_FLAG = 0
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_PKG (Trim(:relation_name), :role_all, :role_public);
    end            
    
    for
    select distinct RDB$VIEW_NAME 
    from RDB$VIEW_RELATIONS 
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_VIEW (Trim(:relation_name), :role_all, :role_delete, :role_public);
    end      
    
    for
    select distinct RDB$GENERATOR_NAME 
    from RDB$GENERATORS 
    where RDB$SYSTEM_FLAG=0    
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_SEQ (Trim(:relation_name), :role_all, :role_public);
    end   
  
    for
    select distinct RDB$EXCEPTION_NAME 
    from RDB$EXCEPTIONS 
    where RDB$SYSTEM_FLAG=0   
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_EXC (Trim(:relation_name), :role_all, :role_public);
    end       
  end
  
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_GRANT (
    ADBObject DN_DB_OBJECT)
  AS
  declare relation_name DN_DB_OBJECT;
  declare package_name DN_DB_OBJECT;
  declare role_all DN_DB_OBJECT;
  declare role_public DN_DB_OBJECT;
  declare role_delete DN_DB_OBJECT; 
  declare success DN_DB_OBJECT; 
  begin
    success = False;
  
    select SUCCESS, ROLE_ALL, ROLE_PUBLIC, ROLE_DELETE
    from SP_GET_CUSTOM_ROLES
    into :success, :role_all, :role_public, :role_delete;
    
    if (success = False) then
    begin
      role_all = 'SDDL_ALL';
      role_public = 'SDDL_PUBLIC';
      role_delete = 'SDDL_DELETE';  
    end 
 
    for
    select distinct a.RDB$PROCEDURE_NAME 
    from RDB$PROCEDURES a 
    where a.RDB$PROCEDURE_NAME=:ADBObject
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_SP (Trim(:relation_name), :role_all, :role_public);
        
      exit;  
    end    
    
    for
    select distinct a.RDB$FUNCTION_NAME 
    from RDB$FUNCTIONS a 
    where a.RDB$FUNCTION_NAME=:ADBObject 
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_SF (Trim(:relation_name), :role_all, :role_public);
        
      exit;  
    end
    
    for
    select distinct a.RDB$PACKAGE_NAME 
    from RDB$PACKAGES a 
    where a.RDB$PACKAGE_NAME=:ADBObject
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_PKG (Trim(:relation_name), :role_all, :role_public);
        
      exit;  
    end            
    
    for
    select distinct a.RDB$VIEW_NAME 
    from RDB$VIEW_RELATIONS a
    where a.RDB$VIEW_NAME=:ADBObject   
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_VIEW (Trim(:relation_name), :role_all, :role_delete, :role_public);
        
      exit;  
    end   
    
    for
    select distinct RDB$GENERATOR_NAME 
    from RDB$GENERATORS 
    where RDB$GENERATOR_NAME=:ADBObject   
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_SEQ (Trim(:relation_name), :role_all, :role_public);
        
      exit;  
    end   
  
    for
    select distinct RDB$EXCEPTION_NAME 
    from RDB$EXCEPTIONS 
    where RDB$EXCEPTION_NAME=:ADBObject   
    into :relation_name
    do
    begin
      execute
      procedure
        SP_GRANT_EXC (Trim(:relation_name), :role_all, :role_public);
        
      exit;  
    end     
  end              
end^
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG_SDDL.SP_EXTRACT_TABLENAME IS
'Entfernt den Prefix aus einem Tabellennamen';

COMMENT ON PROCEDURE PKG_SDDL.SP_GET_COLUMNLIST IS
'Ermittelt die Spaltenliste zu einem Tabellenamen';

COMMENT ON PROCEDURE PKG_SDDL.SP_GET_PRIMKEYLIST IS
'Ermittelt eine Spaltenliste der Prim�rschl�ssel';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_STD_TABLE_VIEW_CMT 
IS 'Erstellt anhand der Tabellenkommentare, die Standardviewkommentare';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_STD_TABLE_VIEW IS
'Erstellt eine Standardview zu einem Tabellennamen';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_TRIGGER_BU IS
'Erstellt den ersten Before-Update-Trigger (BU0) zu einem Tabellennamen um den Stempel zu aktualisieren';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_SEQUNECE IS
'Erstellt eine Sequence zu einem Tabellennamen um ein beliebiges Feld zu erh�hen';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_TBL_CATALOG IS
'Erstellt einen Katalog';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_CATALOG IS
'Legt einen Katalog mit all seinen Datenbankobjekten an';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_STAMP IS
'Erstellt eine Stempel f�r eine Tabelle';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_FIELD_DESCRIPTION IS
'Erstellt das Standardfeld: DESCRIPTION';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_TABLE_COMMENT IS
'Erstellt einen Kommentar zur Tabelle';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_PRIMARY_CONSTRAINT IS
'Erstellt einen Prim�rschl�ssel zur Tabelle';

COMMENT ON PROCEDURE PKG_SDDL.SP_COMPLETE_TABLE IS
'Erg�nzt ein Grundschema um Standards: Constraints, Sequences, Triggers, Standardviews, etc.';

COMMENT ON PROCEDURE PKG_SDDL.SP_CHECK_COMMAND IS
'Pr�ft ob in einer Feldbeschreibung ein Gencode-Kommand vorhanden ist';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_UNIQUE_KEY IS
'Erstellt einen Unique-Key';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_UNIQUE_IDX IS
'Erstellt einen eindeutigen Einspalten-Index';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_FOREIGN_KEY IS
'Erstellt einen Foreign-Key';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_CONSTRAINTS IS
'Erstellt f�r eine Tabelle alle �ber ein Gencommande angeforderten Constraints';

COMMENT ON PROCEDURE PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS IS
'Erstellt f�r alle Tabellen alle �ber ein Gencommande angeforderten Constraints';   
    
COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_VIEW IS
'Erstellt Grants f�r Views';   

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_SEQ IS
'Erstellt Grants f�r Sequences';  

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_EXC IS
'Erstellt Grants f�r Exceptions'; 

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_SP IS
'Erstellt Grants f�r SPs';   

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_SF IS
'Erstellt Grants f�r SFs';

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_PKG IS
'Erstellt Grants f�r PKGs';

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT_ALL IS
'Erstellt alle Grants f�r alle Views und SPs';   

COMMENT ON PROCEDURE PKG_SDDL.SP_GRANT IS
'Erstellt Grants f�r eine beliebige View oder SP';   
    
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.package.body.sql',
    'Package-Body des sDDL-Bootstrap installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/