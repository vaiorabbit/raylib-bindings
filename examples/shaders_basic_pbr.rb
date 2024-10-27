require_relative 'util/setup_dll'
require_relative 'util/resource_path'

SHADER_LOC_MAP_MRA = SHADER_LOC_MAP_METALNESS
MATERIAL_MAP_MRA   = MATERIAL_MAP_METALNESS

class PBRLight
  attr_accessor :id
  attr_accessor :enabled, :type, :position, :target, :color, :intensity
  attr_accessor :enabledLoc, :typeLoc, :positionLoc, :targetLoc, :colorLoc, :intensityLoc
  attr_accessor :enabled_buf, :type_buf, :intensity_buf

  def initialize(id, type, position, target, color, intensity, shader)
    @id = id
    @enabled = true
    @type = type
    @position = position
    @target = target
    @color = [color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0]
    @intensity = intensity

    # Shader locations
    @enabledLoc = GetShaderLocation(shader, "lights[#{@id}].enabled")
    @typeLoc = GetShaderLocation(shader, "lights[#{@id}].type")
    @positionLoc = GetShaderLocation(shader, "lights[#{@id}].position")
    @targetLoc = GetShaderLocation(shader, "lights[#{@id}].target")
    @colorLoc = GetShaderLocation(shader, "lights[#{@id}].color")
    @intensityLoc = GetShaderLocation(shader, "lights[#{@id}].intensity")

    # Buffers for pointer handling
    @enabled_buf = FFI::MemoryPointer.new(:int, 1)
    @type_buf = FFI::MemoryPointer.new(:int, 1)
    @intensity_buf = FFI::MemoryPointer.new(:float, 1)
  end

  def update(shader)
    @enabled_buf.write(:int, @enabled ? 1 : 0)
    SetShaderValue(shader, @enabledLoc, @enabled_buf, SHADER_UNIFORM_INT)

    @type_buf.write(:int, @type)
    SetShaderValue(shader, @typeLoc, @type_buf, SHADER_UNIFORM_INT)

    # Send to shader light position values
    position = [@position.x, @position.y, @position.z].pack('f3')
    SetShaderValue(shader, @positionLoc, position, SHADER_UNIFORM_VEC3)

    # Send to shader light target position values
    target = [@target.x, @target.y, @target.z].pack('f3')
    SetShaderValue(shader, @targetLoc, target, SHADER_UNIFORM_VEC3)

    # Send to shader light color values
    color = @color.pack('f4')
    SetShaderValue(shader, @colorLoc, color, SHADER_UNIFORM_VEC4)

    @intensity_buf.write(:float, @intensity)
    SetShaderValue(shader, @intensityLoc, @intensity_buf, SHADER_UNIFORM_FLOAT)
  end

  def self.set_ambient(shader, color, intensity)
    c = [color.r/255.0, color.g/255.0, color.b/255.0].pack('f3')
    SetShaderValue(shader, GetShaderLocation(shader, "ambientColor"), c, SHADER_UNIFORM_VEC3)

    intensity_buf = FFI::MemoryPointer.new(:float, 1)
    intensity_buf.write(:float, intensity)
    SetShaderValue(shader, GetShaderLocation(shader, "ambient"), intensity_buf, SHADER_UNIFORM_FLOAT)
  end

end

# enum PBRLightType
LIGHT_DIRECTIONAL = 0
LIGHT_POINT = 1
LIGHT_SPOT = 2

# enum PBRColorType
PBR_COLOR_ALBEDO = 0
PBR_COLOR_EMISSIVE = 1

# enum PBRVec2Type
PBR_VEC2_TILING = 0
PBR_VEC2_OFFSET = 1

# enum PBRFloatType
PBR_PARAM_NORMAL = 0
PBR_PARAM_METALLIC = 1
PBR_PARAM_ROUGHNESS = 2
PBR_PARAM_EMISSIVE = 3
PBR_PARAM_AO = 4

# enum PBRTexType
PBR_TEXTURE_ALBEDO = MATERIAL_MAP_ALBEDO
PBR_TEXTURE_NORMAL = MATERIAL_MAP_NORMAL
PBR_TEXTURE_MRA = MATERIAL_MAP_METALNESS
PBR_TEXTURE_EMISSIVE = MATERIAL_MAP_EMISSION

