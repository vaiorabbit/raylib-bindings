# PYTHONPATH=/usr/local/Cellar/llvm/7.0.0/lib/python2.7/site-packages python generate_initial_cindex_mapping.py > raylib_cindex_mapping.json

import raylib_parser, raylib_generator

if __name__ == "__main__":
    raylib_parser.generate_type_mapping()
