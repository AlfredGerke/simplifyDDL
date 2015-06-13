***(in Progress: Zielversion sDDL 0.9 M1)***

simplifyDDL (sDDL)
==================

Hilfsroutinen für Firebird (2.5.x) zur automatisierten Erstellung von DDL Syntax auf der 
Basis von bestehenden Tabellen.  

**Inhaltsübersicht:**

- Anmerkung zur Version
- Voraussetzungen
- Versionen
- zusätzliche Entwicklungsumgebungen
- Zielvorgabe 
- Realisierung


Anmerkung zur neuen Version
---------------------------

Die Version *sDDL 0.9 M1* ist die erste Version der Anwendung.
Es werden alle notwendigen Scripte und Beispiele eingeführt. 

Das in diesem Projekt beschriebene Vorgehen, Standardaufgaben bei der Datenmodelierung
teilweise oder komplett zu generieren, hat seinen Ursprung in dem Projekt [ZABonline](ZABonline "ZABonline - Einarbeitung in die Entwicklung von Web-Anwendugen mit WaveMaker").

ZABonline ist ein Testprojekt mit die Möglichkeiten von WaveMakter 6.7.0 austestet werden.

Im Zug dieser Entwicklung wurden dieverse [`SQL-Scripte`](ZABonline/tree/master/source/script/script "SQL-Scripte vom ZABonline") angelegt um die Datenbasis für das Projekt festzulegen.
Um die Arbeit zu vereinfachen wurden immer wiederkehrende Aufagaben vereinheitlicht, in einen Standard gebracht und von Hilfsroutinen teilweise oder komplett übernommen.

Diese Hilfsroutinen befinden sich in den Scripten [`create_tools.sql`](ZABonline/source/script/script/create_tools.sql "create_tools.sql") und [`create_hibernate_workaround.sql`](ZABonline/source/script/script/create_hibernate_workaround.sql "create_hibernate_workaround.sql"). 

Dieses Projekt soll das in ZABonline eingeführte Verfahren zur Generierung von DDL-Inhalten vereinfachen und erweitern.

Voraussetzungen
---------------

