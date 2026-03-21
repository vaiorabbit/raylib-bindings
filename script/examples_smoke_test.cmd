@echo off
setlocal
ruby "%~dp0examples_smoke_test.rb" %*
exit /b %ERRORLEVEL%
