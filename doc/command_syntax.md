SDDL-Befehl Referenz
====================
Befehlssyntax für *simplifyDDL* der Version: v0.9-M1


Folgende Zeichen dürfen verwendet werden
----------------------------------------

- Buchstaben: `A..Z`
- Zahlen: `0..9`
- Zusätzlich: `{ } : = . ; + - %` 
- Buchstaben immer groß schreiben
- keine Umlaute, Umlatue entsprechend auflösen (z.B.: Ä = AE) 
- kein scharfes S, scharfes S entsprechend auflösen (ß = SS)


Allgemeine Regeln
-----------------

- Ein Befehl wird in { } eingebettet      
Beispiel: `{FK:=<TABELLE>.<FELDNAME>;0:DCUC}`

- Befehle können in einem Kommentar verkettet werden      
Beispiel: `{UNIQUE.KEY:=%%<UNIQUEKEY>%%}{IDX:=%%<INDEX>%%;0:DESC}` 

- Wertzuweiseungen werden mit := dargestellt (Pascal-Syntax)       
Beispiel: `{FK:=TABELLE.ID}`

- Anweisungen in einem Befehl werden mit einem Semikolon getrennt       
Beispiel: `{FK:=TABELLE.ID;0:DCUC}`

- Zusätzliche Anweisungen in einem Befehl werden mit einem nullbasierten Index 
versehen       
Beispiel: `{FK:=<TABELLE>.<FELDNAME>;0:DCUC} -> 0:DCUC`

- Der Index wird mit einem : der Anweisung zugewiesen      

- Der Index für zustäzliche Anweisungen ist immer konstant, egal in welcher 
Reihenfolge die Anweisungen eingetragen werden oder ob Anweisungen nur teilweise
verwendet werden       
Beispiel: `{FK:=TABELLE.ID;0:DCUC} -> 0:DCUC -> 0 bleibt immer mit der Anweisung DCUC verbunden`  

- Wahlweise kann auf die Zuweisung des Index zur Anweisung verzichtet werden. In dem Fall wird
der Index aus dem statischen Dictionary ermittelt     
Beispiel: `{FK:=TABELLE.ID;DCUC} -> DCUC -> Index 0 nicht angegeben, wird vom Parser aus dem statischen Dictionary ermittelt`

- Die direkte Zuweisung benötigt keinen Index       
Beispiel: `{FK:=<TABELLE>.<FELDNAME>;0:DCUC} -> FK:=<TABELLE>.<FELDNAME>`

- Bezeichnungen werden in doppelten % eingebettet, ein Bezeichner kann bis zu 64 Zeichen lang sein      
Beispiel: `{UNIQUE.KEY:=%%<UNIQUEKEY>%%} -> %%<UNIQUEKEY>%% -> <UNIQUEKEY> ist die Bezeichnung` 



Standardaufgaben
----------------

* Sequences einrichten
  * Im Tabellenkommentar:
      * `{-STDS}` = Es werden keine Standardsequencen für die Tabelle erzeugt     
  * Im Feldkommentar:
      * Keine Befehle vorgesehen     

* Domains einrichten      
  * Im Tabellenkommentar:
      * `{-STDD}` = Es werden keine Standarddomains für die Tabelle erzeugt     
  * Im Feldkommentar:
      * Keine Befehle vorgesehen     

* Primärschlüssel einrichten
  * Im Tabellenkommentar:
      * `{-STDP}` = Es wird keine Standardprimärschlüssel erzeugt                 
      * `{PK:=%%PRIMARYKEY%%}` = Es wird in den Kommentaren der Tabellenfelder nach Members für einen
          * `%%PRIMARYKEY%%` = Bezeichnung nach der in den Feldkommentaren gesucht werden soll       
          * Nur wirksam wenn `-STDP` gesetzt wurde
  * Im Feldkommentar:
      * `{PK}` = Feld wird als Primärschlüssel eingerichtet
          * Nur wirksam wenn `-STDP` gesetzt wurde
      * `{PK:=%%PRIMARYKEY%%}` = Feld ist mit anderen Feldern Teil eines Primärschlüssel mit der selben Bezeichnung        
          * Nur wirksam wenn `-STDP` gesetzt wurde
        
