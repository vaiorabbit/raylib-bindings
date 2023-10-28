import json
import raylib_parser, raylib_generator_mruby

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raylib.h')
    raylib_parser.execute(ctx)

    api_schema = None

    raylib_generator_mruby.sanitize(ctx)
    raylib_generator_mruby.generate(ctx,
                              module_name = 'raylib'
                              )
