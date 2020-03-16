***(in Progress: Zielversion sDDL 0.9 M1)***

sDDL.bootstrap
==============

Framework, welches näher am Ursprungsprojekt [ZABonline](https://github.com/AlfredGerke/ZABonline "ZABonline - Einarbeitung in die Entwicklung von Web-Anwendugen mit WaveMaker") ist.

Das Framework soll einen neuen Ansatz in die Entwicklung zum sDDL bringen.

*sDDL.bootstrap* ersetzt den Entwicklungsstrang zum sDDL komplett.

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
teilweise oder komplett zu generieren, hat seinen Ursprung in dem Projekt [ZABonline](https://github.com/AlfredGerke/ZABonline "ZABonline - Einarbeitung in die Entwicklung von Web-Anwendugen mit WaveMaker").

Mit ZABonline werden die Möglichkeiten von WaveMaker 6.7.x im speziellen, so wie der Aufbau einer Anwendung als SPA (Single-Page-Application) im Allgemeinen getestet. 

Im Zuge dieser Entwicklung wurden diverse [`SQL-Scripte`](https://github.com/AlfredGerke/ZABonline/tree/master/source/script/script "SQL-Scripte vom ZABonline") angelegt um die Datenbasis für das Projekt festzulegen.
Um die Arbeit zu vereinfachen wurden immer wiederkehrende Aufagaben vereinheitlicht, in einen Standard gebracht und von Hilfsroutinen teilweise oder komplett übernommen.

Diese Hilfsroutinen befinden sich in den Scripten [`create_tools.sql`](https://github.com/AlfredGerke/ZABonline/blob/master/source/script/script/create_tools.sql "create_tools.sql") und [`create_hibernate_workaround.sql`](https://github.com/AlfredGerke/ZABonline/blob/master/source/script/script/create_hibernate_workaround.sql "create_hibernate_workaround.sql"). 

Dieses Projekt soll das in ZABonline eingeführte Verfahren zur Generierung von DDL-Inhalten generalisieren.

Voraussetzungen
---------------

### Entwicklung unter Firebird
*sDDL.bootstrap* wendet sich an Modellentwickler für Firebird. 
Wann immer es sinnvoll erscheint, werden Sprachelemente genutzt, die speziell von Firebird zur Verfügung gestellt 
werden und nicht notwendigerweise in anderen Datenbanksystemen vorhanden sind.
Eine Ausweitung auf andere Datenbanksysteme ist in dieser Entwicklungsphase nicht
vorgesehen. Über folgenden Link: [Firebird Download](https://firebirdsql.org/en/firebird-3-0/ "Firebird Download")
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

* FB 3.0x [Firebird Download](https://firebirdsql.org/en/firebird-3-0/ "Firebird Download")
* Jaybird 3.0 [JDBC Driver](https://firebirdsql.org/en/jdbc-driver/ "JDBC Driver")
    - Wird für die Anbindung von DBeaver benötigt 


zusätzliche Entwicklungsumgebungen
----------------------------------

* [ISQL](http://www.firebirdsql.org/manual/isql-interactive.html "ISQL-Commandlinetool")
* [FlameRobin](http://www.flamerobin.org/ "GUI für Datenbankentwurf/-entwicklung")
* [DBeaver](http://dbeaver.jkiss.org/ "Universial SQL Client")
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

### DBeaver
DBeaver ist ein plattformübergreifendes Entwicklungswerkzeug. Die IDE basiert auf Eclipse. 
Die Datenbankverbindung wird für Firebird über die Jaybird JDBC Treiber hergestellt.
Für FB 3.0x müssen die passenden Jaybird JDBC Treiber verwendet werden. DBeaver kann über die [Groupid 
und der Artifactid](https://www.firebirdsql.org/file/documentation/drivers_documentation/java/3.0.0-beta-2/release_notes.html "Groupid 
und der Artifactid") des JDBC Treibers die notwendigen Dateien selber herunterladen.  
Um DBeaver unter FB 3.0x verwenden zu können, muss in *firebird.conf* `WireCrypt = Enabled` eingestellt werden.
DBeaver ist OpenSource und kann ohne Bedenken eingesetzt werden.

### PSPad
Wenn man zum Commandlinetool (ISQL) und FlameRobin für die Entwicklung der Datenbank 
eine Ergänzung sucht, bietet sich PSPad an. PSPad ist ein freier unicode-fähiger 
Texteditor für Windows. Der Texteditor ist speziell für Softwareentwickler entworfen 
worden und unterstützt diverse Programmiersprachen, darunter auch SQL. PSPad ist 
Freeware und kann ohne Bedenken eingesetzt werden.   


Zielvorgabe
-----------

Bei *sDDL.bootstrap* handelt es sich um ein Sammlung von Packages, sowie 
eines Workflow um auf der Basis einer Tabelle notwendige DDL Syntax automatisch 
erstellen zu können.

Zu diesem Zweck wird ein Befehlssatz eingeführt, der in den Kommentaren einer Tabelle
und deren Felder eingebettet wird.

**Standardaufgaben:**

- ???

Realisierung
------------

- ???
