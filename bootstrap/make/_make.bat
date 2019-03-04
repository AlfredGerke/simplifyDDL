cls

@echo off

del %2

if "%1"=="" goto APPLICATION
if "%2"=="" goto APPLICATION
if not "%3"=="CREATE_TEST_DB" goto INSTALL

echo Datenbank erstellen
%1 -q -b -e -i sddl.bootstrap.test-db.create.sql -m -o %2

:INSTALL
echo sDDL Bootstrap installieren
%1 -q -b -e -i sddl.bootstrap.install.sql -m -o %2

goto END1

:APPLICATION
echo.
echo    Das Batchprogramm zur Installation des sDDL.bootstrap, sowie wahlweise das Erstellen   
echo    einer Entwicklungsdatenbank wird wie folgt aufgerufen:
echo.
echo    make {Name und Pfad des ISQL} {Name und Pfad der Logdatei} [CREATE_TEST_DB]
echo.
echo    Der letzte Parameter [CREATE_TEST_DB] ist optional und wenn vorhanden wird eine Datenbank angelegt
echo    (s. sddl.bootstrap.create.db.sql in .\sddl\)
echo.

goto END2

:END1

CLS
echo.
echo    Die sDDL.bootstrap wurde erstellt 
echo.

:END2