@echo off

rem Parameters:
rem %1: Package_Generator
rem %2: Package_Platform
rem %3: Package_Toolset

setlocal
set "Loc_Generator=%~1"
set "Loc_Platform=%~2"
set "Loc_Toolset=%~3"
set "Loc_CMake_Generator=The ID string "%Loc_Generator%.%Loc_Platform%.%Loc_Toolset%" does not yield a supported CMake generator."
set "Loc_CMake_GeneratorArgs="
set "Loc_VisualStudioDir=The ID string "%Loc_Generator%.%Loc_Platform%.%Loc_Toolset%" does not yield a supported Visual Studio version"
set "Loc_VcVarsAll=The ID string "%Loc_Generator%.%Loc_Platform%.%Loc_Toolset%" does not yield a supported Visual Studio version"
set "Loc_VcVarsAllArgs="

rem
rem Visual Studio:
rem
if "%Loc_Toolset%"=="v100" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 10.0"
)

if "%Loc_Toolset%"=="v110" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 11.0"
)

if "%Loc_Toolset%"=="v120" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 12.0"
)

if "%Loc_Toolset%"=="v140" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0"
)


set "Loc_VcVarsAll=%Loc_VisualStudioDir%\VC\vcvarsall.bat"

if "%Loc_Generator%"=="msbuild" (
    rem
    rem Generator:
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

    if "%Loc_Platform%"=="x86" (
        set "Loc_CMake_GeneratorArgs="
    )

    if "%Loc_Platform%"=="x64" (
        set "Loc_CMake_GeneratorArgs=Win64"
    )
)

rem Compose (=> DelayedExpansion)
set "Loc_CMake_Generator=%Loc_CMake_Generator% %Loc_CMake_GeneratorArgs%"

if "%Loc_Generator%"=="nmake" (
    set "Loc_CMake_Generator=NMake Makefiles"

    if "%Loc_Platform%"=="x64" (
        set "Loc_VcVarsAllArgs=amd64"
    )

    if "%Loc_Platform%"=="x86" (
        set "Loc_VcVarsAllArgs=x86"
    )
)

if "%Loc_Generator%"=="jom" (
    set "Loc_CMake_Generator=NMake Makefiles JOM"

    if "%Loc_Platform%"=="x64" (
        set "Loc_VcVarsAllArgs=amd64"
    )

    if "%Loc_Platform%"=="x86" (
        set "Loc_VcVarsAllArgs=x86"
    )
)

echo. & echo Locals in %0 
set Loc_
echo.

endlocal & set "Package_VisualStudioDir=%Loc_VisualStudioDir%" & set "Package_CMake_Generator=%Loc_CMake_Generator%" & set "Package_VcVarsAll=%Loc_VcVarsAll%" & set "Package_VcVarsAllArgs=%Loc_VcVarsAllArgs%"