@echo off

rem %1: generator
rem %2: platform
rem %3: toolset
rem %4: configuration

setlocal
set "Package_RootDir=%~dp0.."

set "Package_Name=%~1"
set "Package_Generator=%~2"
set "Package_Platform=%~3"
set "Package_Toolset=%~4"
set "Package_Configuration=%~5"

set "Package_CMake_Generator="
set "Package_VcVarsAllCmdLine="
echo calling "%Package_RootDir%\scripts\cmake_package_generator.bat"
call "%Package_RootDir%\scripts\cmake_package_generator.bat"
 
set "Package_SrcDir=%Package_RootDir%\src\%Package_Name%"
set "Package_BuildDir=%Package_RootDir%\build\%Package_Name%.%Package_Generator%.%Package_Platform%.%Package_Toolset%.%Package_Configuration%"

set Package

endlocal