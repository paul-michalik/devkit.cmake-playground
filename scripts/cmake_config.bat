@echo off

rem %1: generator
rem %2: platform
rem %3: toolset
rem %4: configuration

setlocal
set "Package_RootDir=%~dp0.."

set "Package_Generator=%~1"
set "Package_Platform=%~2"
set "Package_Toolset=%~3"
set "Package_Configuration=%~4"

set "Package_CMake_Generator="
set "Package_VcVarsAllCmdLine="
echo calling "%Package_RootDir%\scripts\cmake_package_generator.bat"
call "%Package_RootDir%\scripts\cmake_package_generator.bat"
 
set Package
endlocal