import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/rlgl.h')
    raylib_parser.execute(ctx)

    omit_structs = [
        'Matrix',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'rlgl')
