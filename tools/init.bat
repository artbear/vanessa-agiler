echo off
SET mypath=%~dp0
SETLOCAL

set BUILDPATH=.\build
if not exist %BUILDPATH% set BUILDPATH=..\build

SET RUNNER_ENV=production

IF "%~1"=="" (
set mode="./src/cf/"
) else (
set mode=%1
)

echo "init"
oscript -encoding=utf-8 %mypath%/init.os init-dev --src %mode%
oscript -encoding=utf-8 %mypath%/init.os init-dev --src %mode% --dev
exit /B
