# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

module Raylib
  #
  # Color helper
  #

  class Color
    def self.from_u8(r = 0, g = 0, b = 0, a = 255)
      Color.new.set(r, g, b, a)
    end

    def self.from_u32(rgba = 255)
      r = (rgba >> 24) & 0xFF
      g = (rgba >> 16) & 0xFF
      b = (rgba >>  8) & 0xFF
      a = (rgba >>  0) & 0xFF
      Color.new.set(r, g, b, a)
    end

    def set(r, g, b, a)
      self[:r] = r
      self[:g] = g
      self[:b] = b
      self[:a] = a
      self
    end

    def self.set(rgba)
      self[:r] = (rgba >> 24) & 0xFF
      self[:g] = (rgba >> 16) & 0xFF
      self[:b] = (rgba >>  8) & 0xFF
      self[:a] = (rgba >>  0) & 0xFF
      self
    end

    def copy(other)
      self[:r] = other.r
      self[:g] = other.g
      self[:b] = other.b
      self[:a] = other.a
      self
    end
  end

  LIGHTGRAY  = Color.from_u8(200, 200, 200, 255)
  GRAY       = Color.from_u8(130, 130, 130, 255)
  DARKGRAY   = Color.from_u8(80, 80, 80, 255)
  YELLOW     = Color.from_u8(253, 249, 0, 255)
  GOLD       = Color.from_u8(255, 203, 0, 255)
  ORANGE     = Color.from_u8(255, 161, 0, 255)
  PINK       = Color.from_u8(255, 109, 194, 255)
  RED        = Color.from_u8(230, 41, 55, 255)
  MAROON     = Color.from_u8(190, 33, 55, 255)
  GREEN      = Color.from_u8(0, 228, 48, 255)
  LIME       = Color.from_u8(0, 158, 47, 255)
  DARKGREEN  = Color.from_u8(0, 117, 44, 255)
  SKYBLUE    = Color.from_u8(102, 191, 255, 255)
  BLUE       = Color.from_u8(0, 121, 241, 255)
  DARKBLUE   = Color.from_u8(0, 82, 172, 255)
  PURPLE     = Color.from_u8(200, 122, 255, 255)
  VIOLET     = Color.from_u8(135, 60, 190, 255)
  DARKPURPLE = Color.from_u8(112, 31, 126, 255)
  BEIGE      = Color.from_u8(211, 176, 131, 255)
  BROWN      = Color.from_u8(127, 106, 79, 255)
  DARKBROWN  = Color.from_u8(76, 63, 47, 255)

  WHITE      = Color.from_u8(255, 255, 255, 255)
  BLACK      = Color.from_u8(0, 0, 0, 255)
  BLANK      = Color.from_u8(0, 0, 0, 0)
  MAGENTA    = Color.from_u8(255, 0, 255, 255)
  RAYWHITE   = Color.from_u8(245, 245, 245, 255)

  #
  # Math helper
  #

  DEG2RAD = Math::PI / 180.0
  RAD2DEG = 180.0 / Math::PI

  class Vector2
    def self.create(x = 0, y = 0)
      Vector2.new.set(x, y)
    end

    def self.copy_from(vec)
      Vector2.create(vec[:x], vec[:y])
    end

    def set(x, y)
      self[:x] = x
      self[:y] = y
      self
    end

    def add(x, y)
      self[:x] = self[:x] + x
      self[:y] = self[:y] + y
      self
    end

    def add_vector(v)
      self[:x] = self[:x] + v[:x]
      self[:y] = self[:y] + v[:y]
      self
    end

    def to_a
      [x, y]
    end
  end

  class Vector3
    def self.create(x = 0, y = 0, z = 0)
      Vector3.new.set(x, y, z)
    end

    def self.copy_from(vec)
      Vector3.create(vec[:x], vec[:y], vec[:z])
    end

    def set(x, y, z)
      self[:x] = x
      self[:y] = y
      self[:z] = z
      self
    end

    def to_a
      [x, y, z]
    end
  end

  class Vector4
    def self.create(x = 0, y = 0, z = 0, w = 0)
      Vector4.new.set(x, y, z, w)
    end

    def self.copy_from(vec)
      Vector4.create(vec[:x], vec[:y], vec[:z], vec[:w])
    end

    def set(x, y, z, w)
      self[:x] = x
      self[:y] = y
      self[:z] = z
      self[:w] = w
      self
    end

    def to_a
      [x, y, z, w]
    end
  end

  class Quaternion
    def self.create(x = 0, y = 0, z = 0, w = 0)
      Quaternion.new.set(x, y, z, w)
    end

    def self.copy_from(quat)
      Quaternion.create(quat[:x], quat[:y], quat[:z], quat[:w])
    end

    def set(x, y, z, w)
      self[:x] = x
      self[:y] = y
      self[:z] = z
      self[:w] = w
      self
    end

    def to_a
      [x, y, z, w]
    end
  end

  class Rectangle
    def self.create(x = 0, y = 0, width = 0, height = 0)
      Rectangle.new.set(x, y, width, height)
    end

    def set(x, y, width, height)
      self[:x] = x
      self[:y] = y
      self[:width] = width
      self[:height] = height
      self
    end
  end

  class BoundingBox
    def self.create(*args)
      case args.size
      when 2
        instance = BoundingBox.new
        instance[:min] = args[0] # min
        instance[:max] = args[1] # max
        instance
      when 6
        instance = BoundingBox.new
        instance[:min] = Vector3.create(args[0], args[1], args[2]) # min_x, min_y, min_z
        instance[:max] = Vector3.create(args[3], args[4], args[5]) # max_x, max_y, max_z
        instance
      else
        raise ArgumentError.new 'BoundingBox.create : Number of arguments must be 2 or 6'
      end
    end

    def with_min(x, y, z)
      self[:min].set(x, y, z)
      self
    end

    def with_max(x, y, z)
      self[:max].set(x, y, z)
      self
    end
  end

  def Vector3ToFloat(vec)
    Vector3ToFloatV(vec)[:v].to_a
  end

  def MatrixToFloat(mat)
    MatrixToFloatV(mat)[:v].to_a
  end

  #
  # Camera helper
  #

  class Camera3D
    def with_position(x, y, z)
      self[:position].set(x, y, z)
      self
    end

    def with_target(x, y, z)
      self[:target].set(x, y, z)
      self
    end

    def with_up(x, y, z)
      self[:up].set(x, y, z)
      self
    end

    def with_fovy(fovy)
      self[:fovy] = fovy
      self
    end

    def with_projection(projection)
      self[:projection] = projection
      self
    end
  end

  class Camera2D
    def with_offset(x, y)
      self[:offset].set(x, y)
      self
    end

    def with_target(x, y)
      self[:target].set(x, y)
      self
    end

    def with_rotation(rotation)
      self[:rotation] = rotation
      self
    end

    def with_zoom(zoom)
      self[:zoom] = zoom
      self
    end
  end

  #
  # Transform helper
  #

  class Transform
    def t = self[:translation]
    def r = self[:rotation]
    def s = self[:scale]
  end

  #
  # Model helper
  #

  # DrawModelEx : Draw a model with extended parameters
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

  class Model
    # GetModelMaterial (ruby raylib original)
    # @param index [int] 0 ~ materialCount
    # @return [Material]
    def material(index = 0)
      Material.new(self[:materials] + index * Material.size)
    end

    # GetModelMaterialCount (ruby raylib original)
    # @return [int]
    def material_count
      self[:materialCount]
    end

    # GetModelBoneCount (ruby raylib original)
    # @return [int]
    def bone_count
      self[:boneCount]
    end

    # @return BoneInfo
    def bone_info(index)
      BoneInfo.new(self[:bones] + index * BoneInfo.size)
    end

    # @return Transform
    def bind_pose_transform(index)
      Transform.new(self[:bindPose] + index * Transform.size)
    end
  end

  class BoneInfo
    def parent_bone_index
      self[:parent]
    end
  end

  #
  # ModelAnimation helper
  #

  # Manages a set of ModelAnimation (ruby raylib original)
  class ModelAnimations
    attr_reader :anims, :anim_ptrs

    def initialize
      @anims = nil
      @anim_ptrs = nil
      @framePoses = nil # array of Transform**
    end

    def anim(index) = @anims[index]
    def anims_count = @anims.length
    def frame_count(index) = @anims[index][:frameCount]

    # @return BoneInfo
    def bone_info(anim_index, bone_index)
      BoneInfo.new(@anims[anim_index][:bones] + bone_index * BoneInfo.size)
    end

    # @return Transform*
    def frame_pose(index, frame)
      @framePoses[index] + frame * FFI::NativeType::POINTER.size # Transform*
    end

    # @return Transform
    def bone_transform(frame_pose, bone_index)
      Transform.new(frame_pose.read_pointer + bone_index * Transform.size)
    end

    # @return Transform
    def bone_transform_of_frame_pose(anim_index, frame, bone_index)
      bone_transform(frame_pose(anim_index, frame), bone_index)
    end

    # @return self
    def setup(fileName)
      @anims, @anim_ptrs = LoadAndAllocateModelAnimations(fileName)
      @framePoses = []
      @anims.each do |anim|
        @framePoses << anim[:framePoses]
      end
      self
    end

    def cleanup
      UnloadAndFreeModelAnimations(@anims, @anim_ptrs)
    end
  end

  # LoadAndAllocateModelAnimations : (ruby raylib original)
  # @param fileName [const char *]
  # @return array of ModelAnimation and pointer to loaded memory
  def LoadAndAllocateModelAnimations(fileName)
    animsCount_buf = FFI::MemoryPointer.new(:uint, 1)
    anim_ptrs = LoadModelAnimations(fileName, animsCount_buf)
    animsCount = animsCount_buf.read_uint
    anims = animsCount.times.map do |i|
      ModelAnimation.new(anim_ptrs + i * ModelAnimation.size)
    end
    return anims, anim_ptrs
  end

  # UnloadAndFreeModelAnimations : (ruby raylib original)
  # @param anims [array of ModelAnimation]
  # @param anim_ptrs [pointer to loaded memory]
  def UnloadAndFreeModelAnimations(anims, anim_ptrs)
    anims.each do |anim|
      UnloadModelAnimation(anim)
    end
    MemFree(anim_ptrs)
  end

end
