@echo off
pushd %CD%
cd ..
for /f "delims=" %%f in ('dir ^*.gem /b ^| findstr .gem$') do (
    echo gem push %%f
)
popd
