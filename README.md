***(in Progress: Zielversion sDDL 0.9 M1)***

simplifyDDL (sDDL)
==================

Hilfsroutinen für Firebird (2.5.x) zur Erstellung von Datenbank-Objekten auf der 
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
Es werden alle notwendige Scripte und Beispiele eingeführt.    


Voraussetzungen
---------------

### Entwicklung unter Firebird
*simplifyDDL* wendet sich an Firebird-Nutzer. Wann immer es sinnvoll erscheint 
werden Sprachelemente genutzt, die speziell von Firebird zur Verfügung gestellt 
werden und nicht notwendigerweiser in anderen Datenbanksystemen vorhanden sind.
Eine Ausweitung auf anderen Datenbanksysteme ist in dieser Entwicklungsphase nicht
vorgesehen. Über folgenden Link: [Firebird Download](http://www.firebirdsql.org/en/firebird-2-5-4/ "Firebird Download")
kann die aktuellste Version für alle gängigen Plattformen bezogen werden. 

### SQL und PSQL   
Die Entwicklung in einer Firebird-Datenbank mit SQL und PSQL sollte im Prinzip 
verstanden sein. Ein Anwender mit Grundkenntnissen wird keine Probleme haben sich
in die vorhandenen Sourcen einzuarbeiten. Über folgenden Link: [Firebird Manual](http://www.firebirdsql.org/en/reference-manuals/ "Firebird Manual")
können umfangreiche Dokumentiationen (HTML und PDF) bezogen werden.  

### ISQL
ISQL gehört zum Lieferumfang einer Firebird-Datenbank. Der Einsatz von ISQL sollte
im Prinzip verstanden sein. 


Versionen
---------

* Firebird 2.5.x


zusätzliche Entwicklungsumgebungen
----------------------------------

* [ISQL](http://www.firebirdsql.org/manual/isql-interactive.html "ISQL-Commandlinetool")
* [FlameRobin](http://www.flamerobin.org/ "GUI für Datenbankentwurf/-entwicklung")
* [PSPad](http://www.pspad.com/de/ "PSPad – der ultimative Editor für Softwareentwickler")

### ISQL
ISQL ist Teil der Firebird-Installation und dient der Administration der Datenbank. 
ISQL ist ein Commandlinetool, welches für Einzel- und/oder Batchoperationen verwendet werden kann.
Besonders die Verarbeitung von Scripten als Batch lässt sich gut mit ISQL realiseren.

### FlameRobin     
FlameRobin ist ein plattformübergreifendes Administrationstool für FireBird, welches (fast) alle Befehle, 
welche über den ISQL verarbeitet werden können, in einer GUI anbietet. Neben der Administration lässt sich 
FlameRobin sehr gut für die Entwicklung einsetzen. FlameRobin ist OpenSource und kann ohne
Bedenken eingesetzt werden.

### PSPad
Wenn man zum Commandlinetool (ISQL)) und FlameRobin für die Entwicklung der Datenbank 
eine Ergänzung sucht, bietet sich PSPad an. PSPad ist ein freier unicode-fähiger 
Texteditor für Windows. Der Texteditor ist speziell für Softwareentwickler entworfen 
worden und unterstützt diverse Programmiersprachen, darunter auch SQL. PSPad ist 
Freeware und kann ohne Bedenken eingesetzt werden.   


Zielvorgabe
-----------

Bei *simplifyDDL* handelt es sich um ein Sammlung von StoredProcedures, sowie 
eines Workflows um auf der Basis einer Tabelle notwendige Datenbank-Objekte 
automatisch erstellen zu können.

Zu diesem Zweck wird ein Befehlssatz eingeführt, der in den Kommentaren einer Tabelle
und deren Felder eingebettet wird.

Diese Befehl werden ausgelesen, es wird ein Dictionary erstellt, auf desen Grundlage die
gewünschten Datenbank-Objekte in einem Script angeboten werden.

Der Gedanke ist beim Entwurf eines Datenbank Models auf schnelle Art und Weise
ein lauffähiges Ergebnis zu erhalten ohne sich dabei um Standardaufgaben kümmern zu müssen.

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

### Sequences einrichten
Für Primärschlüssel (Standardfeld <ID>) werden Sequences angelegt. 
Das Feld <ID> wird als Standardfeld für Primärschlüssel forgesehen.
Im statischen Dictionary wird der Prefix für Sequences festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Domains einrichten
Für Standardfelder werden Domainen angelegt. (z.B.: <PREFIX>_CURRENT_USER für das Standardfeld CRE_USER)
Im statischen Dictionary wird der Prefix für Domains festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Standardfelder ergänzen
Im statischen Dictionary festgelegte Standardfelder werden ausgelesen und in einer Tabelle ergänzt. 
Wenn notig werden Standarddomains erstellt (z.B. CRE_USER oder <ID>).
Im statischen Dictionary werden für bestimmte Standardfelder der Feldname festgelegt (z.B. <ID> für den Primärschlüssel) 

### Trigger einrichten
Für das initialisieren von Primärschlüssel und Standardfelder werden Tabellentrigger eingerichtet.
(z.B.: <PREFIX>_<TRIGGER_NAME>_BI0 für den Primärschlüssel)
Im statischen Dictionary wird der Prefix für Trigger festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Unique Keys einrichten
Für Unique Keys werden die notwendigen Constraints erstellt.
Im statischen Dictionary wird der Prefix für Unique Key Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Indices einrichten
Für Indices werden die notwenigen Constraints erstellt.
Im statischen Dictionary wird der Prefix für Indices Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Foreign Keys einrichten
Für Foreign Keys werden die notwendigen Constraints erstellt.
Im statischen Dictionary wird der Prefix für Foreign Key Constraints festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Standardviews einrichten
Für jede Tabelle wird wird ein Standardview erstellt.
Im statischen Dictionary wird der Prefix für Standardviews festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### n:m Verbindungen realisieren
Es wird eine zusätzliche Tabelle mit den Primärschlüssel zweier verschiedener Tabellen aus Foreign Keys eingerichtet.
Im statischen Dictionary wird der Prefix für n:m Verbindugnen festgelegt.
Die Namensgebung, Prüfung auf Länge und Eindeutigkeit wird von *simplifyDDL* übernommen.

### Reservierte Keywords prüfen
Das Datenmodell wird auf von Firebird als reservierte Keywords definierte Datenbank-Objektnamen geprüft.

Zu einigen dieser Standards wird man Ausnahmen definieren können.

Realisierung
------------

- statischen Dictionary
- dynamischen Dictionary
- Kommentar
- Befehle
- Workflow