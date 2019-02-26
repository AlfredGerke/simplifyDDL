@echo off

echo In test.log wird jede verarbeitete Zeile aufgelistet
echo Bei einem Fehler wird sofort die Verarbeitung unterbrochen
echo Die letzte Zeile zeigt an, wo der Fehler aufgetreten ist
echo Beispiel für den Aufruf von _text: _test C:\Firebird\x64\v302\ test.log 

_test {ISQL-Pfad mit Backslash} {Logdatei}
