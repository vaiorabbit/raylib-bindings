import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/rlgl.h')
    raylib_parser.execute(ctx)

    omit_structs = [
        'Matrix',
    ]
    for key in omit_structs:
        ctx.decl_structs.pop(key, None)

    omit_macros = [
        'RL_DEFAULT_BATCH_BUFFERS',
        'RL_DEFAULT_BATCH_DRAWCALLS',
        'RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS',
        'RL_MAX_MATRIX_STACK_SIZE',
        'RL_MAX_SHADER_LOCATIONS',
        'RL_CULL_DISTANCE_NEAR',
        'RL_CULL_DISTANCE_FAR',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT',
        'RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2',
    ]
    for key in omit_macros:
        ctx.decl_macros.pop(key, None)

    api_schema = None
    with open('./rlgl_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'rlgl', json_schema = api_schema)
