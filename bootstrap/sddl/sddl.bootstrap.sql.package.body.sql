/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-07-06                                                       
/* Description: Handling für SQL-Statements implementieren
/*   - - Package-Body        
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-07-06
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/

/* Interface */
SET TERM ^ ;
RECREATE PACKAGE BODY PKG_SQL
AS
begin
  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_IS_AVAILABLE (AIdent DN_SQL_IDENT not null)
  RETURNS DN_BOOLEAN
  AS
  declare variable count_rec integer;
  begin
    count_rec = null;
    select count(ID)
    from VW_T_SQL_STATEMENT
    where Upper(SQL_IDENT) = Upper(:AIdent)
    into :count_rec;
    
    if (count_rec is null) then
      RETURN false;
    else
      RETURN (count_rec > 0);  
  end

  /*----------------------------------------------------------------------------------------------*/
  FUNCTION SF_GET (AIdent DN_SQL_IDENT not null)
  RETURNS DN_SQL_STMT
  AS
  declare sql_stmt DN_SQL_STMT;
  begin
    sql_stmt = null;
    
    select SQL_STATEMENT
    from VW_T_SQL_STATEMENT
    where Upper(SQL_IDENT) = Upper(:AIdent)
    into :sql_stmt;
    
    RETURN sql_stmt;
  end      

  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_SET(AStatement DN_SQL_STMT,
    AIdent DN_SQL_IDENT not null)
  AS
  declare sql_stmt DN_SQL_STMT;  
  begin
    sql_stmt = SF_GET(AIdent);
    
    if (sql_stmt is null) then
      insert 
      into VW_T_SQL_STATEMENT
      (
        SQL_STATEMENT,
        SQL_IDENT
      )
      values
      (
        :AStatement,
        Upper(:AIdent)
      );
    else
    begin
      sql_stmt = sql_stmt || ASCII_CHAR(13) || :AStatement;
      update VW_T_SQL_STATEMENT
      set SQL_STATEMENT = :sql_stmt
      where Upper(SQL_IDENT) = Upper(:AIdent);                
    end  
  end
     
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_GET (AIdent DN_SQL_IDENT not null)
  RETURNS (
    SQL_STATEMENT DN_SQL_BLOB)
  AS
  begin
    SQL_STATEMENT = SF_GET(:AIdent);
    if (SQL_STATEMENT is null) then
      SQL_STATEMENT = '';
  
    suspend;
  end      

  /*----------------------------------------------------------------------------------------------*/  
  PROCEDURE SP_CLEAR (AIdent DN_SQL_IDENT)
  AS
  begin
    if (AIdent is null) then    
      delete
      from VW_T_SQL_STATEMENT;
    else
      delete
      from VW_T_SQL_STATEMENT
      where Upper(SQL_IDENT)=Upper(:AIdent);
  end  
  
  /*----------------------------------------------------------------------------------------------*/
  PROCEDURE SP_EXECUTE(AStatement DN_SQL_STMT,
    AClear DN_BOOLEAN,
    AIdent DN_SQL_IDENT not null)
  AS
  begin
    if (AClear = true) then
      execute 
      procedure SP_CLEAR(:AIdent);
      
    if (AStatement is not null) then  
      execute
      procedure SP_SET(:AStatement, :AIdent);
    
    if (SF_IS_AVAILABLE(:AIdent) = true) then
    begin
      execute statement SF_GET();
    
      execute 
      procedure SP_CLEAR (:AIdent);
    end
    
    when any do
    begin
      execute 
      procedure SP_CLEAR (:AIdent);
          
      execute
      procedure PKG_HISTORY.SP_SET_LOG_ERROR (
        cast(GDSCODE as DN_DESCRIPTION));
        
      execute
      procedure PKG_HISTORY.SP_SET_LOG_ERROR (
        cast(SQLCODE as DN_DESCRIPTION));    
        
      execute
      procedure PKG_HISTORY.SP_SET_LOG_ERROR (
        cast(SQLSTATE as DN_DESCRIPTION));    
    end  
  end
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/