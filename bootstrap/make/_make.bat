cls

@echo off

del %2

if "%1"=="" goto APPLICATION
if "%2"=="" goto APPLICATION
if "%3"=="" goto INSTALL

echo Datenbank erstellen
%1 -q -b -e -i ..\sddl\sddl.bootstrap.create.db.sql -m -o %2

:INSTALL
echo sDDL Bootstrap installieren
%1 -q -b -e -i batch.sql -m -o %2

goto END1

:APPLICATION
echo.
echo    Das Batchprogramm zur Installation des sDDL Bootstrap, sowie wahlweise das Erstellen   
echo    einer Entwicklungsdatenbank wird wie folgt aufgerufen:
echo.
echo    make {ISQL} {Ziel der Logdatei} [*]
echo.

goto END2

:END1

CLS
echo.
echo    Die Datenbank wurde erstellt 
echo.

:END2