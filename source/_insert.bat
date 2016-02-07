cls

@echo off

del %2

if "%1"=="" goto APPLICATION
if "%2"=="" goto APPLICATION

echo sDDL-Daten erstellen
%1 -q -b -e -i insert.sql -m -o %2

goto END1

:APPLICATION
echo.
echo    Das Batchprogramm zum Anlegen der sDDL-Daten wird wie folgt aufgerufen:
echo.
echo    insert_sDDL {ISQL} {Ziel der Logdatei}
echo.

goto END2

:END1

CLS
echo.
echo    Die Daten wurden angelegt 
echo.

:END2