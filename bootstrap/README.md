***(in Progress: Zielversion sDDL 0.9 M1)***

sDDl-Bootstrap
==============

Framework, welches näher am Ursprungsprojekt [ZABonline](https://github.com/AlfredGerke/ZABonline "ZABonline - Einarbeitung in die Entwicklung von Web-Anwendugen mit WaveMaker") ist.

Das Framework soll einen neuen Ansatz in die Entwicklung bringen.

**Inhaltsübersicht:**

- Anmerkung zur Version
- Voraussetzungen
- Versionen
- zusätzliche Entwicklungsumgebungen
- Zielvorgabe 
- Realisierung

Anmerkung zur neuen Version
---------------------------

???

Voraussetzungen
---------------

### Entwicklung unter Firebird
*sDDl-Bootstrap* wendet sich an Modellentwickler für Firebird. 
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

Bei *sDDl-Bootstrap* handelt es sich um ein Sammlung von StoredProcedures, sowie 
eines Workflow um auf der Basis einer Tabelle notwendige DDL Syntax automatisch 
erstellen zu können.

Zu diesem Zweck wird ein Befehlssatz eingeführt, der in den Kommentaren einer Tabelle
und deren Felder eingebettet wird.

Diese Befehl werden ausgelesen, es wird ein Dictionary erstellt, auf der Grundlage des
Dictionary wird ein Script mit der gewünschten DDL Syntax erstellt.

Ziel ist es, beim Entwurf eines Datenbankmodells auf Skriptbasis, auf schnelle Art ein lauffähiges 
Ergebnis zu erhalten, ohne sich dabei um Standardaufgaben kümmern zu müssen.

**Standardaufgaben:**

- ???

Realisierung
------------

- ???