* Standardfelder ergänzen            
  * Im Tabellenkommentar: 
      * `{+STDF=%%<STANDARDFELDNAME>%%}` = Es wird nur das angegebene Standardfeld eingerichtet      
      * `{-STDF}` = Es wird kein Standardfeld eingetragen 
      * `{-STDF=%%<STANDARDFELDNAME>%%}` = Es werden alle Standardfelder bis auf das angegebene Feld eingerichtet  
  * Im Feldkommentar:
      * Keine Befehle vorgesehen

* Trigger einrichten         
  * Im Tabellenkommentar:
      * `{-STDT}` = Es werden keine Standardtrigger für die Tabelle erzeugt     
  * Im Feldkommentar:
      * Keine Befehle vorgesehen     

* Unique Keys einrichten     
  * Im Tabellenkommentar:
      * `{UNIQUE.KEY:=%%<UNIQUEKEY>%%;0:ASC}` = Es wird in den Kommentaren der Tabellenfelder nach Members für einen Unique Key Constraint gesucht
          * `%%<UNIQUEKEY>%%` = Bezeichnung nach der in den Feldkommentaren gesucht werden soll        
          * `0:ASC` = Index 0 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 0 vorhanden)
              * `DESC` = absteigend 
  * Im Feldkommentar:
      * `{UNIQUE.KEY;0:ASC}` = für das Feld wird ein Unique Key Constraint eingerichtet
          * `0:ASC` = Index 0 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 0 vorhanden)
              * `DESC` = absteigend 
      * `{UKEY.MEMBER:=%%<UNIQUEKEY>%%}` = Feld ist mit anderen Feldern Teil eines Unique Key Constraint mit der selben Bezeichnung   

* Indices einrichten             
  * Im Tabellenkommentar:
      * `{IDX:=%%<INDEX>%%;0:ASC}` = Es wird in den Kommentaren der Tabellenfelder nach Members für einen einfachen Index gesucht, absteigend sortiert
      * `{IDX.UNIQUE:=%%<INDEX>%%;0:ASC}` = Es wird in den Kommentaren der Tabellenfelder nach Members für einen eindeuitgen Index gesucht, absteigend sortiert
          * `%%<INDEX>%%` = Bezeichung für einen Index der in den Feldkommentaren gesucht wird 
          * `0:ASC` = Index 0 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 0 vorhanden)
              * `DESC` = absteigend                
  * Im Feldkommentar:
      * `{IDX;0:ASC}` = Für das Feld wird ein einfacher Index angelegt, aufsteigend sortiert
      * `{IDX.UNIQUE;0:ASC}` = Für das Feld wird ein eindeutiger Index angelegt, aufsteigend sortiert    
          * `0:ASC` = Index 0 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 0 vorhanden)
              * `DESC` = absteigend 
      * `{IDX.MEMBER:=%%<INDEX>%%}` = Feld ist mit anderen Felder Teil eines Index mit der selben Bezeichnung   

