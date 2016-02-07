/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2016-07-01                                                        
/* Purpose: Legt die Settings an   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - sDDL muss vorhanden sein 
/*            
/*------------------------------------------------------------------------------------------------*/
/* History: 2016-07-01
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* PREFIX ----------------------------------------------------------------------------------------*/

delete
from SDDL$V_DICT_SETTING;

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'VIEW',
   'V');

/* ------ */
   
execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'TABLE',
   '');

/* ------ */  
   
execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'SEQUENCE',              
   'SEQ');

/* ------ */  

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'STOREDPROCEDURE',              
   'SP'); 

/* ------ */  

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'FOREIGNKEY',              
   'FK');

/* ------ */
  
execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'PRIMARYKEY',
   'PK');  

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'INDEX',              
   'IDX');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'UNIQUEKEY',              
   'UNQ');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'N:M',              
   'REL');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'CATALOG',              
   'CAT');

/* ------ */
  
execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'DOMAIN',
   'DN');     

/* ------ */
  
execute
procedure
  SDDL$SP_SET_SETTING ('PREFIX',
   'UNIQUE.CONSTRAINT',
   'ALT');     

COMMIT WORK;
/* SCRIPT-COMMENT-TAGS ---------------------------------------------------------------------------*/

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.COMMENT',
    'START',              
    '/*');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.COMMENT',
    'END',              
    '*/');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.COMMENT',
    'PAD',              
    '-');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.COMMENT',
    'LEN',              
    '100');

COMMIT WORK;
/* SCRIPT-HEADER-TAGS ----------------------------------------------------------------------------*/
execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.HEADER',
    'ACTIVE',              
    '1');  

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.HEADER',
    'AUTHOR',              
    'Alfred Gerke');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.HEADER',
    'TITEL',              
    'Entwicklung sDDL');

/* ------ */

execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.HEADER',
    'COPYRIGHT',              
    'ExampleFactory');   

/* ------ */
  
execute
procedure
  SDDL$SP_SET_SETTING ('SCRIPT.HEADER',
    'COMMENT',              
    'Erste Arbeiten');

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/