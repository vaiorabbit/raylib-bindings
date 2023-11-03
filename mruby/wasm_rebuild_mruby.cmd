rmdir /s /q .\mruby

git clone --depth=1 https://github.com/mruby/mruby.git

copy .\mruby_script\default.rb .\mruby\build_config
copy .\mruby_script\emscripten.rb .\mruby\build_config

set WORKDIR=%cd%
cd .\mruby
subst M: %cd%
cd /d M:
call rake
cd /d %WORKDIR%
subst M: /d
