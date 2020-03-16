REM In make_sDDL.log wird jede verarbeitete Zeile aufgelistet
REM Bei einem Fehler wird sofort die Verarbeitung unterbrochen
REM Die letzte Zeile zeigt an, wo und welcher Fehler aufgetreten ist

if "%1"=="UES" goto UES

_make C:\Users\Alfred\Programme\Firebird_3_0\isql.exe make_sDDL.log *

goto ENDE

:UES
_make C:\Firebird\x64\v302\isql.exe make_sDDL.log

pause

:ENDE
