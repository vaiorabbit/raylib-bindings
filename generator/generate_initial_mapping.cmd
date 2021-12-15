@echo off
python generate_initial_cindex_mapping.py > raylib_cindex_mapping.json
python generate_initial_define_mapping.py > raylib_define_mapping.json
