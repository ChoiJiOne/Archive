@echo off

echo Generate Project Files ...

SET visualstudio=%1
SET project=02.GettingStarted
SET premake5=..\\Bin\\premake5.exe

if "%visualstudio%" == "" (
    echo make a choice visual studio version vs2019 or vs2022...
    GOTO:EOF
)

echo run premake5.exe...
%premake5% %visualstudio%

echo start visual studio solution...
start %project%\\%project%.sln
PAUSE
