#!/usr/local/bin/zsh
export PYTHONPATH=/opt/homebrew/opt/llvm/lib/python3.11/site-packages
/opt/homebrew/bin/python3 generate_mruby_all.py > ../mruby/mrbgems/mruby-raylib/src/module_raylib.c
