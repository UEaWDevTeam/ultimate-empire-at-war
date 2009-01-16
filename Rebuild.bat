@echo off
del Data\Art\Textures\MT_CommandBar.mtd
del Data\Art\Textures\MT_CommandBar.tga
del Data\Text\MasterTextFile_*.dat
del Data\*.meg
call Build
if errorlevel 1 goto error
goto :EOF

:error
pause