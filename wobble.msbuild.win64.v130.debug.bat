@echo off
rem %~1 : generator = jom|msbuild 
rem %~2 : platform = win32|win64
rem %~3 : toolset = v110|v120|v130
rem %~4 : configuration = Debug|Release|...
call "%~dp0scripts\cmake_config.bat" wobble msbuild win64 v130 Debug