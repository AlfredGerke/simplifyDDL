/*------------------------------------------------------------------------------------------------*/
/* Author: Alfred Gerke (AGE)                                                  
/* Date: 2019-03-01                                                    
/* Description: Es wird das Model f�r das Styleguide-Package angelegt    
/*                                                                               
/*------------------------------------------------------------------------------------------------*/
/* - Das Script arbeitet mit Befehlen der SQL-Erweiterung f�r FB 3.0x   
/* - Das Script ist f�r die Ausf�hrung im ISQL erstellt worden
/* - Ein Datenbank-Connect wird vorausgesetzt
/*   
/*------------------------------------------------------------------------------------------------*/
/* History: 2019-03-01
/*          Script erstellen
/*   
/*------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------*/
select SUCCESS
from PKG_SDDL.SP_CREATE_CATALOG ('STYLEGUIDE_CHECK',
  'DN_DB_OBJECT',
  'Reservierte W�rter');
  
COMMIT WORK;  
/*------------------------------------------------------------------------------------------------*/

select SUCCESS
from PKG_SDDL.SP_CREATE_CATALOG ('STYLEGUIDE_KEYWORD',
  'DN_DB_OBJECT',
  'Ausgeschlossene StyleGuide-Elemente');

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  execute
  procedure
  PKG_HISTORY.SP_SET_UPDATE_INFO (0,
    0,
    'sddl.bootstrap.styleguide.model.create.sql',
    'Model f�r das Package Styleguie installiert');
END^        
SET TERM ; ^

COMMIT WORK;
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------*/