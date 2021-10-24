import raylib_parser, raylib_generator

RAYLIB_STRUCT_ALIAS = {
    "Vector4": ["Quaternion"],
    "Texture": ["Texture2D", "TextureCubemap"],
    "RenderTexture": ["RenderTexture2D"],
    "Camera3D": ["Camera"],
}

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raylib.h')
    raylib_parser.execute(ctx)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx,
                              module_name = 'raylib',
                              struct_alias = RAYLIB_STRUCT_ALIAS)
