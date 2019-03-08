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
  PROCEDURE SP_SP_DESCRIBE_ENTITY_FIELDS(
    AEntity DN_DB_OBJECT,
    AEntityType DN_ENTITY_TYPE_CAPTION)
  RETURNS (
    ENTITY_TYPE_CAPTION DN_ENTITY_TYPE_CAPTION,
    ENTITY_NAME DN_DB_OBJECT,
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
     
     ENTITY_TYPE_CAPTION = entity_type;
     ENTITY_NAME = entity;
     CAPTION1 = '---';
     CAPTION2 = '---';
     CAPTION3 = '---';     

     info = 'Felder ermitteln';
     for
     select distinct RDB$FIELD_NAME, RDB$FIELD_SOURCE, RDB$FIELD_ID
     from RDB$RELATION_FIELDS
     where RDB$RELATION_NAME=:entity
     and RDB$SYSTEM_FLAG=0
     order by RDB$FIELD_POSITION
     into :CAPTION1, :CAPTION2, field_id
     do
       suspend;
       
     when any do
     begin
       ENTITY_TYPE_CAPTION = entity_type;
       ENTITY_NAME = entity;
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
    ENTITY_TYPE_CAPTION DN_ENTITY_TYPE_CAPTION,
    ENTITY_NAME DN_DB_OBJECT,
    CAPTION1 DN_CAPTION,
    CAPTION2 DN_CAPTION,
    CAPTION3 DN_CAPTION)
   AS
   declare info DN_CAPTION;
   declare entity DN_DB_OBJECT;
   declare entity_type DN_ENTITY_TYPE;
   begin
     info = 'Start';
     entity_type = null;
     
     entity = Upper(Trim(AEntity));
     
     ENTITY_TYPE_CAPTION = 'UNKNOWN';
     ENTITY_NAME = entity;
     CAPTION1 = '---';
     CAPTION2 = '---';
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
       ENTITY_TYPE_CAPTION = 
         case entity_type
           when 0 then 'TABLE'
           when 1 then 'VIEW'
           when 5 then 'GTT'
         else 'UNKNOWN'
         end;    
         
     if (ENTITY_TYPE_CAPTION = 'UNKNOWN') then
     begin
       CAPTION3 = 'Entität "' || :entity || '" ist keine Tabelle, GTT oder View';
       
       suspend;
       exit;
     end
     else
     begin
       ENTITY_NAME = :entity;
       CAPTION3 = 'Felder';

       suspend;
     
       for
       select ENTITY_TYPE_CAPTION, ENTITY_NAME, CAPTION1, CAPTION2, CAPTION3
       from SP_SP_DESCRIBE_ENTITY_FIELDS (:entity, :ENTITY_TYPE_CAPTION)
       into :ENTITY_TYPE_CAPTION, :ENTITY_NAME, :CAPTION1, :CAPTION2, :CAPTION3
       do
         suspend;    
     end              
     
     when any do
     begin
       ENTITY_TYPE_CAPTION = 'UNKNOWN';
       ENTITY_NAME = '---';
       CAPTION1 = 'ERROR';
       CAPTION2 = SQLSTATE;
       CAPTION3 = info;
       
       suspend;          
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