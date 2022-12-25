import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raygui_dll/raygui/src/raygui.h')
    raylib_parser.execute(ctx, ["-DRAYGUI_STANDALONE"])

    omit_structs = [
        'Vector2',
        'Vector3',
        'Color',
        'Rectangle',
        'Texture2D',
        'Image',
        'GlyphInfo',
        'Font',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    api_schema = None
    with open('./raygui_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'raygui', json_schema = api_schema)
