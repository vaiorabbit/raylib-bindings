#!/usr/local/bin/zsh
export PYTHONPATH=/opt/homebrew/opt/llvm/lib/python3.9/site-packages
/opt/homebrew/bin/python3 generate_raylib.py > ../lib/raylib_main.rb
/opt/homebrew/bin/python3 generate_raymath.py > ../lib/raymath.rb
/opt/homebrew/bin/python3 generate_rlgl.py > ../lib/rlgl.rb
