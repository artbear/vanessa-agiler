echo off
SET mypath=%~dp0
SETLOCAL

set BUILDPATH=.\build

set RUNNER_IBNAME=/F"%BUILDPATH%/ib"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890

SET RUNNER_ENV=production

echo "watch"
rem oscript %mypath%/runner.os watch compile.json --filter srcexmaples
oscript -encoding=utf-8 %mypath%/runner.os watch ./compile.json
exit /B
