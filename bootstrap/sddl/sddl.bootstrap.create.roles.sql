/*------------------------------------------------------------------------------------------------*/
/* ###Description: 
/*   * Es werden Standard-benutzer und -Rollen für das sDDL-Bootstrap angelegt
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