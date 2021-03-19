@echo off

echo In createSysdba.log wird jede verarbeitete Zeile aufgelistet
echo Bei einem Fehler wird sofort die Verarbeitung unterbrochen
echo Die letzte Zeile zeigt an, wo der Fehler aufgetreten ist
echo.
echo Das Batchprogramm zur Erstellung des SYSDBA wird wie folgt aufgerufen:  
echo _createSYSDBA {FB3 Rootdir mit abschlieﬂendem \} {Pfad u. Name der Logdatei}

REM FB3 Rootdir und Logdatei hier nur ein Beispiel
_createSysdba C:\Firebird\x32\v307\ createSysdba32.log