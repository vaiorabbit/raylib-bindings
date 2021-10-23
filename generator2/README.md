# Usage #

These instructions are tested only on macOS environment.

*   Generate mapping tables with ./generate_initial_mapping.sh to get
    *   raylib_cindex_mapping.json
    *   raylib_define_mapping.json

*   Edit raylib_define_mapping.json
    *   This mapping table contains '#define' macros collected from headers in ../raylib_dll/raylib/src folder.
    *   Each lines represent key-value pair that will be used for generated Python codes.
        *   ex.) The line collected from 'raylib.h":
                "RAYLIB_VERSION" : "\"4.0\""
            will be appeared in raylib.py:
                RAYLIB_VERSION = "4.0"
        *   So if you find value that is inappropreate for Python syntax,
            you should fix it or make it 'null'. The 'null'ed marcros will not
            appear in the generated Python codes.

*   Run batch_generate.sh
