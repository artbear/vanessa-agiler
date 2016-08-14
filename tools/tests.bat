echo off
SET mypath=%~dp0
SETLOCAL

set BUILDPATH=.\build

set RUNNER_IBNAME=/F"%BUILDPATH%/ib"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890

SET RUNNER_ENV=production

IF "%~1"=="" (
    set mode="./tools/JSON/VBParams837UF.json"
) else (
    set mode=%1
)


echo "vanessa"
oscript -encoding=utf-8 %mypath%/runner.os vanessa --path "%BUILDPATH%/out/vanessa-behavior.epf" --pathsettings "%mode%"
exit /B
