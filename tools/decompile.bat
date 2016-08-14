SET mypath=%~dp0
rem SET connstring=--ibname /F"C:\Users\eugens\Documents\Rarus\ITIL\1"
rem SET USERPWD=--db-user base --db-pwd 234567890
SET connstring=
SET USERPWD=
SET RUNNER_ENV=production

set BUILDPATH=.\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

SET connstring=--ibname /F"%BUILDPATH%\ib"

oscript -encoding=utf-8 %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\..\ %connstring% 
