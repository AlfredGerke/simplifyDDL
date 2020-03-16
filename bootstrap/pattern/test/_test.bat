cls

if "%1"=="" goto Anwendung
if "%2"=="" goto Anwendung

del %2

echo Bentuzer und Passwort für Test angeben
SET ISC_USER={USERNAME}
SET ISC_PASSWORD={PASSWORD}

%1isql -b -e -i test.sql -m -o %2

goto ENDE1

:Anwendung
echo.
echo    Das Batchprogramm zur Ausführung eines Testes wird wie folgt aufgerufen:  
echo.
echo    _test {ISQL-Pfad mit abschließendem \} {Pfad und Name der Logdatei}
echo.

goto ENDE2

:ENDE1

CLS
echo.
echo    Test ausgeführt 
echo.

:ENDE2