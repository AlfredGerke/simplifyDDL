SDDL Codereferenz
=================
Codereferenz für *simplifyDDL* der Version: v0.9-M1

Die Codereferenz beschreibt die Standard-DDL-Syntax welche im Code Dictionary hinterlegt wird.
Die Referenz orientiert sich an den Standardaufgaben, welche von *simplifyDDL* unter zuhilfenahme der
SDDL-Befehle selbständig ausgeführt wird. 

Standardaufgaben
----------------

* Sequences einrichten
  * DDL-Code: `CREATE SEQUENCE %%SEQUENCE_NAME%%;`
  * DDL-Code Kommentar: `COMMENT ON SEQUENCE %%SEQUENCE_NAME%% IS '%%COMMENT%%'`
  * Aufbau %%SEQUENCE_NAME%%: `%%PREFIX%%_%%CAPTION%%_%%SUFFIX%%`  
  * Objectype: *GENERATOR*

* Domains einrichten      
  * DDL-Code: s. SDDL$CODE_DEFAULT_DOMAIN
  * DDL-Code Kommentar: s. SDDL$CODE_DEFAULT_DOMAIN
  * Aufbau %%DOMAINE_NAME%%: `%%PREFEIX%%_%%CAPTION%%`
  * Objecttype: *DOMAIN*                           

* Primärschlüssel einrichten
  * DDL-Code: `ALTER TABLE %%TABLE_NAME%% ADD CONSTRAINT %%PK_CONSTRAINT_NAME%% PRIMARY KEY (%%COLUMN_LIST%%)` 
  * DDL-Code Kommentar: ---
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`
  * Aufbau %%PK_CONSTRAINT_NAME%%: `%%PRRFIX%%_%%TABLE%%_%%SUFFIX%%`
  * Objecttype: *PRIMARYKEY*                             
        
* Standardfelder ergänzen 
  * DDL-Code: ALTER TABLE %%TABLE_NAME%% ADD %%STD_FIELD%% %%DATA_TYPE%%;
  * DDL-Code Kommentar: `COMMENT ON COLUMN %%TABLE_NAME%%.%%STD_FIELD%% IS '%%COMMENT%%'`
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`              
  * %%STD_FIELD%%: s. SDDL$CODE_DEFAULT_FIELD 
  * %%DATA_TYPE%%: s. SDDL$CODE_DEFAULT_DOMAIN
  * Objecttype: *COLUMN*    

* Trigger einrichten         
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *TRIGGER*

* Unique Keys einrichten     
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *UNIQUEKEY*   

* Indices einrichten             
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *INDEX*

* Foreign Keys einrichten
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *FOREIGNKEY*             

* Standardviews einrichten 
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *VIEW*            

* m:n Verbindungen realisieren
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *RELATION*              

* Reservierte Keywords prüfen

* Tabelle reorganisieren
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *REORG_COLUMN*

* Lookuptabellen einrichten
  * DDL-Code: 
  * DDL-Code Kommentar:
  * Objecttype: *CATALOG*
