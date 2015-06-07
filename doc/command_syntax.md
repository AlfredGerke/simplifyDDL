Befehlssyntax
=============

Befehlssyntax für *simplifyDDL* der Version: v0.9-M1


Folgende Zeichen dürfen verwendet werden
----------------------------------------

- Buchstaben: A..Z
- Zahlen: 0..9
- Zusätzlich: {, }, :, =, ;, +, - 
- Buchstaben immer groß schreiben
- keine Umlaute, Umlatue entsprechend auflösen (z.B.: Ä = AE) 
- kein scharfes S, scharfes S entsprechend auflösen (ß = SS)


Allgemeine Regeln
-----------------

- Wertzuweiseungen werden mit := dargestellt (Pascal-Syntax) 
(z.B.: `FK:=TABELE.ID`)
- Anweisungen in einem Befehl werden mit einem Semikolon getrennt 
(z.B.: `FK:=TABELE.ID;0:DCUC')
- Zusätzliche Anweisungen in einem Befehl werden mit einem Nullbasierten Index 
versehen (z.B.: `FK:=<TABELLE>.<FELDNAME>;0:DCUC -> 0:DCUC`)
- Der Index wird mit einem : der Anweisung zugewiesen
- Der Index für zustäzliche Anweisungen ist immer konstant, egal in welcher 
Reihenfolge die Anweisungen eintragen werden oder ob Anweisungen nur teilweise
verwendet werden (z.B.: `FK:=TABELE.ID;0:DCUC -> 0:DCUC -> 0 bleibt immer mit der Anweisung DCUC verbunden`)  
- Die direkte Zuweisung benötigt keinen Index 
(z.B.: `FK:=<TABELLE>.<FELDNAME>;0:DCUC -> FK:=<TABELLE>.<FELDNAME>`)


Standardaufgaben
----------------

- Sequences einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- Domains einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- Primärschlüssel einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- Standardfelder ergänzen
  Standardfelder werden im statischen Dictionary definiert
  Die Befehle sind nur bedingt kombinierbar
  Im Tabellenkommentar: 
  * `+STDF=*` = Standard (muss nicht codiert werden)
  * `+STDF=<STANDARDFELDNAME>` = Es wird das angegebene Feld eingerichtet      
  * `-STDF=*` = Es wird kein Standardfeld eingetragen 
  * `-STDF=<STANDARDFELDNAME>` = Es werden alle Standardfelder bis auf das angegebene Feld eingerichtet  
  Im Feldkommentar:
  * Keine Befehle vorhanden
  
- Trigger einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- Unique Keys einrichten
  Im Tabellenkommentar:
  * `UNIQUE.KEY:=<UNIQUEKEY>` = Es wird in den Tabellenfeldern nach Members für eine Unique Key Constraint gesucht 
  Im Feldkommentar:
  * `UNIQUE.KEY` = für das Feld wird ein Unique Key Constraint eingerichtet
  * `UNIQUE.KEY:=<INDEXNAME>` = Feld ist mit anderen Feldern Teil eines Unique Key Constraint   
  
- Indices einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  * `IDX` = Für das Feld wird ein einfacher Index angelegt
  * `IDX:=DESC` =   
  * `IDX.UNIQUE` = Für das Feld wird ein eindeutiger Index angelegt    
  * `IDX.UNIQUE:=DESC` =   
  
- Foreign Keys einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- Standardviews einrichten
  Im Tabellenkommentar:
  Im Feldkommentar:
  
- n:m Verbindungen realisieren
  Im Tabellenkommentar:
  Im Feldkommentar: 

- Reservierte Keywords prüfen
  Im Tabellenkommentar:
  Im Feldkommentar: