require_relative 'util/setup_dll'
require_relative 'util/resource_path'

MAX_LIGHTS = 4

# enum LightTYpe
LIGHT_DIRECTIONAL = 0
LIGHT_POINT = 1

$lightsCount = 0

class Light
  attr_accessor :enabled, :type, :position, :target, :color
  attr_accessor :enabledLoc, :typeLoc, :positionLoc, :targetLoc, :colorLoc
  attr_accessor :enabled_buf, :type_buf

  def initialize(type, position, target, color, shader)
    @enabled = true
    @type = type
    @position = position
    @target = target
    @color = color

    # Shader locations
    @enabledLoc = GetShaderLocation(shader, "lights[#{$lightsCount}].enabled")
    @typeLoc = GetShaderLocation(shader, "lights[#{$lightsCount}].type")
    @positionLoc = GetShaderLocation(shader, "lights[#{$lightsCount}].position")
    @targetLoc = GetShaderLocation(shader, "lights[#{$lightsCount}].target")
    @colorLoc = GetShaderLocation(shader, "lights[#{$lightsCount}].color")

    # Buffers for pointer handling
    @enabled_buf = FFI::MemoryPointer.new(:bool, 1)
    @type_buf = FFI::MemoryPointer.new(:int, 1)
  end
end

def UpdateLightValues(shader, light)
  # Send to shader light enabled state and type
  light.enabled_buf.write(:bool, light.enabled)
  SetShaderValue(shader, light.enabledLoc, light.enabled_buf, SHADER_UNIFORM_INT)
  light.type_buf.write(:int, light.type)
  SetShaderValue(shader, light.typeLoc, light.type_buf, SHADER_UNIFORM_INT)

  # Send to shader light position values
  position = [light.position.x, light.position.y, light.position.z].pack('f3')
  SetShaderValue(shader, light.positionLoc, position, SHADER_UNIFORM_VEC3)

  # Send to shader light target position values
  target = [light.target.x, light.target.y, light.target.z].pack('f3')
  SetShaderValue(shader, light.targetLoc, target, SHADER_UNIFORM_VEC3)

  # Send to shader light color values
  color = [light.color.r/255.0, light.color.g/255.0, light.color.b/255.0, light.color.a/255.0].pack('f4')
  SetShaderValue(shader, light.colorLoc, color, SHADER_UNIFORM_VEC4)
end

def CreateLight(type, position, target, color, shader)
  light = nil

  if $lightsCount < MAX_LIGHTS
    light = Light.new(type, position, target, color, shader)
    UpdateLightValues(shader, light)
    $lightsCount += 1
  end

  return light
end

if __FILE__ == $PROGRAM_NAME

  GLSL_VERSION = 330

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - basic lighting")

  camera = Camera.new
             .with_position(2.0, 4.0, 6.0)
             .with_target(0.0, 0.5, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  # Load plane model from a generated mesh
  model = LoadModelFromMesh(GenMeshPlane(10.0, 10.0, 3, 3))
  cube = LoadModelFromMesh(GenMeshCube(2.0, 4.0, 2.0))

  shader = LoadShader(RAYLIB_SHADERS_PATH + "shaders/glsl#{GLSL_VERSION}/lighting.vs",
                      RAYLIB_SHADERS_PATH + "shaders/glsl#{GLSL_VERSION}/lighting.fs")

  # Get some required shader loactions
  location_vector_view_ptr = shader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_VECTOR_VIEW)
  location_vector_view_ptr.write_int32(GetShaderLocation(shader, "viewPos"))

  # NOTE: "matModel" location name is automatically assigned on shader loading,
  # no need to get the location again if using that uniform name
  # shader.locs[SHADER_LOC_MATRIX_MODEL] = GetShaderLocation(shader, "matModel");

  # Ambient light level (some basic lighting)
  ambientLoc = GetShaderLocation(shader, "ambient")
  SetShaderValue(shader, ambientLoc, [0.1, 0.1, 0.1, 1.0].pack('f4'), SHADER_UNIFORM_VEC4)

  # Assign out lighting shader to model
  # [Ruby-raylib TODO] prepare convenient accessors for Material/Model members
  model_materials_0 = Material.new(model[:materials])
  model_materials_0[:shader] = shader
  cube_materials_0 = Material.new(cube[:materials])
  cube_materials_0[:shader] = shader

  # Using 4 point lights: gold, red, green and blue
  lights = [
    CreateLight(LIGHT_POINT, Vector3.create( -2, 1, -2), Vector3Zero(), YELLOW, shader),
    CreateLight(LIGHT_POINT, Vector3.create( 2, 1, 2), Vector3Zero(), RED, shader),
    CreateLight(LIGHT_POINT, Vector3.create( -2, 1, 2), Vector3Zero(), GREEN, shader),
    CreateLight(LIGHT_POINT, Vector3.create( 2, 1, -2), Vector3Zero(), BLUE, shader),
  ]

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    # Check key inputs to enable/disable lights
    lights[0].enabled = !lights[0].enabled if IsKeyPressed(KEY_Y)
    lights[1].enabled = !lights[1].enabled if IsKeyPressed(KEY_R)
    lights[2].enabled = !lights[2].enabled if IsKeyPressed(KEY_G)
    lights[3].enabled = !lights[3].enabled if IsKeyPressed(KEY_B)

    lights.each do |light|
      UpdateLightValues(shader, light)
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(model, Vector3Zero(), 1.0, WHITE)
        DrawModel(cube, Vector3Zero(), 1.0, WHITE)
        lights.each do |light|
          if light.enabled
            DrawSphereEx(light.position, 0.2, 8, 8, light.color)
          else
            DrawSphereWires(light.position, 0.2, 8, 8, ColorAlpha(light.color, 0.3))
          end
        end
      EndMode3D()
      DrawFPS(10, 10)
      DrawText("Use keys [Y][R][G][B] to toggle lights", 10, 40, 20, DARKGRAY)
    EndDrawing()
  end

  UnloadShader(shader)
  CloseWindow()
end
