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

set "Package_RootDir=%~dp0.."

echo. & echo Args: %* & echo.

set "Package_ConfigString=%~1"
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

rem 
rem Parse parameters:
rem
echo calling call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigString%"
call "%Package_RootDir%\scripts\parse_params.bat" "%Package_ConfigString%"

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
if errorlevel 1 start "Error!" echo Error %errorlevel% occurred in %0 
 
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
rem Should we invoke error?
rem
set "Loc_Answer=No"
call :invokeErrorIfProgramsAreMissing %*
if errorlevel 1 echo Error %errorlevel% occurred in %0 & cmd /k exit /b %errorlevel%
if /i "%Loc_Answer%"=="Yes" goto :eof

rem
rem Should we invoke cmake-gui?
rem
set "Loc_Answer=No"
call :invokeCMakeGuiIfRequired %*
if errorlevel 1 echo Error %errorlevel% occurred in %0 & cmd /k exit /b %errorlevel%
if /i "%Loc_Answer%"=="Yes" goto :eof

rem
rem Should we invoke cmake?
rem
set "Loc_Answer=No"
call :invokeCMakeIfRequired %*
if errorlevel 1 echo Error %errorlevel% occurred in %0 & cmd /k exit /b %errorlevel%
if /i "%Loc_Answer%"=="Yes" goto :eof

rem
rem Should we invoke Visual Studio?
rem
set "Loc_Answer=No"
call :invokeVisualStudioIfRequired %*
if errorlevel 1 echo Error %errorlevel% occurred in %0 & cmd /k exit /b %errorlevel%
if /i "%Loc_Answer%"=="Yes" goto :eof

rem
rem OK, no specific option given, invoke interactive shell:
rem
echo invoking: "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
if errorlevel 1 echo Error %errorlevel% occurred in %0 & cmd /k exit /b %errorlevel%
start "%Package_ConfigString%" cmd /k echo Environment for "%Package_ConfigString%" is ready. Invoke cmake, cmake-gui, msbuild or devenev.exe at will.

rem
rem Script functions block
rem

goto :eof
:invokeErrorIfProgramsAreMissing
setlocal
    set "Loc_Answer=No"
    echo. & echo in %0 & echo args: %*

    echo if not exist "%Package_VisualStudioDir%" ...
    if not exist "%Package_VisualStudioDir%" (
        set "Loc_Answer=Yes"
        echo "error: %Package_VisualStudioDir%"
        cmd /c exit /b 1
        goto :locEnd
    )

    echo if not exist "%Package_VcVarsAll%" ...
    if not exist "%Package_VcVarsAll%" (
        set "Loc_Answer=Yes"
        echo "error: %Package_VcVarsAll%"
        cmd /c exit /b 2
        goto :locEnd
    )

    echo if not exist "%Package_CMake%" ...
    if not exist "%Package_CMake%" (
        set "Loc_Answer=Yes"
        echo "error: %Package_CMake% does not exist!"
        cmd /c exit /b 3
        goto :locEnd
    )

    echo if not exist "%Package_CMakeGui%" ...
    if not exist "%Package_CMakeGui%" (
        set "Loc_Answer=Yes"
        echo "error: %Package_CMakeGui% does not exist!"
        cmd /c exit /b 4
        goto :locEnd
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Loc_Answer=%Loc_Answer%" & exit /b %errorlevel%

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
            if not exist "%Package_BinDir%" md "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            cd "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
            if errorlevel 1 goto :locEnd
            start "%Package_ConfigString%" /d "%Package_BinDir%" cmd /k call "%Package_CMake%" -G "%Package_CMake_Generator%" -DCMAKE_BUILD_TYPE=%Package_Configuration% "%Package_SrcDir%"
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
            if not exist "%Package_BinDir%" md "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            cd "%Package_BinDir%"
            if errorlevel 1 goto :locEnd
            call "%Package_VcVarsAll%" %Package_VcVarsAllArgs%
            if errorlevel 1 goto :locEnd
            if not exist "%Package_BinDir%\CMakeCache.txt" echo Warning: You should consider running CMake first, we cannot detect "%Package_BinDir%\CMakeCache.txt"!
            start "%Package_ConfigString%" /d "%Package_BinDir%" cmd /k call "%Package_CMakeGui%" "%Package_SrcDir%"
            goto :locEnd
        )
    )
:locEnd
endlocal & echo exiting %0 & echo. & set "Loc_Answer=%Loc_Answer%" & exit /b %errorlevel%