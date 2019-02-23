cls

if "%1"=="" goto Anwendung
if "%2"=="" goto Anwendung

echo Log löschen
del %2

echo Vorhandene Sicherheitsdatenbank kopieren
copy %1security3.fdb %1security3.fdb.empty

echo SYSDBA anlegen
%1isql -user sysdba employee -i database.security.create.sql -m -o %2

goto ENDE1

:Anwendung
echo.
echo    Das Batchprogramm zur Erstellung des SYSDBA wird wie folgt aufgerufen:  
echo.
echo    createSysdba {FB3 Rootdir} {Logdatei}
echo.

goto ENDE2

:ENDE1

CLS
echo.
echo    Ende 
echo.

:ENDE2