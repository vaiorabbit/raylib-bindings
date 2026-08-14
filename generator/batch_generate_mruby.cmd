@echo off
set PYTHONPATH=.\clang
python generate_mruby_all.py > ../mruby/mrbgems/mruby-raylib/src/module_raylib.c
