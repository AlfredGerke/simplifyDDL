/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Es werden Standard-Benutzer und -Rollen für das sDDL.bootstrap angelegt    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*          ---
/*          Der Standard-User für das Bootstrap muss wie beschreiben bestehen erhalten bleiben
/*          Das Passwort sollte natürlich hier oder zu einem späteren Zeitpunkt geändert werden
/*
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
SET TERM ^ ;
EXECUTE BLOCK
AS
begin
  if (exists(select 1
             from SEC$USERS
             where SEC$USER_NAME = 'SDDL_USER')) 
  then
    execute statement 'DROP USER SDDL_USER';
    
  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = 'SDDL_DELETE')) 
  then
    execute statement 'DROP ROLE SDDL_DELETE';    
    
  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = 'SDDL_PUBLIC')) 
  then
    execute statement 'DROP ROLE SDDL_PUBLIC';
        
  if (exists(select 1
             from RDB$ROLES 
             where RDB$ROLE_NAME = 'SDDL_ALL')) 
  then
    execute statement 'DROP ROLE SDDL_ALL';
   
end^
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

CREATE USER SDDL_USER
PASSWORD 'change_on_install' 
FIRSTNAME 'sDLL' 
MIDDLENAME 'Bootstrap' 
LASTNAME 'User';

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

CREATE ROLE SDDL_DELETE;
COMMENT ON ROLE SDDL_DELETE
IS 'Sammelt alle Delete-Rechte';
/*------------------------------------------------------------------------------------------------*/

CREATE ROLE SDDL_PUBLIC;
COMMENT ON ROLE SDDL_PUBLIC
IS 'Sammelt alle Select-, Update-, Insert- und Exectue-Rechte';
/*------------------------------------------------------------------------------------------------*/

CREATE ROLE SDDL_ALL;  
COMMENT ON ROLE SDDL_ALL
IS 'Sammelt alle Select-, Update-, Insert-, Delete- und Exectue-Rechte';
/*------------------------------------------------------------------------------------------------*/

GRANT SDDL_ALL TO SDDL_USER;
GRANT SDDL_DELETE TO SDDL_USER;
GRANT SDDL_PUBLIC TO SDDL_USER;

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/