import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raymath.h')
    raylib_parser.execute(ctx)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'raymath')
