@echo off

echo In test.log wird jede verarbeitete Zeile aufgelistet
echo Bei einem Fehler wird sofort die Verarbeitung unterbrochen
echo Die letzte Zeile zeigt an, wo der Fehler aufgetreten ist
echo.
echo Das Batchprogramm zur Ausf�hrung eines Testes wird wie folgt aufgerufen:  
echo.
echo _test {ISQL-Pfad mit abschlie�endem \} {Pfad und Name der Logdatei}

REM FB Rootdir und Name der Logdatei  hier nur ein Beispiel
_test C:\firebird\64\304\ test.log
