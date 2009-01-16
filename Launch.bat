@echo off

@rem Turn on delayed expansion of variables (and call ourselves)
If not %1.==[]. (Cmd /V:On /C Call %0 [] & GoTo :EOF)

@rem Build the mod first
call Build
if errorlevel 1 goto error

@rem Launch the mod. We get the modpath by replacing the path two levels down
@rem in the current directory with an empty string
set MODPATH=%CD%
cd ..\..
echo Launching game...
swfoc.exe MODPATH=!MODPATH:%CD%\=!
goto :EOF

@rem On errors, wait for a keypress
:error
pause