class PBRMaterial
  attr_accessor :pbrShader, :albedo, :normal, :metallic, :roughness, :ao, :emissive, :ambient, :emissivePower
  attr_accessor :texAlbedo, :texNormal, :texMRA, :texEmissive, :texTiling, :texOffset
  attr_accessor :useTexAlbedo, :useTexNormal, :useTexMRA, :useTexEmissive
  attr_accessor :albedoLoc, :normalLoc, :metallicLoc, :roughnessLoc, :aoLoc, :emissiveColorLoc, :emissivePowerLoc, :texTilingLoc, :texOffsetLoc, :useTexAlbedoLoc, :useTexNormalLoc, :useTexMRALoc, :useTexEmissiveLoc
  attr_accessor :emissivePower_buf, :metallic_buf, :roughness_buf, :ao_buf, :normal_buf, :useTexAlbedo_buf, :useTexNormal_buf, :useTexMRA_buf, :useTexEmissive_buf

  def initialize
    @pbrShader = nil
    @albedo = [0.0, 0.0, 0.0, 0.0]
    @normal = 0.0
    @metallic = 0.0
    @roughness = 0.0
    @ao = 0.0
    @emissive = [0.0, 0.0, 0.0, 0.0]
    @ambient = [0.0, 0.0, 0.0]
    @emissivePower = 0.0

    @texAlbedo = nil
    @texNormal = nil
    @texMRA = nil
    @texEmissive = nil

    @texTiling = [0.0, 0.0]
    @texOffset = [0.0, 0.0]

    @useTexAlbedo = 0
    @useTexNormal = 0
    @useTexMRA = 0
    @useTexEmissive = 0

    @albedoLoc = 0
    @normalLoc = 0
    @metallicLoc = 0
    @roughnessLoc = 0
    @aoLoc = 0
    @emissiveColorLoc = 0
    @emissivePowerLoc = 0

    @texTilingLoc = 0
    @texOffsetLoc = 0

    @useTexAlbedoLoc = 0
    @useTexNormalLoc = 0
    @useTexMRALoc = 0
    @useTexEmissiveLoc = 0

    @emissivePower_buf = FFI::MemoryPointer.new(:float, 1)
    @metallic_buf = FFI::MemoryPointer.new(:float, 1)
    @roughness_buf = FFI::MemoryPointer.new(:float, 1)
    @ao_buf = FFI::MemoryPointer.new(:float, 1)
    @normal_buf = FFI::MemoryPointer.new(:float, 1)

    @useTexAlbedo_buf = FFI::MemoryPointer.new(:int, 1)
    @useTexNormal_buf = FFI::MemoryPointer.new(:int, 1)
    @useTexMRA_buf = FFI::MemoryPointer.new(:int, 1)
    @useTexEmissive_buf = FFI::MemoryPointer.new(:int, 1)
  end

  def setup(pbrShader)
    @pbrShader = pbrShader

    @texAlbedo = nil
    @texNormal = nil
    @texMRA = nil
    @texEmissive = nil

    # PBRParam
    @albedo[0] = 1.0
    @albedo[1] = 1.0
    @albedo[2] = 1.0
    @albedo[3] = 1.0
    @metallic = 0
    @roughness = 0
    @ao = 1.0
    @normal = 1
    @emissive[0] = 0
    @emissive[1] = 0
    @emissive[2] = 0
    @emissive[3] = 0

    @texTiling[0] = 1.0
    @texTiling[1] = 1.0
    @texOffset[0] = 0.0
    @texOffset[1] = 0.0
    @emissivePower = 1.0

    # Set up PBR shader material locations
    @albedoLoc = GetShaderLocation(@pbrShader, "albedoColor")
    @normalLoc = GetShaderLocation(@pbrShader, "normalValue")
    @metallicLoc = GetShaderLocation(@pbrShader, "metallicValue")
    @roughnessLoc = GetShaderLocation(@pbrShader, "roughnessValue")
    @aoLoc = GetShaderLocation(@pbrShader, "aoValue")
    @emissiveColorLoc = GetShaderLocation(@pbrShader, "emissiveColor")
    @emissivePowerLoc = GetShaderLocation(@pbrShader, "emissivePower")

    @texTilingLoc = GetShaderLocation(@pbrShader, "tiling")
    @texOffsetLoc = GetShaderLocation(@pbrShader, "offset")

    @useTexAlbedoLoc = GetShaderLocation(@pbrShader, "useTexAlbedo")
    @useTexNormalLoc = GetShaderLocation(@pbrShader, "useTexNormal")
    @useTexMRALoc = GetShaderLocation(@pbrShader, "useTexMRA")
    @useTexEmissiveLoc = GetShaderLocation(@pbrShader, "useTexEmissive")

    albedo = @albedo.pack('f4')
    SetShaderValue(@pbrShader, @albedoLoc, albedo, SHADER_UNIFORM_VEC4)

    emissive = @emissive.pack('f4')
    SetShaderValue(@pbrShader, @emissiveColorLoc, emissive, SHADER_UNIFORM_VEC4)

    @emissivePower_buf.write(:float, @emissivePower)
    SetShaderValue(@pbrShader, @emissivePowerLoc, @emissivePower_buf, SHADER_UNIFORM_FLOAT)
    @metallic_buf.write(:float, @metallic)
    SetShaderValue(@pbrShader, @metallicLoc, @metallic_buf, SHADER_UNIFORM_FLOAT)
    @roughness_buf.write(:float, @roughness)
    SetShaderValue(@pbrShader, @roughnessLoc, @roughness_buf, SHADER_UNIFORM_FLOAT)
    @ao_buf.write(:float, @ao)
    SetShaderValue(@pbrShader, @aoLoc, @ao_buf, SHADER_UNIFORM_FLOAT)
    @normal_buf.write(:float, @normal)
    SetShaderValue(@pbrShader, @normalLoc, @normal_buf, SHADER_UNIFORM_FLOAT)

    texTiling = @texTiling.pack('f2')
    SetShaderValue(@pbrShader, @texTilingLoc, texTiling, SHADER_UNIFORM_VEC2)
    texOffset = @texOffset.pack('f2')
    SetShaderValue(@pbrShader, @texOffsetLoc, texOffset, SHADER_UNIFORM_VEC2)
  end

  def load_texture(pbrTexType, filename)
    case pbrTexType
    when PBR_TEXTURE_ALBEDO
      @texAlbedo = LoadTexture(filename)
      @useTexAlbedo = 1
    when PBR_TEXTURE_MRA
      @texMRA = LoadTexture(filename)
      @useTexMRA = 1
    when PBR_TEXTURE_NORMAL
      @texNormal = LoadTexture(filename)
      @useTexNormal = 1
    when PBR_TEXTURE_EMISSIVE
      @texEmissive = LoadTexture(filename)
      @useTexEmissive = 1
    end
  end

  def unload_texture
    UnloadTexture(@texAlbedo) if @useTexAlbedo == 1
    UnloadTexture(@texMRA) if @useTexMRA == 1
    UnloadTexture(@texNormal) if @useTexNormal == 1
    UnloadTexture(@texEmissive) if @useTexEmissive == 1
  end

  def set_use_flag(pbrTexType, use = nil)
    case pbrTexType
    when PBR_TEXTURE_ALBEDO
      @useTexAlbedo = use if use != nil
      @useTexAlbedo_buf.write(:int, @useTexAlbedo)
      SetShaderValue(@pbrShader, @useTexAlbedoLoc, @useTexAlbedo_buf, SHADER_UNIFORM_INT)
    when PBR_TEXTURE_MRA
      @useTexMRA = use if use != nil
      @useTexMRA_buf.write(:int, @useTexMRA)
      SetShaderValue(@pbrShader, @useTexMRALoc, @useTexMRA_buf, SHADER_UNIFORM_INT)
    when PBR_TEXTURE_NORMAL
      @useTexNormal = use if use != nil
      @useTexNormal_buf.write(:int, @useTexNormal)
      SetShaderValue(@pbrShader, @useTexNormalLoc, @useTexNormal_buf, SHADER_UNIFORM_INT)
    when PBR_TEXTURE_EMISSIVE
      @useTexEmissive = use if use != nil
      @useTexEmissive_buf.write(:int, @useTexEmissive)
      SetShaderValue(@pbrShader, @useTexEmissiveLoc, @useTexEmissive_buf, SHADER_UNIFORM_INT)
    end
  end

  def set_color(pbrColorType, color = nil)
    case pbrColorType
    when PBR_COLOR_ALBEDO
      if color != nil
        @albedo[0] = color.r / 255.0
        @albedo[1] = color.g / 255.0
        @albedo[2] = color.b / 255.0
        @albedo[3] = color.a / 255.0
      end
      albedo = @albedo.pack('f4')
      SetShaderValue(@pbrShader, @albedoLoc, albedo, SHADER_UNIFORM_VEC4)
    when PBR_COLOR_EMISSIVE
      if color != nil
        @emissive[0] = color.r / 255.0
        @emissive[1] = color.g / 255.0
        @emissive[2] = color.b / 255.0
        @emissive[3] = color.a / 255.0
      end
      emissive = @emissive.pack('f4')
      SetShaderValue(@pbrShader, @emissiveColorLoc, emissive, SHADER_UNIFORM_VEC4)
    end
  end

  def set_float(pbrParamType, value = nil)
    case pbrParamType
    when PBR_PARAM_METALLIC
      if value != nil
        @metallic = value
        @metallic_buf.write(:float, @metallic)
      end
      SetShaderValue(@pbrShader, @metallicLoc, @metallic_buf, SHADER_UNIFORM_FLOAT)
    when PBR_PARAM_ROUGHNESS
      if value != nil
        @roughness = value
        @roughness_buf.write(:float, @roughness)
      end
      SetShaderValue(@pbrShader, @roughnessLoc, @roughness_buf, SHADER_UNIFORM_FLOAT)
    when PBR_PARAM_NORMAL
      if value != nil
        @normal = value
        @normal_buf.write(:float, @normal)
      end
      SetShaderValue(@pbrShader, @normalLoc, @normal_buf, SHADER_UNIFORM_FLOAT)
    when PBR_PARAM_AO
      if value != nil
        @ao = value
        @ao_buf.write(:float, @ao)
      end
      SetShaderValue(@pbrShader, @aoLoc, @ao_buf, SHADER_UNIFORM_FLOAT)
    when PBR_PARAM_EMISSIVE
      if value != nil
        @emissivePower = value
        @emissivePower_buf.write(:float, @emissivePower)
      end
      SetShaderValue(@pbrShader, @emissivePowerLoc, @emissivePower_buf, SHADER_UNIFORM_FLOAT)
    end
  end

  def set_vec2(type, value = nil)
    case type
    when PBR_VEC2_TILING
      if value != nil
        @texTiling[0] = value.x
        @texTiling[1] = value.y
      end
      texTiling = @texTiling.pack('f2')
      SetShaderValue(@pbrShader, @texTilingLoc, texTiling, SHADER_UNIFORM_VEC2)
    when PBR_VEC2_OFFSET
      if value != nil
        @texOffset[0] = value.x
        @texOffset[1] = value.y
      end
      texOffset = @texOffset.pack('f2')
      SetShaderValue(@pbrShader, @texOffsetLoc, texOffset, SHADER_UNIFORM_VEC2)
    end
  end
