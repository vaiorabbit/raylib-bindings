import json
import raylib_parser, raylib_generator

RAYLIB_STRUCT_ALIAS = {
    "Vector4": ["Quaternion"],
    "Texture": ["Texture2D", "TextureCubemap"],
    "RenderTexture": ["RenderTexture2D"],
    "Camera3D": ["Camera"],
}

FUNCTION_PREFIX = """  # DrawModelEx : Draw a model with extended parameters
  # @param model [Model]
  # @param position [Vector3]
  # @param rotationAxis [Vector3]
  # @param rotationAngle [float]
  # @param scale [Vector3]
  # @param tint [Color]
  # @return [void]
  def DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
    # [NOTE] Fixing unintended matrix modification
    # - In C, DrawModelEx uses the whole copy of `model` on stack, which will never affect the content of original `model`.
    #   But Ruby FFI seems to pass the reference of `model` to DrawModelEx, which results in transform accumulation (e.g.:`model` get rotated by `rotationAngle` around `rotationAxis` every frame).
    #   So here I copy the transform into `mtx_clone` and copy back this to the original after finished calling DrawModelEx.
    # - Other DrawXXX members (DrawModel, DrawModelWires, DrawModelWiresEx) are free from this problem.
    #   - They call DrawModelEx in C layer, which will use the copy of `model` on stack.
    mtx_clone = model[:transform].clone
    internalDrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
    model[:transform] = mtx_clone
  end
"""

if __name__ == "__main__":

    ctx = raylib_parser.ParseContext('../raylib_dll/raylib/src/raylib.h')
    raylib_parser.execute(ctx)

    ctx.decl_functions["DrawModelEx"].explicit_name = 'internalDrawModelEx'

    api_schema = None
    with open('./raylib_api.json') as f:
        api_schema = json.load(f)

    raylib_generator.sanitize(ctx)
    raylib_generator.generate(ctx,
                              module_name = 'raylib',
                              struct_alias = RAYLIB_STRUCT_ALIAS,
                              #function_prefix = FUNCTION_PREFIX,
                              json_schema = api_schema
                              )
