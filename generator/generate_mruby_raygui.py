import json
import raylib_parser, raylib_generator_mruby

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raygui_dll/raygui/src/raygui.h')
    raylib_parser.execute(ctx, ["-DRAYGUI_STANDALONE"])

    omit_structs = [
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
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    raylib_generator_mruby.sanitize(ctx)
    raylib_generator_mruby.generate(ctx,
                                    module_name = 'raygui',
                                    generate_rclassraylib = False
                              )
