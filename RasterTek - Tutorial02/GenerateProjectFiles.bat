@echo off

echo Start GenerateProjectFiles.bat script...

SET vsoption=%1
SET vs2019="Visual Studio 16 2019"
SET vs2022="Visual Studio 17 2022"

if not exist Build (
    echo make Build directory...
    mkdir Build
)

if "%vsoption%" == "" (
    echo Please enter the Visual Studio version...
    GOTO:EOF
)

@REM 현재 경로 저장
pushd %~dp0%

@REM Build 디렉토리 이동
pushd %~dp0\\Build

@REM cmake 실행
if "%vsoption%" == "vs2019" (
    echo Your Visual Studio version is %vsoption%...
    echo Start cmake...
    cmake .. -G %vs2019% -A "x64"
) else if "%vsoption%" == "vs2022" (
    echo Your Visual Studio version is %vsoption%...
    echo Start cmake...
    cmake .. -G %vs2022% -A "x64"
) else (
    echo Your Visual Studio version %vsoption% is illegal...
    GOTO:EOF
)

@REM 이전 디렉토리로 이동
popd