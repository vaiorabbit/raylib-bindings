# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

module Raylib
  #
  # Color helper
  #

  def Color.from_u8(r = 0, g = 0, b = 0, a = 255)
    instance = Color.new
    instance[:r] = r
    instance[:g] = g
    instance[:b] = b
    instance[:a] = a
    instance
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

  def Vector2.create(x = 0, y = 0)
    instance = Vector2.new
    instance[:x] = x
    instance[:y] = y
    instance
  end

  def Vector2.copy_from(vec)
    Vector2.create(vec[:x], vec[:y])
  end

  def Vector3.create(x = 0, y = 0, z = 0)
    instance = Vector3.new
    instance[:x] = x
    instance[:y] = y
    instance[:z] = z
    instance
  end

  def Vector3.copy_from(vec)
    Vector3.create(vec[:x], vec[:y], vec[:z])
  end

  def Vector4.create(x = 0, y = 0, z = 0, w = 0)
    instance = Vector4.new
    instance[:x] = x
    instance[:y] = y
    instance[:z] = z
    instance[:w] = w
    instance
  end

  def Vector4.copy_from(vec)
    Vector4.create(vec[:x], vec[:y], vec[:z], vec[:w])
  end

  def Quaternion.create(x = 0, y = 0, z = 0, w = 0)
    instance = Quaternion.new
    instance[:x] = x
    instance[:y] = y
    instance[:z] = z
    instance[:w] = w
    instance
  end

  def Quaternion.copy_from(quat)
    Quaternion.create(quat[:x], quat[:y], quat[:z], quat[:w])
  end

  def Rectangle.create(x = 0, y = 0, width = 0, height = 0)
    instance = Rectangle.new
    instance[:x] = x
    instance[:y] = y
    instance[:width] = width
    instance[:height] = height
    instance
  end

  def BoundingBox.create(*args)
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

  def Vector3ToFloat(vec)
    Vector3ToFloatV(vec)[:v].to_a
  end

  def MatrixToFloat(mat)
    MatrixToFloatV(mat)[:v].to_a
  end
end
