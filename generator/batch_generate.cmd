@echo off
set PYTHONPATH=.\clang
python generate_config.py > ../lib/config.rb
python generate_raylib.py > ../lib/raylib_main.rb
python generate_raymath.py > ../lib/raymath.rb
python generate_rlgl.py > ../lib/rlgl.rb
python generate_raygui.py > ../lib/raygui_main.rb
python generate_physac.py > ../lib/physac.rb
