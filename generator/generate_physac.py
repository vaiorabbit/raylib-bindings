import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../physac_dll/Physac/src/physac.h')
    raylib_parser.execute(ctx, ['-DPHYSAC_STATIC', '-DPHYSAC_STANDALONE'])

    omit_structs = [
        'Vector2',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    api_schema = None
    with open('./physac_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'physac', json_schema = api_schema)
