@echo off
set RUBY=ruby
set HOME=%~dp0
set APP=%~n0
set LOG=%APP%.log
set FACTER_HOME=%HOME%
set FACTER_INI=%APP%.ini
set FACTER_LOG=%APP%.log
set FACTER_ARGUMENTS=%*
if "%*" == "" set FACTER_ARGUMENTS=none
echo INFO Starting %APP% application from %HOME%
cd %HOME% && %RUBY% .\%APP%.rb
set /A EXIT_CODE=%ERRORLEVEL%
IF not %EXIT_CODE% == 0 (
  echo ERROR exception encountered, exit code %EXIT_CODE%!
)
echo INFO Finished running %APP% application from %HOME%
EXIT /B %EXIT_CODE%