* Foreign Keys einrichten             
  * Im Tabellenkommentar:
      * `{FK:=%%FOREIGNKEY%%;0:<TARGETTABLE>;1:DCUC;2:ASC}` = Es wird in den Kommentaren der Tabellenfeldern nach Members für einen Fremdschlüssel gesucht
          * `%%FOREIGNKEY%%` = Bezeichnung für einen Fremdschlüssel der in den Felderkommentaren gesucht wird
          * `0:<TARGETTABLE>` = Index 0 bestimmt die Zieltabelle für den Fremdschlüssel
          * `1:DCUC` = Index 1 beschreibt das Verhalten bei Änderungen des Primärschlüssels
              * `DCUC` = DELETE CASCADE UPDATE CASCADE (Standard wenn keine Anweisung mit dem Index 1 angegeben)
              * `DNUC` = DELETE SET NULL UPDATE CASCADE
              * `DNUN` = DELETE SET NULL UPDATE SET NULL
              * `DCUN` = DELETE CASCADE UPDATE SET NULL
              * `DRUR` = DELETE RESTRICT UPDATE RESTRICT
          * `2:ASC` = Index 2 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 2 vorhanden)
              * `DESC` = absteigend                                                                   
  * Im Feldkommentar:
      * `{FK:=<TARGETTABLE>.<TARGETFIELD>;=0:DCUC;1:ASC}` = Auf dem Feld wird ein Fremdschlüssel für das angegebene Zielfeld angelegt
          * `<TARGETTABLE>` = Name der Zieltabelle mit dem Primärschlüssel 
          * `<TARGETFIELD>` = Name des Feldes (Primärschlüssel der Zieltabelle)                
          * `0:DCUC` = Index 0 beschreibt das Verhalten bei Änderungen des Primärschlüssels            
              * `DCUC` = DELETE CASCADE UPDATE CASCADE (Standard wenn keine Anweisung mit dem Index 0 angegeben)
              * `DNUC` = DELETE SET NULL UPDATE CASCADE
              * `DNUN` = DELETE SET NULL UPDATE SET NULL
              * `DCUN` = DELETE CASCADE UPDATE SET NULL
              * `DRUR` = DELETE RESTRICT UPDATE RESTRICT
          * `1:ASC` = Index 1 beschreibt die Sortierreihenfolge des Index 
              * `ASC` = aufsteigend (Standard wenn keine Anweisung mit dem Index 1 vorhanden)
              * `DESC` = absteigend
      * `{FK.MEMBER=%%FOREIGNKEY%%;0:<TARGETFIELD>}` = Feld ist mit anderen Felder Teil eines Fremdschlüssels mit der selben Bezeichnung
          * `%%FOREIGNKEY%%` = Bezeichnung für einen Fremdschlüssel der im Tabellenkommentar beschreiben wird
          * `0:<TARGETFIELD>` = Index 0 bestimmt das Zielfeld für den Fremdschlüssel 

* Standardviews einrichten             
  * Im Tabellenkommentar:
      * `{-STDV}` = Es wird keine Standardview für die Tabelle erzeugt
  * Im Feldkommentar:
      * Keine Befehle vorgesehen

* m:n Verbindungen realisieren             
  * Im Tabellenkommentar:
      * `{M:N:=%%M:N%%}` = Es wird in den Kommentaren anderer Tabellen nach dem m:n Namen gesucht
          * `%%M:N%%` = Bezeichnung für eine M:N Verbindung nach der in anderen Tabellenkommentaren gesucht werden soll 
              * nur zwei Tabellen können eine M:N Verbindung herstellen                   
  * Im Feldkommentar:
      * `{M:N}` = Das Feld wird als Fremdschlüssel in der n:m Beziehungstabelle verwendet          

* Reservierte Keywords prüfen             
  * Im Tabellenkommentar:
      * `{-CHKRK;0:R}` = Tabellenname wird nicht geprüft
          * `0:R` = Index 0 verhindert auch die Prüfung der Feldnamen        
  * Im Feldkommentar:
      * `{-CHKRK}` = Feldname wird nicht geprüft   

* Tabelle reorganisieren
  * Im Tabellenkommentar:
      * `{REORG}` = Reorganisiert eine Tabelle nach den Positionsangaben in den Kommentaren der Felder   
  * Im Feldkommentar: 
      * `{POS:=<new_pos>}` = Neu Position für das Feld innerhalb der Tabelle

* Lookuptabellen einrichten
  * Im Tabellenkommentar:
      * Keine Befehle vorgesehen   
  * Im Feldkommentar: 
      * Keine Befehle vorgesehen                    
