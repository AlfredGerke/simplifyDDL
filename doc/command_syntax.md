Befehlssyntax
=============

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
Beispiel: `{FK:=TABELE.ID}`

- Anweisungen in einem Befehl werden mit einem Semikolon getrennt       
Beispiel: `{FK:=TABELE.ID;0:DCUC}`

- Zusätzliche Anweisungen in einem Befehl werden mit einem Nullbasierten Index 
versehen       
Beispiel: `{FK:=<TABELLE>.<FELDNAME>;0:DCUC} -> 0:DCUC`

- Der Index wird mit einem : der Anweisung zugewiesen      

- Der Index für zustäzliche Anweisungen ist immer konstant, egal in welcher 
Reihenfolge die Anweisungen eintragen werden oder ob Anweisungen nur teilweise
verwendet werden       
Beispiel: `{FK:=TABELE.ID;0:DCUC -> 0:DCUC} -> 0:DCUC -> 0 bleibt immer mit der Anweisung DCUC verbunden`  

- Die direkte Zuweisung benötigt keinen Index       
Beispiel: `{FK:=<TABELLE>.<FELDNAME>;0:DCUC} -> FK:=<TABELLE>.<FELDNAME>`

- Bezeichnungen werden in doppelten % eingebettet      
Beispiel: `{UNIQUE.KEY:=%%<UNIQUEKEY>%%} -> %%<UNIQUEKEY>%% -> <UNIQUEKEY> ist die Bezeichnung` 



Standardaufgaben
----------------

 1. Sequences einrichten
    * Im Tabellenkommentar:
    * Im Feldkommentar:
  
 2. Domains einrichten      
    * Im Tabellenkommentar:
    * Im Feldkommentar:
  
 3. Primärschlüssel einrichten
    * Im Tabellenkommentar:
    * Im Feldkommentar:
  
 4. Standardfelder ergänzen            
    Standardfelder werden im statischen Dictionary definiert        
    Die Befehle sind nur bedingt kombinierbar        
    * Im Tabellenkommentar: 
        * `+STDF=*` = Standard (muss nicht codiert werden)
        * `+STDF=%%<STANDARDFELDNAME>%%` = Es wird das angegebene Feld eingerichtet      
        * `-STDF=*` = Es wird kein Standardfeld eingetragen 
        * `-STDF=%%<STANDARDFELDNAME>%%` = Es werden alle Standardfelder bis auf das angegebene Feld eingerichtet  
    * Im Feldkommentar:
        * Keine Befehle vorgesehen
  
 5. Trigger einrichten     
    * Im Tabellenkommentar:
    * Im Feldkommentar:
  
 6. Unique Keys einrichten     
    * Im Tabellenkommentar:
        * `UNIQUE.KEY:=%%<UNIQUEKEY>%%` = Es wird in den Tabellenfeldern nach Members für einen Unique Key Constraint gesucht 
    * Im Feldkommentar:
        * `UNIQUE.KEY` = für das Feld wird ein Unique Key Constraint eingerichtet
        * `UKEY.MEMBER:=%%<INDEXNAME>%%` = Feld ist mit anderen Feldern Teil eines Unique Key Constraint   
  
 7. Indices einrichten     
    * Im Tabellenkommentar:
        * `IDX:=%%<INDEX>%%` = Es wird in den Tabellenfeldern nach Members für einen einfachen Index gesucht, aufsteigend sortiert
        * `IDX:=%%<INDEX>%%;0:DESC` = Es wird in den Tabellenfeldern nach Members für einen einfachen Index gesucht, absteigend sortiert
        * `IDX.UNIQUE:=%%<INDEX>%%` = Es wird in den Tabellenfeldern nach Members für einen eindeuitgen Index gesucht, aufsteigend sortiert
        * `IDX.UNIQUE:=%%<INDEX>%%;0:DESC` = Es wird in den Tabellenfeldern nach Members für einen eindeuitgen Index gesucht, absteigend sortiert         
    * Im Feldkommentar:
        * `IDX` = Für das Feld wird ein einfacher Index angelegt, aufsteigend sortiert
        * `IDX:=DESC` = Für das Feld wird ein einfacher Index angelegt, absteigend sortiert   
        * `IDX.UNIQUE` = Für das Feld wird ein eindeutiger Index angelegt, aufsteigend sortiert    
        * `IDX.UNIQUE:=DESC` = Für das Feld wird ein eindeutiger Index angelegt, absteigend sortiert
        * `IDX.MEMBER:=%%<INDEX>%%`    
  
 8. Foreign Keys einrichten     
    * Im Tabellenkommentar:
    * Im Feldkommentar:
        * `FK:=<TARGETTABLE>.<TARGETFIELD>` = 
  
 9. Standardviews einrichten     
    * Im Tabellenkommentar:
        * `-STDVW` =
    * Im Feldkommentar:
        * Keine Befehle vorgesehen
  
10. n:m Verbindungen realisieren     
    * Im Tabellenkommentar:
    * Im Feldkommentar: 

11. Reservierte Keywords prüfen     
    * Im Tabellenkommentar:
    * Im Feldkommentar:
