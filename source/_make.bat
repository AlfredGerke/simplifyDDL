cls

@echo off

del %2

if "%1"=="" goto APPLICATION
if "%2"=="" goto APPLICATION
if "%3"=="" goto INSTALL

echo Datenbank erstellen
%1 -q -b -e -i create_db.sql -m -o %2

:INSTALL
echo sDDL installieren
%1 -q -b -e -i batch.sql -m -o %2

goto END1

:APPLICATION
echo.
echo    Das Batchprogramm zur Installation der sDDL Sourcen, sowie wahlweise das Erstellen   
echo    einer sDDL Entwicklungsdatenbank wird wie folgt aufgerufen:
echo.
echo    make_sDDL {ISQL} {Ziel der Logdatei} [*]
echo.

goto END2

:END1

CLS
echo.
echo    Die Datenbank wurde erstellt 
echo.

:END2