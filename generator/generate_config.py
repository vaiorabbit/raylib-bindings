import json
import raylib_parser, raylib_generator

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/config.h')
    raylib_parser.execute(ctx)

    api_schema = None
    with open('./config_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx, module_name = 'config', json_schema = api_schema)
