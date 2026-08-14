import raylib_parser, raylib_generator_mruby

if __name__ == "__main__":

    ctx_raylib = raylib_parser.ParseContext('../raylib_dll/raylib/src/raylib.h')
    raylib_parser.execute(ctx_raylib)
    raylib_generator_mruby.sanitize(ctx_raylib)

    ctx_raygui = raylib_parser.ParseContext('../raygui_dll/raygui/src/raygui.h')
    raylib_parser.execute(ctx_raygui, ["-DRAYGUI_STANDALONE"])
    # Already declared (identically) by raylib.h; keep the raylib-owned bindings only.
    raygui_omit_structs = [
        'Vector2',
        'Vector3',
        'Color',
        'Rectangle',
        'Texture',
        'Texture2D',
        'Image',
        'GlyphInfo',
        'Font',
    ]
    for key in raygui_omit_structs:
        ctx_raygui.decl_structs.pop(key, None)
    raylib_generator_mruby.sanitize(ctx_raygui)

    ctx_physac = raylib_parser.ParseContext('../physac_dll/physac/src/physac.h')
    raylib_parser.execute(ctx_physac, ['-DPHYSAC_STATIC', '-DPHYSAC_STANDALONE'])
    # Already declared (identically) by raylib.h; keep the raylib-owned bindings only.
    physac_omit_structs = [
        'Vector2',
    ]
    for key in physac_omit_structs:
        ctx_physac.decl_structs.pop(key, None)
    raylib_generator_mruby.sanitize(ctx_physac)

    indent = "    "

    raylib_generator_mruby.generate_header_comment()
    raylib_generator_mruby.generate_includes()
    raylib_generator_mruby.generate_mRaylib_global()

    raylib_generator_mruby.generate_structs(ctx_raylib)
    raylib_generator_mruby.generate_structs(ctx_raygui)
    raylib_generator_mruby.generate_structs(ctx_physac)

    raylib_generator_mruby.generate_functions(ctx_raylib, indent, 'raylib')
    raylib_generator_mruby.generate_functions(ctx_raygui, indent, 'raygui')
    raylib_generator_mruby.generate_functions(ctx_physac, indent, 'physac')

    raylib_generator_mruby.generate_module_init(ctx_raylib, module_name = 'raylib', define_module = True, indent = indent)
    raylib_generator_mruby.generate_module_init(ctx_raygui, module_name = 'raygui', define_module = False, indent = indent)
    raylib_generator_mruby.generate_module_init(ctx_physac, module_name = 'physac', define_module = False, indent = indent)
