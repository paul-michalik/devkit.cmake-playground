@echo off

setlocal
for /f "tokens=1-5 delims=." %%A in ("%~1") do call :setUpParams %%A %%B %%C %%D %%E
goto :endOfProc

:setUpParams
    set "Package_Name=%~1" 
    set "Package_Generator=%~2" 
    set "Package_Platform=%~3" 
    set "Package_Toolset=%~4"
    set "Package_Configuration=%~5"
goto :endOfProc

:endOfProc
endlocal & set "Package_Name=%Package_Name%" & set "Package_Generator=%Package_Generator%" & set "Package_Platform=%Package_Platform%" & set "Package_Toolset=%Package_Toolset%" & set "Package_Configuration=%Package_Configuration%"