### Entwicklung unter Firebird
*simplifyDDL* wendet sich an Datenmodellentwickler für Firebird. 
Wann immer es sinnvoll erscheint, werden Sprachelemente genutzt, die speziell von Firebird zur Verfügung gestellt 
werden und nicht notwendigerweise in anderen Datenbanksystemen vorhanden sind.
Eine Ausweitung auf andere Datenbanksysteme ist in dieser Entwicklungsphase nicht
vorgesehen. Über folgenden Link: [Firebird Download](http://www.firebirdsql.org/en/firebird-2-5-4/ "Firebird Download")
kann die aktuellste Version für alle gängigen Plattformen bezogen werden. 

### SQL und PSQL   
Die Entwicklung in einer Firebird Datenbank mit SQL und PSQL sollte im Prinzip 
verstanden sein. Ein Anwender mit Grundkenntnissen wird keine Probleme haben sich
in die vorhandenen Sourcen einzuarbeiten. Über folgenden Link: [Firebird Manual](http://www.firebirdsql.org/en/reference-manuals/ "Firebird Manual")
können umfangreiche Dokumentationen (HTML und PDF) bezogen werden.  

### ISQL
ISQL gehört zum Lieferumfang einer Firebird Datenbank. Der Einsatz von ISQL sollte
im Prinzip verstanden sein (s. [Firebirds ISQL Interactive SQL tool](http://www.firebirdsql.org/file/documentation/reference_manuals/user_manuals/html/isql.html "Firebirds ISQL Interactive SQL tool")).
                          

Versionen
---------

* Firebird 2.5.x [Firebird Download](http://www.firebirdsql.org/en/firebird-2-5-4/ "Firebird Download")


zusätzliche Entwicklungsumgebungen
----------------------------------

* [ISQL](http://www.firebirdsql.org/manual/isql-interactive.html "ISQL-Commandlinetool")
* [FlameRobin](http://www.flamerobin.org/ "GUI für Datenbankentwurf/-entwicklung")
* [PSPad](http://www.pspad.com/de/ "PSPad – der ultimative Editor für Softwareentwickler")

### ISQL
ISQL ist Teil der Firebird Installation und dient der Administration der Datenbank. 
ISQL ist ein Commandlinetool, welches für Einzel- und/oder Batchoperationen verwendet werden kann.
Besonders die Verarbeitung von Scripten als Batch lässt sich gut mit ISQL realisieren.

### FlameRobin     
FlameRobin ist ein plattformübergreifendes Administrationstool für FireBird, welches (fast) alle Befehle, 
welche über den ISQL verarbeitet werden können, in einer GUI anbietet. Neben der Administration lässt sich 
FlameRobin sehr gut für die Entwicklung einsetzen. FlameRobin ist OpenSource und kann ohne
Bedenken eingesetzt werden.

### PSPad
Wenn man zum Commandlinetool (ISQL) und FlameRobin für die Entwicklung der Datenbank 
eine Ergänzung sucht, bietet sich PSPad an. PSPad ist ein freier unicode-fähiger 
Texteditor für Windows. Der Texteditor ist speziell für Softwareentwickler entworfen 
worden und unterstützt diverse Programmiersprachen, darunter auch SQL. PSPad ist 
Freeware und kann ohne Bedenken eingesetzt werden.   


Zielvorgabe
-----------

Bei *simplifyDDL* handelt es sich um ein Sammlung von StoredProcedures, sowie 
eines Workflow um auf der Basis einer Tabelle notwendige DDL Syntax automatisch 
erstellen zu können.

Zu diesem Zweck wird ein Befehlssatz eingeführt, der in den Kommentaren einer Tabelle
und deren Felder eingebettet wird.

Diese Befehl werden ausgelesen, es wird ein Dictionary erstellt, auf der Grundlage des
Dictionary wird ein Script mit der gewünschten DDL Syntax erstellt.

Ziel ist es, beim Entwurf eines Datenbankmodells auf schnelle Art ein lauffähiges 
Ergebnis zu erhalten, ohne sich dabei um Standardaufgaben kümmern zu müssen.

**Standardaufgaben:**

- Sequences einrichten
- Domains einrichten
- Primärschlüssel einrichten
- Standardfelder ergänzen
- Trigger einrichten
- Unique Keys einrichten
- Indices einrichten
- Foreign Keys einrichten
- Standardviews einrichten
- n:m Verbindungen realisieren
- Reservierte Keywords prüfen
- Tabelle reorganisieren
- Lookuptabellen einrichten

### Sequences einrichten
Für Primärschlüssel (Standardfeld `<ID>`) werden Sequences angelegt. 
Das Feld `<ID>` wird als Standardfeld für Primärschlüssel vorgesehen.
Im statischen Dictionary wird der Präfix für Sequences festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Domains einrichten
Für Standardfelder werden Domainen angelegt. (z.B.: `<PREFIX>_CURRENT_USER` für das Standardfeld `CRE_USER`)
Im statischen Dictionary wird der Präfix für Domains festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Standardfelder ergänzen
Im statischen Dictionary festgelegte Standardfelder werden ausgelesen und in einer Tabelle ergänzt (z.B. `CRE_USER` oder `<ID>`).  
Wenn nötig werden Standarddomains erstellt.
Im statischen Dictionary werden für bestimmte Standardfelder der Feldname festgelegt (z.B. `<ID>` für den Primärschlüssel) 

### Trigger einrichten
Für das initialisieren von Primärschlüssel und Standardfelder werden Tabellentrigger eingerichtet.
(z.B.: `<PREFIX>_<TRIGGER_NAME>_BI0` für den Primärschlüssel)
Im statischen Dictionary wird der Präfix für Trigger festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Unique Keys einrichten
Für Unique Keys werden die notwendigen Constraints erstellt.
Im statischen Dictionary wird der Präfix für Unique Key Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Indices einrichten
Für Indices werden die notwendigen Constraints erstellt.
Im statischen Dictionary wird der Präfix für Indices Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Foreign Keys einrichten
Für Foreign Keys werden die notwendigen Constraints erstellt.
Im statischen Dictionary wird der Präfix für Foreign Key Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Standardviews einrichten
Für jede Tabelle wird wird ein Standardview erstellt.
Im statischen Dictionary wird der Präfix für Standardviews festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### n:m Verbindungen realisieren
Es wird eine zusätzliche Tabelle mit den Primärschlüssel zweier verschiedener Tabellen aus Foreign Keys eingerichtet.
Im statischen Dictionary wird der Präfix für n:m Verbindungen festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Reservierte Keywords prüfen
Das Datenmodell wird auf von Firebird als reservierte Keywords definierte Datenbank Objektnamen geprüft.

### Tabelle reorganisieren     
Die Tabelle wird nach Positionsvorgaben in den Feldkommentaren neu organisiert. Zusaätzlich werden 
informationen aus dem Statischen Dictionary berücksichtigt. 
Dort wird angegeben ob ein Standtadfeld am Anfang oder am Ende eingetragen wird, relativ zu seiner eigenen Postionsangaben.

### Lookuptabellen einrichten     
Es werden Standard-Lookuptabellen eingerichtet.

Zu einigen dieser Standards wird man Ausnahmen definieren können.

Realisierung
------------

- Statisches Dictionary
- Dynamisches Dictionary
- Kommentar
- Befehle
- Workflow

### Statisches Dictionary
Im statischen Dictionary werden Informationen vorgehalten, welche bei der Codegenerierung 
erforderlich sind und im Befehlssatz nicht vorhanden sind.

So werden z. B. Standardfelder für Tabellen hinterlegt. 
Für die Namensgebung werden Präfix für die verschiedenen Datenbankobjekte definiert.

Das statische Dictionary kann per Script immer wieder neu erstellt werden oder 
aber es kann Teil des Datenbankmodells werden.
Die Inhalte müssen vom Entwickler angelegt werden.
Es wird eine Grundversion zur Verfügung gestellt.

Bevor *simplifyDDL* seine Arbeit aufnehmen kann, muss das statische Dictionary 
erstellt und eingerichtet sein.

### Dynamischen Dictionary
Das dynamische Dictionary wird mit jedem Script-Start neu aufgebaut. Das Dictionary 
wird aus den Befehlen in den Kommentaren der Tabelle und deren Felder erstellt.

### Kommentar
Alle relevanten Datenbankobjekte besitzen das Attribut: Kommentar. 
Der Kommentar kann frei vergeben werden.
*simplifyDDL* erwartet in diesen Kommentaren seine Anweisungen. 
Nach dem alle Befehle ausgelesen und die gewünschten Datenbankobjekte erstellt 
wurden, werden die Befehle aus den Kommentaren entfernt. Übrig bleiben nur die 
ursprünglichen Erläuterungen.

*simplifyDDL* nutze den Tabellen Kommentar für Anweisungen die direkt mit der 
Tabelle zusammenhängen oder aber mehrere Felder einer Tabelle einbeziehen.
Der Kommentar zum Feld einer Tabelle wird für Anweisungen genutzt, die sich 
ausschließlich auf das Feld konzentrieren. 

### Befehle
Die Befehle für *simplifyDDL* werden immer zu Anfang eines Kommentars angelegt.
Befehl können hintereinander verkettet werden. 
Erst nach dem letzten Befehl wird der eigentlich Kommentar hinterlegt.
Ein Befehl wird mit geschweiften Klammern begonnen und beendet.
In einem Befehl kann ein oder mehrere Anweisungen untergebracht werden.
Jede Anweisung bekommt einen Index vorangestellt. Der Index ist immer Nullbasiert.
Eine bestimmte Anweisung in einem Befehl wird immer den selben Index besitzen. 

### Workflow
*simplifyDDL* bietet einen einfachen Workflow für die Entwicklung von Datenmodellen an.

- ISQL wird als Script-Engine eingesetzt 
- Es wird ein Script für das statische Dictionary ausgeführt
- Der Entwickler kann beliebig viele Script einfügen in denen er das Datenmodell 
anlegt. Dabei kann sich der Entwickler auf die individuellen Aufgaben 
konzentrieren und über die Befehle in den Kommentare die Standardaufgaben organisieren
- Abschließend wird ein Script mit einer Parser-StoredProcedure aufgerufen. Diese 
Parser-StoredProcedure erzeugt das Create/Alter-Script um das Datenmodell zu vervollständigen
- Das erzeugte Script wird sofort über ISQL eingespielt
- Fertig