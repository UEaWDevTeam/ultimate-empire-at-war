@echo off
call Build
if errorlevel 1 goto done
bin\ModCheck
:done
pause