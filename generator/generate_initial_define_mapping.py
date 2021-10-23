# PYTHONPATH=/usr/local/Cellar/llvm/6.0.0/lib/python2.7/site-packages python generate_initial_define_mapping.py > raylib_define_mapping.json

import raylib_parser, raylib_generator

if __name__ == "__main__":
    raylib_parser.generate_define_list()
