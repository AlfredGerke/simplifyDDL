/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Setup für einzelnen Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung für FB 3.0x   
/* - Das Script ist für die Ausführung im ISQL erstellt worden
/* - Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-02-22
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/* Setup: Testfall einrichten --------------------------------------------------------------------*/   

CREATE TABLE TEST_1 (
  ID DN_IDENTIFICATION,
  CAPTION DN_CAPTION,
  COUNTER DN_COUNT
);                                

/* Der sDDL-Befehl: {UNIQUE.KEY} erzeugt durch die SP: PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS einen Unique-Key-Constraint */
COMMENT ON COLUMN TEST_1.CAPTION
IS '{UNIQUE.KEY} Dies ist ein Kommentar für das Feld CAPTION';

/* Der sDDL-Befehl: {UNIQUE.IDX} erzeugt durch die SP: PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS einen Unique-Index */                  
COMMENT ON COLUMN TEST_1.COUNTER
IS '{UNIQUE.IDX} Dies ist ein Kommentar für das Feld COUNTER';                 

---

CREATE TABLE TEST_2 (
  ID DN_IDENTIFICATION,
  CAPTION DN_CAPTION,
  FK_CAPTION DN_CAPTION,
  COUNTER DN_COUNT
);                                

/* Der sDDL-Befehl: {UNIQUE.KEY} erzeugt durch die SP: PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS einen Unique-Key-Constraint */
COMMENT ON COLUMN TEST_2.CAPTION
IS '{UNIQUE.KEY} Dies ist ein Kommentar für das Feld CAPTION';
              
/* 
  Der sDDL-Befehl: {FK:=TEST_1.CAPTION;DCUC} erzeugt durch die SP: PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS einen Foreign-Key-Constraint.
  Der Parameter DCUC legt die Bedinung Delete Cascade/ Update Cascade an.
  Mögliche Parameter:
    FK:=           = leitet die Anweisung zum Erstellen eines Foreigen-Key-Constraint ein
    TEST_1.CAPTION = Tabellen- und Feldnamen mit dem Primär-Key bzw. dem Unique-Key-Constraint 
    DCUC           = delete cascade / update casade
    DNUC           = delete set null / update casade
    DNUN           = delete set null / update set null
    DCUN           = delete cascade / update set null  
*/                  
COMMENT ON COLUMN TEST_2.FK_CAPTION
IS '{FK:=TEST_1.CAPTION;DCUC} Dies ist ein Kommentar für das Feld FK_CAPTION';

/* Der sDDL-Befehl: {UNIQUE.IDX} erzeugt durch die SP: PKG_SDDL.SP_CREATE_ALL_CONSTRAINTS einen Unique-Index */
COMMENT ON COLUMN TEST_2.COUNTER
IS '{UNIQUE.IDX} Dies ist ein Kommentar für das Feld COUNTER';                 
                                                                                  
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/