end

class PBRModel
  attr_accessor :model, :pbr_material
  def initialize
    @model = nil
    @pbr_material = nil
  end

  def set_material(pbrMat, matIndex)
    @pbr_material = pbrMat
    model_material = Material.new(@model[:materials] + matIndex * Material.size)
    model_material.shader = @pbr_material.pbrShader

    location_map_albedo_ptr = @pbr_material.pbrShader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_MAP_ALBEDO)
    location_map_albedo_ptr.write_int32(GetShaderLocation(@pbr_material.pbrShader, "albedoMap"))
    location_map_mra_ptr = @pbr_material.pbrShader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_MAP_MRA)
    location_map_mra_ptr.write_int32(GetShaderLocation(@pbr_material.pbrShader, "mraMap"))
    location_map_emissive_ptr = @pbr_material.pbrShader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_MAP_EMISSION)
    location_map_emissive_ptr.write_int32(GetShaderLocation(@pbr_material.pbrShader, "emissiveMap"))
    location_map_normal_ptr = @pbr_material.pbrShader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_MAP_NORMAL)
    location_map_normal_ptr.write_int32(GetShaderLocation(@pbr_material.pbrShader, "normalMap"))

    if @pbr_material.useTexAlbedo == 1
      material_map = MaterialMap.new(model_material.maps + MATERIAL_MAP_ALBEDO * MaterialMap.size)
      material_map.texture = @pbr_material.texAlbedo
    end
    if @pbr_material.useTexMRA == 1
      material_map = MaterialMap.new(model_material.maps + MATERIAL_MAP_MRA * MaterialMap.size)
      material_map.texture = @pbr_material.texMRA
    end
    if @pbr_material.useTexNormal == 1
      material_map = MaterialMap.new(model_material.maps + MATERIAL_MAP_NORMAL * MaterialMap.size)
      material_map.texture = @pbr_material.texNormal
    end
    if @pbr_material.useTexEmissive == 1
      material_map = MaterialMap.new(model_material.maps + MATERIAL_MAP_EMISSION * MaterialMap.size)
      material_map.texture = @pbr_material.texEmissive
    end

    @pbr_material.useTexAlbedo_buf.write(:int, @pbr_material.useTexAlbedo)
    SetShaderValue(model_material.shader, @pbr_material.useTexAlbedoLoc, @pbr_material.useTexAlbedo_buf, SHADER_UNIFORM_FLOAT)
    @pbr_material.useTexNormal_buf.write(:int, @pbr_material.useTexNormal)
    SetShaderValue(model_material.shader, @pbr_material.useTexNormalLoc, @pbr_material.useTexNormal_buf, SHADER_UNIFORM_FLOAT)
    @pbr_material.useTexMRA_buf.write(:int, @pbr_material.useTexMRA)
    SetShaderValue(model_material.shader, @pbr_material.useTexMRALoc, @pbr_material.useTexMRA_buf, SHADER_UNIFORM_FLOAT)
    @pbr_material.useTexEmissive_buf.write(:int, @pbr_material.useTexEmissive)
    SetShaderValue(model_material.shader, @pbr_material.useTexEmissiveLoc, @pbr_material.useTexEmissive_buf, SHADER_UNIFORM_FLOAT)
  end

  def draw(position, scale)
    @pbr_material.set_color(PBR_COLOR_ALBEDO)
    @pbr_material.set_color(PBR_COLOR_EMISSIVE)
    @pbr_material.set_float(PBR_PARAM_METALLIC)
    @pbr_material.set_float(PBR_PARAM_ROUGHNESS)
    @pbr_material.set_float(PBR_PARAM_AO)
    @pbr_material.set_float(PBR_PARAM_NORMAL)
    @pbr_material.set_vec2(PBR_VEC2_TILING)
    @pbr_material.set_vec2(PBR_VEC2_OFFSET)

    @pbr_material.set_use_flag(PBR_TEXTURE_ALBEDO)
    @pbr_material.set_use_flag(PBR_TEXTURE_NORMAL)
    @pbr_material.set_use_flag(PBR_TEXTURE_MRA)
    @pbr_material.set_use_flag(PBR_TEXTURE_EMISSIVE)

    DrawModel(@model, position, scale, WHITE)
  end

  def load(filename)
    @model = LoadModel(filename)
    return @model
  end

  def load_from_mesh(mesh)
    @model = LoadModelFromMesh(mesh)
    return @model
  end

  def unload
    UnloadModel(@model)
    @model = nil
  end

