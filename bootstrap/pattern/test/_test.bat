cls

if "%1"=="" goto Anwendung
if "%2"=="" goto Anwendung

del %2

echo Bentuzer und Passwort f�r Test angeben
SET ISC_USER={USERNAME}
SET ISC_PASSWORD={PASSWORD}

%1isql -b -e -i test.sql -m -o %2

goto ENDE1

:Anwendung
echo.
echo    Das Batchprogramm zur Ausf�hrung eines Testes wird wie folgt aufgerufen:  
echo.
echo    _test {ISQL-Pfad mit abschlie�endem \} {Pfad und Name der Logdatei}
echo.

goto ENDE2

:ENDE1

CLS
echo.
echo    Test ausgef�hrt 
echo.

:ENDE2