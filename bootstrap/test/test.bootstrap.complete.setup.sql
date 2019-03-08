/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-02-22                                                        
/* Description: Setup f�r einzelnen Testfall    
/*                                                                              
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
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

COMMENT ON COLUMN TEST_1.CAPTION
IS '{UNIQUE.KEY} Dies ist ein Kommentar f�r das Feld CAPTION';
                  
COMMENT ON COLUMN TEST_1.COUNTER
IS '{UNIQUE.IDX} Dies ist ein Kommentar f�r das Feld COUNTER';                 

---

CREATE TABLE TEST_2 (
  ID DN_IDENTIFICATION,
  CAPTION DN_CAPTION,
  FK_CAPTION DN_CAPTION,
  COUNTER DN_COUNT
);                                

COMMENT ON COLUMN TEST_2.CAPTION
IS '{UNIQUE.KEY} Dies ist ein Kommentar f�r das Feld CAPTION';
                  
COMMENT ON COLUMN TEST_2.FK_CAPTION
IS '{FK:=TEST_1.CAPTION;DCUC} Dies ist ein Kommentar f�r das Feld FK_CAPTION';

COMMENT ON COLUMN TEST_2.COUNTER
IS '{UNIQUE.IDX} Dies ist ein Kommentar f�r das Feld COUNTER';                 
                                                                                  
COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/