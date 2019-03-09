/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Common-Procedures and -Functions werden angelegt
/*   - Package-Body        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-26
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/

/* SPs */
SET TERM ^ ;
RECREATE PACKAGE BODY PKG_COMMON
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GET_CURRENT_USER
  RETURNS (
    WRAPPED_USER_NAME DN_DB_OBJECT)
  AS
  begin
    WRAPPED_USER_NAME = current_user;
    
    suspend;
    
    when any do
    begin
      WRAPPED_USER_NAME = current_user;
      
      suspend;
    end
  end
  
  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_GET_CURRENT_USER(
    )
  RETURNS DN_DB_OBJECT
  AS
  declare wrapped_user_name DN_DB_OBJECT;
  begin
    select WRAPPED_USER_NAME
    from PKG_COMMON.SP_GET_CURRENT_USER
    into :wrapped_user_name;
    
    RETURN wrapped_user_name;
  end
    
  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_SUSPEND_MESSAGE(
    AInfo DN_MESSAGE)
  RETURNS (
    INFO DN_MESSAGE)
  AS
  begin
    INFO = Trim(AInfo);
    
    suspend;
  end
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_GRANTS(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;     
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 7;
     RECORD_TYPE_CAPTION = 'GRANTS';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Grants ermitteln';
     for
     select distinct RDB$USER, RDB$GRANTOR, RDB$PRIVILEGE
     from RDB$USER_PRIVILEGES
     where RDB$RELATION_NAME=:entity    
     into :CAPTION1, :CAPTION2, :CAPTION3
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end   
   end  
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_DEPENDENCIES(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;     
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 6;
     RECORD_TYPE_CAPTION = 'DEPENDENCIES';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Dependencies ermitteln';
     for
     select distinct RDB$DEPENDENT_NAME, RDB$FIELD_NAME, RDB$PACKAGE_NAME
     from RDB$DEPENDENCIES
     where RDB$DEPENDED_ON_NAME=:entity    
     into :CAPTION1, :CAPTION2, :CAPTION3
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end   
   end  

  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_TRIGGERS(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;     
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 5;
     RECORD_TYPE_CAPTION = 'TRIGGER';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Trigger ermitteln';
     for
     select distinct RDB$TRIGGER_NAME
     from RDB$TRIGGERS
     where RDB$RELATION_NAME=:entity
     and RDB$SYSTEM_FLAG=0     
     into :CAPTION1
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end   
   end
   
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_INDICES(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;  
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 4;
     RECORD_TYPE_CAPTION = 'INDICES';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Indices ermitteln';
     for
     select distinct RDB$INDEX_NAME, RDB$FOREIGN_KEY
     from RDB$INDICES
     where RDB$RELATION_NAME=:entity
     and RDB$SYSTEM_FLAG=0
     into :CAPTION1, :CAPTION2
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end
   end   
   
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_CONSTRAINTS(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;  
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 3;
     RECORD_TYPE_CAPTION = 'CONSTRAINTS';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Constraints ermitteln';
     for
     select distinct RDB$CONSTRAINT_NAME, RDB$INDEX_NAME
     from RDB$RELATION_CONSTRAINTS
     where RDB$RELATION_NAME=:entity
     into :CAPTION1, :CAPTION2
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end
   end   
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY_FIELDS(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE_CAPTION; 
   declare field_id DN_INDEX;  
   begin
     entity_type = AEntityType;     
     entity = AEntity;
     
     RECORD_TYPE = 2;
     RECORD_TYPE_CAPTION = 'FIELDS';
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Felder ermitteln';
     for
     select distinct RDB$FIELD_NAME, RDB$FIELD_SOURCE, RDB$BASE_FIELD, RDB$FIELD_ID
     from RDB$RELATION_FIELDS
     where RDB$RELATION_NAME=:entity
     and RDB$SYSTEM_FLAG=0
     order by RDB$FIELD_POSITION
     into :CAPTION1, :CAPTION2, :CAPTION3, field_id
     do
       suspend;
       
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;               
     end
   end
  
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE_ENTITY(
    AEntity DN_DB_OBJECT,
    ADoSeperator DN_BOOLEAN DEFAULT False)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE;
   declare entity_type_caption DN_ENTITY_TYPE_CAPTION;   
   begin
     info = 'Start';
     entity_type = null;
     
     entity = Upper(Trim(AEntity));
     entity_type_caption = 'UNKNOWN';

     RECORD_TYPE = 0;
     RECORD_TYPE_CAPTION = 'UNKNOWN';
     
     if (ADoSeperator = True) then
     begin
       CAPTION1 = '---';
       CAPTION2 = '---';
       CAPTION3 = '---';
       
       suspend;
     end
     
     CAPTION1 = entity_type_caption;
     CAPTION2 = entity;
     CAPTION3 = '---';
    
     info = 'Auf Entitäten-Type prüfen';  
     for       
     select distinct RDB$RELATION_TYPE
     from RDB$RELATIONS  
     where RDB$SYSTEM_FLAG = 0 
     and Upper(Trim(RDB$RELATION_NAME)) = :entity   
     into :entity_type
     do
       break;
     
     if (entity_type is not null) then
       entity_type_caption = 
         case entity_type
           when 0 then 'TABLE'
           when 1 then 'VIEW'
           when 5 then 'GTT'
         else 'UNKNOWN'
         end;   
         
     if (entity_type_caption = 'UNKNOWN') then
     begin
       CAPTION3 = 'Entität "' || :entity || '" ist keine Tabelle, GTT oder View';
       
       suspend;
       exit;
     end
     else
     begin
       RECORD_TYPE = 1;
       RECORD_TYPE_CAPTION = 'HEADER';
       CAPTION1 = '[' || :entity || ']';
       CAPTION2 = '[' || :entity_type_caption || ']';
       CAPTION3 = '---';  
       
       suspend;   
     
       RECORD_TYPE = 1;
       RECORD_TYPE_CAPTION = 'HEADER';
       CAPTION1 = '[FIELD_NAME]';
       CAPTION2 = '[FIELD_TYPE]';
       CAPTION3 = '[BASE_FIELD]';

       suspend;
     
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_FIELDS (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;
       
       RECORD_TYPE = 1;  
       RECORD_TYPE_CAPTION = 'HEADER';  
       CAPTION1 = '[CONSTRAINT_NAME]';
       CAPTION2 = '[INDEX_NAME]';       
       CAPTION3 = '---';

       suspend;
     
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_CONSTRAINTS (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;
         
       RECORD_TYPE = 1;  
       RECORD_TYPE_CAPTION = 'HEADER';  
       CAPTION1 = '[INDEX_NAME]';
       CAPTION2 = '[FOREIGN_KEY]';       
       CAPTION3 = '---';

       suspend;
     
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_INDICES (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;
         
       RECORD_TYPE = 1;
       RECORD_TYPE_CAPTION = 'HEADER';  
       CAPTION1 = '[TRIGGER_NAME]';
       CAPTION2 = '---';                
       CAPTION3 = '---';

       suspend;
     
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_TRIGGERS (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;
       
       RECORD_TYPE = 1;
       RECORD_TYPE_CAPTION = 'HEADER';  
       CAPTION1 = '[DEPENDENT_NAME]';
       CAPTION2 = '[FIELD_NAME]';                
       CAPTION3 = '[PACKAGE_NAME]';
         
       suspend;  
         
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_DEPENDENCIES (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;         
                 
       RECORD_TYPE = 1;          
       RECORD_TYPE_CAPTION = 'HEADER';  
       CAPTION1 = '[USER_NAME]';
       CAPTION2 = '[GRANTOR_NAME]';                
       CAPTION3 = '[PRIVILEGE]';
         
       suspend;  
         
       for
       select RECORD_TYPE, RECORD_TYPE_CAPTION, CAPTION1, CAPTION2, CAPTION3
       from SP_DESCRIBE_ENTITY_GRANTS (:entity, :entity_type_caption)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;         
             
     end              
     
     when any do
     begin
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;          
     end   
   end  
   
  /*----------------------------------------------------------------------------------------------*/    
  PROCEDURE SP_DESCRIBE(
    AEntity DN_DB_OBJECT)
  RETURNS (
    RECORD_TYPE DN_DESCRIBE_RECORD_TYPE,
    RECORD_TYPE_CAPTION DN_DESCRIBE_RECORD_CAPTION,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare entity DN_DB_OBJECT;
   begin
     if (AEntity is distinct from 'ALL') then
     begin
       for
       select *
       from SP_DESCRIBE_ENTITY (:AEntity)
       into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;
     end  
     else
     begin
       for
       select distinct rn.RDB$RELATION_NAME
       from RDB$RELATIONS rn, RDB$TYPES t
       where rn.RDB$SYSTEM_FLAG = 0
       and rn.RDB$RELATION_TYPE=t.RDB$TYPE
       and ((t.RDB$TYPE_NAME='RELATION') or
            (t.RDB$TYPE_NAME='VIEW') or
            (t.RDB$TYPE_NAME='GLOBAL_TEMPORARY_DELETE') or
            (t.RDB$TYPE_NAME='GLOBAL_TEMPORARY_PRESERVE'))
       into :entity
       do
       begin
         for
         select *
         from SP_DESCRIBE_ENTITY (:entity, True)
         into :RECORD_TYPE, :RECORD_TYPE_CAPTION, :CAPTION1, :CAPTION2, :CAPTION3
         do
           suspend;
       end     
     end
   end     
end^
SET TERM ; ^
/*------------------------------------------------------------------------------------------------*/

COMMENT ON PROCEDURE PKG_COMMON.SP_GET_CURRENT_USER
IS 'Wrapper SP für den CURRENT_USER';

COMMENT ON PROCEDURE PKG_COMMON.SP_SUSPEND_MESSAGE
IS 'Einfach Routine um einen String auszugeben';

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/