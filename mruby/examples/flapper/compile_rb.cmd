@echo off
setlocal enabledelayedexpansion

pushd %~dp0

set REPO_ROOT="..\..\..\"
set MRUBY_ROOT="%REPO_ROOT%\mruby"
set MRBC_BIN="%MRUBY_ROOT%\bin\host\bin\mrbc.exe"

%MRBC_BIN% -Bruby_code -o .\ruby_code.h ..\rb\code_flapper.rb

popd
