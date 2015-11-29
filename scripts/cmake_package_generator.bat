@echo off

rem Parameters:
rem %1: Package_Generator
rem %2: Package_Platform
rem %3: Package_Toolset

setlocal
set "Loc_Generator=%~1"
set "Loc_Platform=%~2"
set "Loc_Toolset=%~3"
set "Loc_CMake_Generator="
set "Loc_CMake_GeneratorArgs="
set "Loc_VisualStudioDir="
set "Loc_VcVarsAll="
set "Loc_VcVarsAllArgs="

rem
rem Visual Studio:
rem
if "%Loc_Toolset%"=="v100" (
    set "Loc_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
)

if "%Loc_Toolset%"=="v110" (
    set "Loc_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
)

if "%Loc_Toolset%"=="v120" (
    set "Loc_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 13.0\VC\vcvarsall.bat"
)

if "%Loc_Toolset%"=="v140" (
    set "Loc_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 15.0\VC\vcvarsall.bat"
)


set "Loc_VcVarsAll=%Loc_VisualStudioDir%\VC\vcvarsall.bat"


if "%Loc_Generator%"=="msbuild" (
    rem
    rem Generator
    rem
    if "%Loc_Toolset%"=="v100" (
        set "Loc_CMake_Generator=Visual Studio 10 2010"
    )

    if "%Loc_Toolset%"=="v110" (
        set "Loc_CMake_Generator=Visual Studio 11 2012"
    )

    if "%Loc_Toolset%"=="v120" (
        set "Loc_CMake_Generator=Visual Studio 12 2013"
    )

    if "%Loc_Toolset%"=="v140" (
        set "Loc_CMake_Generator=Visual Studio 14 2015"
    )

    rem
    rem Platform
    rem
    if "%Loc_Platform%"=="win32" (
        set "Loc_CMake_GeneratorArgs="
    )

    if "%Loc_Platform%"=="win64" (
        set "Loc_CMake_GeneratorArgs=Win64"
    )
)

if "%Loc_Generator%"=="jom" (
    rem
    rem Generator
    rem
    if "%Loc_Toolset%"=="v110" (
        set "Loc_CMake_Generator=NMake Makefiles JOM"
    )

    if "%Loc_Toolset%"=="v120" (
        set "Loc_CMake_Generator=NMake Makefiles JOM"
    )

    if "%Loc_Toolset%"=="v140" (
        set "Loc_CMake_Generator=NMake Makefiles JOM"
    )

    rem
    rem Platform
    rem
    if "%Loc_Platform%"=="win64" (
        set "Loc_VcVarsAllArgs=amd64"
    )

    if "%Loc_Platform%"=="win32" (
        set "Loc_VcVarsAllArgs=x86"
    )
)

rem set "Loc_CMake_Generator=%Loc_CMake_Generator% %Loc_CMake_GeneratorArgs%"

echo. & echo Locals in %0 
set Loc_
echo.

endlocal & set "Package_VisualStudioDir=%Loc_VisualStudioDir%" & set "Package_CMake_Generator=%Loc_CMake_Generator%" & set "Package_VcVarsAll=%Loc_VcVarsAll%" & set "Package_VcVarsAllArgs=%Loc_VcVarsAllArgs%"