import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/rcamera.h')
    raylib_parser.execute(ctx, ["-DCAMERA_STANDALONE"])

    omit_structs = [
        'Vector2',
        'Vector3',
        'Camera3D',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    api_schema = None
    with open('./rcamera_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'rcamera', json_schema = api_schema)
