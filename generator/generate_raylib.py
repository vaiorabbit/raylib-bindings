import raylib_parser, raylib_generator

STRUCT_POSTFIX_RAYLIB = """
  Texture2D = Texture
  TextureCubemap = Texture
  Camera = Camera3D
  Quaternion = Vector4
  RenderTexture2D = RenderTexture;
"""

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raylib.h')
    raylib_parser.execute(ctx)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx,
                              module_name = 'raylib',
                              struct_postfix = STRUCT_POSTFIX_RAYLIB)
