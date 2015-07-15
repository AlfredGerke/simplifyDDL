Sourcen
=======

Alle Scripte zur Entwicklung von *simplifyDDL*  

- make_sDDL.bat            
Startet _make.bat mit Parametern: 
  - Erster Parameter: ISQL (+Pfad) 
  - Zweiter Parameter: Name der Logdatei 
  - Dritter Parameter (Opitional = *): Erstellt eine Entwicklungsdatenbank

- _make.bat            
Mit Hilfe der übergebenen Parameter wird SDDL über ISQL installiert. Wurde der 3. Parameter übergeben wird eine Entwicklungsdatenbank erstellt

- create_db.sql     
Erstellt eine Entwicklungsdatenbank

- batch.sql     
Setzt alle Settings für ISQL, stellt die Verbindung zur Datenbank her und installiert sDDL

- create sequences.sql     
Erstellt alle notwendigen Sequences (Generatoren)

- create_domains.sql             
Erstellt alle notwendigen Domains

- create_static_dict.sql     
Erstellt das statische Dictionary: Tabellen, Trigger, Views, StoredProcedures, etc.

- create_dynamic_dict.sql     
Erstellt das dynamische Dictionary: Tabellen, Trigger, Views, StoredProcedures, etc.
