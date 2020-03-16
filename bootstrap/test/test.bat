@echo off

echo WICHTIG: Den Test nur ausführen wenn das Make fehlerfrei funktioniert!!!

set /p DO_START_TEST=Soll der Test gestartet werden (J/N): 

if "%DO_START_TEST%"=="J" (
  goto START_TEST
) else if "%DO_START_TEST%"=="j" (
  goto START_TEST
) else (
  goto CANCEL_TEST
)

:CANCEL_TEST

cls
echo Der Test wurde abgebrochen
pause
goto END_TEST

:START_TEST

cls
echo In test.log wird jede verarbeitete Zeile aufgelistet
echo Bei einem Fehler wird sofort die Verarbeitung unterbrochen
echo Die letzte Zeile zeigt an, wo der Fehler aufgetreten ist
echo Beispiel für den Aufruf von _text: _test C:\Firebird\x64\v302\ test.log 

echo.
echo In den Make-Ordner wechseln
cd ..\make\

echo Make ausführen
call ..\make\make.bat

echo.
echo In den Test-Ordner wechseln
cd ..\test\

echo Test ausführen
REM GLOIN
_test C:\Users\Alfred\Programme\Firebird\x32\v304\ test.log

REM NB
REM _test C:\firebird\64\304\ test.log

:END_TEST