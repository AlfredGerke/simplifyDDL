/*------------------------------------------------------------------------------------------------*/
/* Author:  Alfred Gerke (AGE)                                                  
/* Date:    2016-07-01                                                        
/* Purpose: Legt die erlaubten sDDL-Keywords an   
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - sDDL muss vorhanden sein 
/*            
/*------------------------------------------------------------------------------------------------*/
/* History: 2016-07-01
/*          Script erstellen
/*------------------------------------------------------------------------------------------------*/

/* OBJECT-TYPE -----------------------------------------------------------------------------------*/

delete
from SDDL$V_DICT_VALID_OBJECT_TYPE;

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'GENERATOR',
  'Object-Type für Sequencen'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DOMAIN',
  'Object-Type für Domains'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'PRIMARYKEY',
  'Object-Type für Primärschlüssel'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'COLUMN',
  'Object-Type für Spalten'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'TRIGGER',
  'Object-Type für Trigger'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'UNIQUEKEY',
  'Object-Type für Uniqe-Constraints'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'FOREIGNKEY',
  'Object-Type für Fremdschlüssel'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'VIEW',
  'Object-Type für Views'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'RELATION',
  'Object-Type für n:m Beziehungen'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'REORG_COLUMN',
  'Object-Type für das Reorganisieren von Spalten'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_OBJECT_TYPE
(
  CAPTION,
  DESCRIPTION
)
values
(
  'CATALOG',
  'Object-Type für das Erstellen von Katalogen'
)
matching(CAPTION);

COMMIT WORK;
/* COMMAND ---------------------------------------------------------------------------------------*/

delete
from SDDL$V_DICT_VALID_COMMAND;

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-STDS',
  'Es werden keine Standardsequencen erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-STDD',
  'Es werden keine Standarddomains erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-STDP',
  'Es wird kein Standardprimärschlüssel erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '+STDF',
  'Es wird ein Standardfeld erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-STDF',
  'Es wird kein Standardfeld erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'UNIQUE.KEY',
  'Es wird ein Unique-Constraint erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'UKEY.MEMBER',
  'Feld ist mit anderen Feldern Teil eines Unique-Constraint'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'IDX',
  'Es wird ein Index erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'IDX.UINQUE',
  'Es wird ein eindeutiger Index erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'FK',
  'Es wird ein Fremdschlüssel erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'FK.MEMBER',
  'Es wird ein Fremdschlüssel aus mehreren Feldern erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-STDV',
  'Es wird keine Standardview erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'N:M',
  'Es wird eine n:m-Beziehung erzeugt'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  '-CHKRK',
  'Tabellen- oder Feldname wird nicht auf Gültigkeit geprüft'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'REORG',
  'Tabellene reorganisieren'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_COMMAND
(
  CAPTION,
  DESCRIPTION
)
values
(
  'POS',
  'Position eines Feldes in einer Tabelle'
)
matching(CAPTION);

COMMIT WORK;
/* COMMAND ---------------------------------------------------------------------------------------*/

delete
from SDDL$V_DICT_VALID_ARGUMENT;

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'ASC',
  'Aufsteigend sortieren'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DESC',
  'Absteigend sortieren'
)
matching(CAPTION);


/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DCUC',
  'DELETE CASCADE UPDATE CASCADE'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DNUC',
  'DELETE SET NULL UPDATE CASCADE'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DNUN',
  'DELETE SET NULL UPDATE SET NULL'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DCUN',
  'DELETE CASCADE UPDATE SET NULL'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'DRUR',
  'DELETE RESTRICT UPDATE RESTRICT'
)
matching(CAPTION);

/* ------ */

update or insert
into 
SDDL$V_DICT_VALID_ARGUMENT
(
  CAPTION,
  DESCRIPTION
)
values
(
  'R',
  'Recursive'
)
matching(CAPTION);

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------*/