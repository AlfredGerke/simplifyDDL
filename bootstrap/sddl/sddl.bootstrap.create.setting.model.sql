/*------------------------------------------------------------------------------------------------*/
/* ### Description: 
/*   * Es wird das Model für Settings angelegt   
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

/* ---------------------------------------------------------------------------------------------- */
CREATE GLOBAL TEMPORARY TABLE TBT_SETTING (
  CATEGORY_NAME DN_CATEGORY NOT NULL,
  SECTION_NAME  DN_CATEGORY_SECTION NOT NULL,
  IDENT         DN_CATEGORY_IDENT NOT NULL,
  STRING_VALUE  DN_CATEGORY_STRING_VALUE NOT NULL
)
on commit delete rows;

COMMENT ON TABLE TBT_SETTING 
IS 'Temporäre Datenbank INI-Datei';

COMMENT ON COLUMN TBT_SETTING.CATEGORY_NAME
IS 'Name der DB-Inidatei';

COMMENT ON COLUMN TBT_SETTING.SECTION_NAME
IS 'Section (vergleichbar mit einer Ini-Datei)';

COMMENT ON COLUMN TBT_SETTING.IDENT
IS 'Ident (vergleichbar mit einer Ini-Datei)';

COMMENT ON COLUMN TBT_SETTING.STRING_VALUE
IS 'Value (vergleichbar mit einer Ini-Datei)';

/*
  ## Problem mit der Schlüsselgröße
    * s. http://www.firebirdfaq.org/faq211/
    * s. http://www.firebirdfaq.org/ip_ib_indexcalculator.htm
*/
         
ALTER TABLE TBT_SETTING ADD CONSTRAINT UNQ_TBT_SETTING UNIQUE (CATEGORY_NAME, SECTION_NAME, IDENT);

COMMIT WORK;
/* ---------------------------------------------------------------------------------------------- */

CREATE VIEW VW_T_SETTING (
  CATEGORY_NAME,
  SECTION_NAME,
  IDENT,
  STRING_VALUE)
AS
select
  CATEGORY_NAME,
  SECTION_NAME,
  IDENT,
  STRING_VALUE
from
  TBT_SETTING;

COMMENT ON VIEW VW_T_SETTING 
IS 'Temporäre Standard Update-View für die Tabelle TBT_SETTING';

COMMIT WORK;
/* ---------------------------------------------------------------------------------------------- */

CREATE TABLE TB_SETTING (
  CATEGORY_NAME DN_CATEGORY NOT NULL,
  SECTION_NAME  DN_CATEGORY_SECTION NOT NULL,
  IDENT         DN_CATEGORY_IDENT NOT NULL,
  STRING_VALUE  DN_CATEGORY_STRING_VALUE NOT NULL
);

COMMENT ON TABLE TB_SETTING 
IS 'Datenbank INI-Datei';

COMMENT ON COLUMN TB_SETTING.CATEGORY_NAME
IS 'Name der DB-Inidatei';

COMMENT ON COLUMN TB_SETTING.SECTION_NAME
IS 'Section (vergleichbar mit einer Ini-Datei)';

COMMENT ON COLUMN TB_SETTING.IDENT
IS 'Ident (vergleichbar mit einer Ini-Datei)';

COMMENT ON COLUMN TB_SETTING.STRING_VALUE
IS 'Value (vergleichbar mit einer Ini-Datei)';

/*
  ## Problem mit der Schlüsselgröße
    * s. http://www.firebirdfaq.org/faq211/
    * s. http://www.firebirdfaq.org/ip_ib_indexcalculator.htm
*/
         
ALTER TABLE TB_SETTING ADD CONSTRAINT UNQ_TB_SETTING UNIQUE (CATEGORY_NAME, SECTION_NAME, IDENT);

COMMIT WORK;
/* ---------------------------------------------------------------------------------------------- */

CREATE VIEW VW_SETTING (
  CATEGORY_NAME,
  SECTION_NAME,
  IDENT,
  STRING_VALUE)
AS
select
  CATEGORY_NAME,
  SECTION_NAME,
  IDENT,
  STRING_VALUE
from
  TB_SETTING;

COMMENT ON VIEW VW_SETTING 
IS 'Standard Update-View für die Tabelle TB_SETTING';

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/