@echo off

rem
rem CLI arguments:
rem %1: Package configuration ID String in following format:
rem <Package_Name>.<Package_Generator>.<Package_Platform>.<Package_Toolset>.<Package_Configuration>
rem Currently recognized options:
rem Package_Generator: jom|nmake|msbuild
rem Package_Platform: x86|x64
rem Package_Toolset: v100|v110|v120|v140
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
rem Where is CMake installed, is it installed at all?
rem
set "Package_CMakeInstallDir=%ProgramFiles(x86)%\CMake"
set "Package_CMake=%Package_CMakeInstallDir%\bin\cmake.exe"
set "Package_CMakeGui=%Package_CMakeInstallDir%\bin\cmake-gui.exe"
if not exist %Package_CMake% start "Error!" echo %Package_CMake% does not exist!
if not exist %Package_CMakeGui% start "Error!" echo %Package_CMakeGui% does not exist!

rem 
rem Parse parameters:
rem
echo calling call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigID%"
call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigID%"

rem
rem Configure CMake environment:
rem 1. Converts %Package_Generator% to %Package_CMake_Generator%
rem 2. Constructs initializer for VcTools for dumb generators like nmake, jom etc...
rem
set "Package_CMake_Generator="
set "Package_VisualStudioDir="
set "Package_VcVarsAll="
set "Package_VcVarsAllArgs="
echo calling call "%Package_RootDir%\scripts\cmake_package_generator.bat" "%Package_Generator%" "%Package_Platform%" "%Package_Toolset%"
call "%Package_RootDir%\scripts\cmake_package_generator.bat" "%Package_Generator%" "%Package_Platform%" "%Package_Toolset%"
 
 rem
 rem Package source and build directories:
 rem
set "Package_SrcDir=%Package_RootDir%\src\%Package_Name%"
set "Package_BinDir=%Package_RootDir%\build\%Package_Name%.%Package_Generator%.%Package_Platform%.%Package_Toolset%

rem 
rem Do we have a configuration in the ID string?
rem
if /i not "%Package_Configuration%"=="" (
    set "Package_BinDir=%Package_BinDir%.%Package_Configuration%
)

set Package_

rem
rem Should we invoke cmake-gui?
rem
set "Loc_Answer=No"
call :invokeCMakeGuiIfRequired %*
if /i "%Loc_Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occurred in %0 

rem
rem Should we invoke cmake?
rem
set "Loc_Answer=No"
call :invokeCMakeIfRequired %*
if /i "%Loc_Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occurred in %0 

rem
rem Should we invoke Visual Studio?
rem
set "Loc_Answer=No"
call :invokeVisualStudioIfRequired %*
if /i "%Loc_Answer%"=="Yes" goto :eof
if errorlevel 1 start "Error!" echo Error %errorlevel% occurred in %0 

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
endlocal & echo exiting %0 & echo. & set "Loc_Answer=%Loc_Answer%" & exit /b %errorlevel%

goto :eof
:invokeCMakeIfRequired
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*
    for %%A in (%*) do (
        echo token: %%A
        if /i "%%A"=="cmake" ( 
            set "Loc_Answer=Yes"
            echo if not exist "%Package_BinDir%" md "%Package_BinDir%"
            echo cd "%Package_BinDir%"
            echo call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
            echo "%Package_CMake%" -G "%Package_CMake_Generator%" -DCMAKE_BUILD_TYPE=%Package_Configuration% "%Package_SrcDir%"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Loc_Answer=%Loc_Answer%" & exit /b %errorlevel%

goto :eof
:invokeCMakeGuiIfRequired
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*
    for %%A in (%*) do (
        echo token: %%A
        if /i "%%A"=="cmake-gui" (
            set "Loc_Answer=Yes"
            echo if not exist "%Package_BinDir%" md "%Package_BinDir%"
            if not exist "%Package_BinDir%" md "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            echo cd /d "%Package_BinDir%"
            cd /d "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            echo call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
            call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
            if errorlevel 1 goto :locEnd
            echo "%Package_CMakeGui%" "%Package_SrcDir%"
            "%Package_CMakeGui%" "%Package_SrcDir%"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Loc_Answer=%Loc_Answer%" & exit /b %errorlevel%

endlocal