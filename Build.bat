@echo off
bin\ModCompile
if errorlevel 1 exit /b 1
bin\MegCreate -r Data\SkirmishMaps.meg Data\Art\Maps\_MP_*.ted
if errorlevel 1 exit /b 1
