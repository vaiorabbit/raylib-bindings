import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raymath.h')
    raylib_parser.execute(ctx, ["-DDEG2RAD", "-DRAD2DEG"])

    omit_structs = [
        'Vector2',
        'Vector3',
        'Vector4',
        'Matrix',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    api_schema = None
    with open('./raymath_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'raymath', json_schema = api_schema)
