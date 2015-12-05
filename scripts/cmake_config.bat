@echo off

rem
rem CLI argumnets:
rem %1: Package configuration ID String
rem

setlocal
set "Package_RootDir=%~dp0.."

echo. & echo Args: %* & echo.

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
echo calling call "%Package_RootDir%\scripts\cmake_package_generator.bat" "%Package_Generator%" "%Package_Platform%" "%Package_Toolset%"
call "%Package_RootDir%\scripts\cmake_package_generator.bat" "%Package_Generator%" "%Package_Platform%" "%Package_Toolset%"
 
set "Package_SrcDir=%Package_RootDir%\src\%Package_Name%"

set "Package_BinDir=%Package_RootDir%\build\%Package_Name%.%Package_Generator%.%Package_Platform%.%Package_Toolset%.%Package_Configuration%"

set "Package_CMake=%Package_CMakeinstallDir%\bin\cmake.exe"
set "Package_CMakeGui=%Package_CMakeinstallDir%\bin\cmake-gui.exe"

set Package_

rem
rem Should we invoke cmake-gui?
rem
set "Answer=No"
call :invokeCMakeGuiIfRequired %*
if /i "%Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occured in %0 

rem
rem Should we invoke cmake?
rem
set "Answer=No"
call :invokeCMakeIfRequired %*
if /i "%Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occured in %0 

rem
rem Should we invoke Visual Studio?
rem
set "Answer=No"
call :invokeVisualStudioIfRequired %*
if /i "%Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occured in %0 

rem
rem Script functions block
rem
goto :eof
:invokeVisualStudioIfRequired
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*
    for %%A in (%*) do (
        echo token: %%A
        if /i "%%~xA"==".sln" (
            echo "%Package_VisualStudioDir%\Common7\IDE\devenv.exe" "%%A"
            set "Loc_Answer=Yes"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Answer=%Loc_Answer%" & exit /b %errorlevel%

goto :eof
:invokeCMakeIfRequired
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*
    for %%A in (%*) do (
        echo token: %%A
        if /i "%%A"=="cmake" ( 
            set "Loc_Answer=Yes"
            echo cd "%Package_BinDir%"
            echo "%Package_CMake%" -G "%Package_CMake_Generator%" "%Package_SrcDir%"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Answer=%Loc_Answer%" & exit /b %errorlevel%

goto :eof
:invokeCMakeGuiIfRequired
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*
    for %%A in (%*) do (
        echo token: %%A
        if /i "%%A"=="cmake-gui" (
            set "Loc_Answer=Yes"
            echo cd "%Package_BinDir%"
            echo "%Package_CMakeGui%" "%Package_SrcDir%"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Answer=%Loc_Answer%" & exit /b %errorlevel%

endlocal