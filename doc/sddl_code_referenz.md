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
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objectype: *GENERATOR*

* Domains einrichten      
  * DDL-Code: s. SDDL$CODE_DEFAULT_DOMAIN
  * DDL-Code Kommentar: s. SDDL$CODE_DEFAULT_DOMAIN
  * Aufbau %%DOMAINE_NAME%%: `%%PREFEIX%%_%%CAPTION%%`
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt   
  * Objecttype: *DOMAIN*                           

* Primärschlüssel einrichten
  * DDL-Code: `ALTER TABLE %%TABLE_NAME%% ADD CONSTRAINT %%PK_CONSTRAINT_NAME%% PRIMARY KEY (%%COLUMN_LIST%%) %%USING_INDEX%%` 
  * DDL-Code Kommentar: ---
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`
  * Aufbau %%PK_CONSTRAINT_NAME%%: `%%PRRFIX%%_%%TABLE%%_%%SUFFIX%%`
  * Default %%SUFFIX%%: Spaltenname des Primärschlüssel    
  * Objecttype: *PRIMARYKEY*                             
        
* Standardfelder ergänzen 
  * DDL-Code: ALTER TABLE %%TABLE_NAME%% ADD %%STD_FIELD%% %%DATA_TYPE%%;
  * DDL-Code Kommentar: `COMMENT ON COLUMN %%TABLE_NAME%%.%%STD_FIELD%% IS '%%COMMENT%%'`
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt                 
  * %%STD_FIELD%%: s. SDDL$CODE_DEFAULT_FIELD 
  * %%DATA_TYPE%%: s. SDDL$CODE_DEFAULT_DOMAIN
  * Objecttype: *COLUMN*    

* Trigger einrichten         
  * DDL-Code: 

    SET TERM ;    
        CREATE TRIGGER %%TRIGGER_NAME%% FOR %%TABLE_NAME%%    
        ACTIVE %%TRIGGER_EVENT_TIME%% %%TRIGGER_EVENT_TYPE%% POSITION %%TRIGGER_ORDER%%    
        AS     
        BEGIN     
             %%TRIGGER_CODE%%     
        END^    
    SET TERM ; ^     

  * Aufbau %%TRIGGER_NAME%%: `%%PREFIX%%_%%TABLE_NAME%%_%%SUFFIX%%`
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt   
  * Check %%TRIGGER_EVENT_TIME%%: BEFORE oder AFTER
  * Check %%TRIGGER_EVENT_TYPE%%: UPDATE, INSERT oder DELETE
  * Check %%TRIGGER_ORDER%%: 0..*             
  * DDL-Code Kommentar: `COMMENT ON %%TRIGGER_NAME%% IS '%%COMMENT%%'`
  * Objecttype: *TRIGGER*

* Unique Keys einrichten     
  * DDL-Code: `ALTER TABLE %%TABLE_NAME%% ADD CONSTRAINT %%UNQ_CONSTRAINT_NAME%% UNIQUE (%%COLUMN_LIST%%) %%USING_INDEX%%` 
  * DDL-Code Kommentar: ---
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%_%%SUFFIX%%`     
  * Aufbau %%UNQ_CONSTRAINT_NAME%%: `%%PRRFIX%%_%%TABLE%%`  
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *UNIQUEKEY*   

* Indices einrichten             
  * DDL-Code: `CREATE %%INDEX_TYPE%% INDEX %%INDEX_NAME%% ON %%TABLE_NAME%% (%%COLUMN_LIST%%)`;
  * DDL-Code Kommentar: `COMMENT ON INDEX %%INDEX_NAME%% IS '%%COMMENT%%'`
  * Aufbau %%INDEX_NAME%%: `%%PREFIX%%_%%TABLE_NAME%%_%%SUFFIX%%`
  * Aufbau %%TABLE_NAME%%: `%%PREFIX%%_%%CAPTION%%`     *   
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt
  * Check  %%INDEX_TYPE%%: UNIQUE oder Leerstring           
  * Objecttype: *INDEX*

* Foreign Keys einrichten
  * DDL-Code: 
  * DDL-Code Kommentar:
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *FOREIGNKEY*             

* Standardviews einrichten 
  * DDL-Code: 
  * DDL-Code Kommentar:
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *VIEW*            

* m:n Verbindungen realisieren
  * DDL-Code: 
  * DDL-Code Kommentar:
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *RELATION*              

* Reservierte Keywords prüfen

* Tabelle reorganisieren
  * DDL-Code: 
  * DDL-Code Kommentar:
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *REORG_COLUMN*

* Lookuptabellen einrichten
  * DDL-Code: 
  * DDL-Code Kommentar:
  * %%PREFIX%%: s. SDDL$DICT_SETTING - Section: PREFIX - Ident: entsprechend dem gewählten Objekt  
  * Objecttype: *CATALOG*