end

if __FILE__ == $PROGRAM_NAME

  GLSL_VERSION = 330

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - basic pbr")

  camera = Camera.new
             .with_position(2.0, 2.0, 6.0)
             .with_target(0.0, 0.5, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  # Load plane model from a generated mesh

  shader = LoadShader(RAYLIB_SHADERS_PATH + "shaders/glsl#{GLSL_VERSION}/pbr.vs",
                      RAYLIB_SHADERS_PATH + "shaders/glsl#{GLSL_VERSION}/pbr.fs")

  model_car = PBRModel.new
  model_car.load(RAYLIB_SHADERS_PATH + "models/old_car_new.glb")

  pbr_mat_car = PBRMaterial.new
  pbr_mat_car.setup(shader)
  pbr_mat_car.load_texture(PBR_TEXTURE_ALBEDO, RAYLIB_SHADERS_PATH + "old_car_d.png")
  pbr_mat_car.load_texture(PBR_TEXTURE_MRA, RAYLIB_SHADERS_PATH + "old_car_mra.png")
  pbr_mat_car.load_texture(PBR_TEXTURE_NORMAL, RAYLIB_SHADERS_PATH + "old_car_n.png")
  pbr_mat_car.load_texture(PBR_TEXTURE_EMISSIVE, RAYLIB_SHADERS_PATH + "old_car_e.png")
  pbr_mat_car.set_color(PBR_COLOR_EMISSIVE, Color.from_u8(255, 162, 0, 255))
  pbr_mat_car.set_vec2(PBR_VEC2_TILING, Vector2.create(0.5, 0.5))
  model_car.set_material(pbr_mat_car, 0)

  model_floor = PBRModel.new
  model_floor.load(RAYLIB_SHADERS_PATH + "models/plane.glb")

  pbr_mat_floor = PBRMaterial.new
  pbr_mat_floor.setup(shader)
  pbr_mat_floor.load_texture(PBR_TEXTURE_ALBEDO, RAYLIB_SHADERS_PATH + "road_a.png")
  pbr_mat_floor.load_texture(PBR_TEXTURE_MRA, RAYLIB_SHADERS_PATH + "road_mra.png")
  pbr_mat_floor.load_texture(PBR_TEXTURE_NORMAL, RAYLIB_SHADERS_PATH + "road_n.png")
  pbr_mat_floor.set_vec2(PBR_VEC2_TILING, Vector2.create(0.5, 0.5))
  model_floor.set_material(pbr_mat_floor, 0)

  # Get some required shader loactions
  location_vector_view_ptr = shader.locs + (FFI::NativeType::INT32.size * SHADER_LOC_VECTOR_VIEW)
  viewPosLoc = GetShaderLocation(shader, "viewPos")
  location_vector_view_ptr.write_int32(viewPosLoc)

  numOfLightsLoc = GetShaderLocation(shader, "numOfLights")
  numOfLights = 4
  numOfLights_buf = FFI::MemoryPointer.new(:int, 1)
  numOfLights_buf.write_int32(numOfLights)
  SetShaderValue(shader, numOfLightsLoc, numOfLights_buf, SHADER_UNIFORM_INT)

  ambCol = Color.from_u8(26, 32, 135, 255)
  ambIntens = 0.02

  albedoLoc = GetShaderLocation(shader, "albedo")
  PBRLight.set_ambient(shader, ambCol, ambIntens)

  lights = [
    PBRLight.new(0, LIGHT_POINT, Vector3.create( -1, 1, -2), Vector3Zero(), YELLOW, 4.0, shader),
    PBRLight.new(1, LIGHT_POINT, Vector3.create( 2, 1, 1), Vector3Zero(), GREEN, 3.3, shader),
    PBRLight.new(2, LIGHT_POINT, Vector3.create( -2, 1, 1), Vector3Zero(), RED, 8.3, shader),
    PBRLight.new(3, LIGHT_POINT, Vector3.create( 1, 1, -2), Vector3Zero(), BLUE, 2.0, shader),
  ]
  lights.each do |light|
    light.update(shader)
  end

  SetTargetFPS(60)

  emissiveCnt = 0

  until WindowShouldClose()

    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    cameraPos = [camera.position.x, camera.position.y, camera.position.z].pack('f3')
    SetShaderValue(shader, location_vector_view_ptr.read_int32, cameraPos, SHADER_UNIFORM_VEC3)

    # Check key inputs to enable/disable lights
    lights[0].enabled = !lights[0].enabled if IsKeyPressed(KEY_Y)
    lights[1].enabled = !lights[1].enabled if IsKeyPressed(KEY_G)
    lights[2].enabled = !lights[2].enabled if IsKeyPressed(KEY_R)
    lights[3].enabled = !lights[3].enabled if IsKeyPressed(KEY_B)
    lights.each do |light|
      light.update(shader)
    end

    emissiveCnt -= 1
    if emissiveCnt <= 0
      emissiveCnt = GetRandomValue(0, 20)
      pbr_mat_car.set_float(PBR_PARAM_EMISSIVE, GetRandomValue(0,100).to_f / 100)
    end

    BeginDrawing()
      ClearBackground(BLACK)
      BeginMode3D(camera)
        model_floor.draw(Vector3Zero(), 5.0)
        model_car.draw(Vector3Zero(), 0.25)

        lights.each do |light|
          col = Color.from_u8(light.color[0] * 255, light.color[1] * 255, light.color[2] * 255, light.color[3] * 255)
          if light.enabled
            DrawSphereEx(light.position, 0.2, 8, 8, col)
          else
            DrawSphereWires(light.position, 0.2, 8, 8, ColorAlpha(col, 0.3))
          end
        end
      EndMode3D()
      DrawFPS(10, 10)
      DrawText("Use keys [Y][R][G][B] to toggle lights", 10, 40, 20, DARKGRAY)
    EndDrawing()
  end

  model_floor.unload
  model_car.unload
  pbr_mat_floor.unload_texture
  pbr_mat_car.unload_texture
  UnloadShader(shader)
  CloseWindow()
end
