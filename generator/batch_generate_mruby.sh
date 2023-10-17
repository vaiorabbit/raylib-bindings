#!/usr/local/bin/zsh
export PYTHONPATH=/opt/homebrew/opt/llvm/lib/python3.11/site-packages
/opt/homebrew/bin/python3 generate_mruby_raylib.py > ../lib/mrb_raylib.c
