#!/usr/local/bin/zsh
export PYTHONPATH=/opt/homebrew/opt/llvm/lib/python3.13/site-packages
/opt/homebrew/bin/python3 generate_config.py > ../lib/config.rb
/opt/homebrew/bin/python3 generate_raylib.py > ../lib/raylib_main.rb
/opt/homebrew/bin/python3 generate_raymath.py > ../lib/raymath.rb
/opt/homebrew/bin/python3 generate_rcamera.py > ../lib/rcamera.rb
/opt/homebrew/bin/python3 generate_rlgl.py > ../lib/rlgl.rb
/opt/homebrew/bin/python3 generate_raygui.py > ../lib/raygui_main.rb
/opt/homebrew/bin/python3 generate_physac.py > ../lib/physac.rb
