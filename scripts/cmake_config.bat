@echo off

rem
rem CLI argumnets:
rem %1: Package configuration ID String
rem

setlocal
set "Package_RootDir=%~dp0.."

set "Package_ConfigID=%~1"
set "Package_Name="
set "Package_Generator="
set "Package_Platform="
set "Package_Toolset="
set "Package_Configuration="

rem
rem Where is software installed?
rem
set "Package_CMakeInstallDir=%ProgramFiles(x86)%\CMake"

rem 
rem Parse parameters from cli argument %1 which must have the format: 
rem <Name>.<Generator>.<Platform>.<Toolset>.<Configuration>
rem
echo calling call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigID%"
call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigID%"

rem Configure CMake environment:
rem 1. Converts %Package_Generator% to %Package_CMake_Generator%
rem 2. Constructs initializer for VcTools for dumb generators like nmake, jom etc...
set "Package_CMake_Generator="
set "Package_VisualStudioDir="
set "Package_VcVarsAll="
set "Package_VcVarsAllArgs="
echo calling call "%Package_RootDir%\scripts\cmake_package_generator.bat"
call "%Package_RootDir%\scripts\cmake_package_generator.bat"
 
set "Package_SrcDir=%Package_RootDir%\src\%Package_Name%"

set "Package_BuildDir=%Package_RootDir%\build\%Package_Name%.%Package_Generator%.%Package_Platform%.%Package_Toolset%.%Package_Configuration%"

set "Package_CMake=%Package_CMakeinstallDir%\bin\cmake.exe"
set "Package_CMakeGui=%Package_CMakeinstallDir%\bin\cmake-gui.exe"

set Package_

endlocal