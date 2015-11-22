@echo off

setlocal
set "Package_CMake_Generator="
set "Package_VcVarsAllCmdLine="

rem Local vars:
set "VcVarsAll="
set "VcVarsAllArgs="
set "CMakeGeneratorArgs="
if "%Package_Generator%"=="msbuild" (
    rem
    rem Generator
    rem
    if "%Package_Toolset%"=="v110" (
        set "Package_CMake_Generator=Visual Studio 11 2012"
    )

    if "%Package_Toolset%"=="v120" (
        set "Package_CMake_Generator=Visual Studio 12 2013"
    )

    if "%Package_Toolset%"=="v130" (
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
        set "VcVarsAll=%CommonProgramFiles(x86)%\Microsoft Visual Studio 11.0\VC\vcvarsall.bat"
    )

    if "%Package_Toolset%"=="v120" (
        set "Package_CMake_Generator=NMake Makefiles JOM"
        set "VcVarsAll=%CommonProgramFiles(x86)%\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
    )

    if "%Package_Toolset%"=="v130" (
        set "Package_CMake_Generator=NMake Makefiles JOM"
        set "VcVarsAll=%CommonProgramFiles(x86)%\Microsoft Visual Studio 13.0\VC\vcvarsall.bat"
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
set "Package_VcVarsAllCmdLine="%VcVarsAll%" %VcVarsAllArgs%"

endlocal & set "Package_CMake_Generator=%Package_CMake_Generator%" & set "Package_VcVarsAllCmdLine=%Package_VcVarsAllCmdLine%"