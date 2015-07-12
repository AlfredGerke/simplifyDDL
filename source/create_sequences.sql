/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2015-07-11                                                        
/* Purpose: Erstellt die Sequences   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FireBird 2.5.x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/*              
/*------------------------------------------------------------------------------------------------*/
/* History: 2015-07-11
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* Sequences -------------------------------------------------------------------------------------*/
CREATE SEQUENCE SDDL$SEQ_CODE_COMMAND_ID;

COMMENT ON SEQUENCE SDDL$SEQ_CODE_COMMAND_ID
IS 'Primärschlüssel für SDDL$CODE_COMMAND';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DYN_ARGUMENT_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DYN_ARGUMENT_ID
IS 'Primärschlüssel für SDDL$DYN_ARGUMENT';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DYN_ASSIGNMENT_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DYN_ASSIGNMENT_ID
IS 'Primärschlüssel für SDDL$DYN_ASSIGNMENT';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DICT_VALID_ARGUMENT_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DICT_VALID_ARGUMENT_ID
IS 'Primärschlüssel für SDDL$DICT_VALID_ARGUMENT';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DICT_VALID_COMMAND_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DICT_VALID_COMMAND_ID
IS 'Primärschlüssel für SDDL$DICT_VALID_COMMAND';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DYN_PARSED_COMMAND_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DYN_PARSED_COMMAND_ID
IS 'Primärschlüssel für SDDL$DYN_PARSED_COMMAND';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DYN_TABLE_COMMENT_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DYN_TABLE_COMMENT_ID
IS 'Primärschlüssel für SDDL$DYN_TABLE_COMMENT';

/* ------ */

CREATE SEQUENCE SDDL$SEQ_DYN_FIELD_COMMENT_ID;

COMMENT ON SEQUENCE SDDL$SEQ_DYN_FIELD_COMMENT_ID
IS 'Primärschlüssel für SDDL$DYN_FIELD_COMMENT'; 

/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/