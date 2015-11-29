@echo off

rem Parameters:
rem %1: Package_Platform
rem %2: Package_Toolset

setlocal
set "Package_Platform=%~1"
set "Package_Toolset=%~2"

set "Package_CMake_Generator="
set "Package_VisualStudioDir="
set "Package_VcVarsAll="
set "Package_VcVarsAllArgs="

rem Local vars:
set "VcVarsAll="
set "VcVarsAllArgs="
set "CMakeGeneratorArgs="


rem
rem Visual Studio:
rem
if "%Package_Toolset%"=="v100" (
    set "Package_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
)

if "%Package_Toolset%"=="v110" (
    set "Package_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
)

if "%Package_Toolset%"=="v120" (
    set "Package_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 13.0\VC\vcvarsall.bat"
)

if "%Package_Toolset%"=="v140" (
    set "Package_VisualStudioDir=%CommonProgramFiles(x86)%\Microsoft Visual Studio 15.0\VC\vcvarsall.bat"
)


if "%Package_Generator%"=="msbuild" (
    rem
    rem Generator
    rem
    if "%Package_Toolset%"=="v100" (
        set "Package_CMake_Generator=Visual Studio 10 2010"
    )

    if "%Package_Toolset%"=="v110" (
        set "Package_CMake_Generator=Visual Studio 11 2012"
    )

    if "%Package_Toolset%"=="v120" (
        set "Package_CMake_Generator=Visual Studio 12 2013"
    )

    if "%Package_Toolset%"=="v140" (
        set "Package_CMake_Generator=Visual Studio 14 2015"
    )

    rem
    rem Platform
    rem
    if "%Package_Platform%"=="win32" (
        set "CMakeGeneratorArgs="
    )

    if "%Package_Platform%"=="win64" (
        set "CMakeGeneratorArgs=Win64"
    )
)

if "%Package_Generator%"=="jom" (
    rem
    rem Generator
    rem
    if "%Package_Toolset%"=="v110" (
        set "Package_CMake_Generator=NMake Makefiles JOM"
        set "VcVarsAll=%Package_VisualStudioDir%\VC\vcvarsall.bat"
    )

    if "%Package_Toolset%"=="v120" (
        set "Package_CMake_Generator=NMake Makefiles JOM"
        set "VcVarsAll=%Package_VisualStudioDir%\VC\vcvarsall.bat"
    )

    if "%Package_Toolset%"=="v140" (
        set "Package_CMake_Generator=NMake Makefiles JOM"
        set "VcVarsAll=%Package_VisualStudioDir%\VC\vcvarsall.bat"
    )

    rem
    rem Platform
    rem
    if "%Package_Platform%"=="win64" (
        set "VcVarsAllArgs=amd64"
    )

    if "%Package_Platform%"=="win32" (
        set "VcVarsAllArgs=x86"
    )
)

set "Package_CMake_Generator=%Package_CMake_Generator% %CMakeGeneratorArgs%"
set "Package_VcVarsAll=%VcVarsAll%"
set "Package_VcVarsAllArgs=%VcVarsAllArgs%"

endlocal & set "Package_VisualStudioDir=%Package_VisualStudioDir%" & set "Package_CMake_Generator=%Package_CMake_Generator%" & set "Package_VcVarsAll=%Package_VcVarsAll%" & set "Package_VcVarsAllArgs=%Package_VcVarsAllArgs%"