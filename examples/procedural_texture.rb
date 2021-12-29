# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

####################################################################################################

BlockEdgeW = 3
BlockEdgeH = 3
BlockInnerW = 20
BlockInnerH = 20
BlockOuterW = BlockInnerW + 2 * BlockEdgeW
BlockOuterH = BlockInnerH + 2 * BlockEdgeH

def GenBlockTexture()
  block_image = GenImageColor(BlockInnerW + 2 * BlockEdgeW, BlockInnerH + 2 * BlockEdgeH, BLACK)
  ImageFormat(block_image, PIXELFORMAT_UNCOMPRESSED_R8G8B8A8)

  BlockOuterH.times do |h|
    BlockOuterW.times do |w|
      step = 256 / BlockOuterW
      color = (0xff - step * w / 1) / 2 + (0xff - step * h / 1) / 2
      pixel_color = Color.from_u8((color * 0.85).to_i,
                                  (color * 0.85).to_i,
                                  (color * 0.85).to_i,
                                  0xff)
      ImageDrawPixel(block_image, w, h, pixel_color)
    end
  end

  BlockInnerH.times do |h|
    BlockInnerW.times do |w|
      step = 256 / BlockInnerW
      color = (0xff - step * w / 3) / 2 + (0xff - step * h / 3) / 2
      pixel_color = Color.from_u8((color * 1.0).to_i,
                                  (color * 1.0).to_i,
                                  (color * 1.0).to_i,
                                  0xff)
      ImageDrawPixel(block_image, w + BlockEdgeW, h + BlockEdgeH, pixel_color)
    end
  end

  block_texture = LoadTextureFromImage(block_image)

  UnloadImage(block_image)

  return block_texture
end

$block_texture = nil

####################################################################################################

# TypeID_I = 0
# TypeID_J = 1
# TypeID_L = 2
# TypeID_O = 3
# TypeID_S = 4
# TypeID_Z = 5
# TypeID_T = 6
TypeID_Max = 7

Rotation_Max = 4

colors = [
  Color.from_u8( 0x00, 0xFF, 0xFF, 0xFF ),  # TypeID_I : Cyan
  Color.from_u8( 0x00, 0x00, 0xFF, 0xFF ),  # TypeID_J : Blue
  Color.from_u8( 0xFF, 0xA5, 0x00, 0xFF ),  # TypeID_L : Orange
  Color.from_u8( 0xFF, 0xFF, 0x00, 0xFF ),  # TypeID_O : Yellow
  Color.from_u8( 0x00, 0xFF, 0x00, 0xFF ),  # TypeID_S : Green
  Color.from_u8( 0xFF, 0x00, 0x00, 0xFF ),  # TypeID_Z : Red
  Color.from_u8( 0x80, 0x00, 0x80, 0xFF ),  # TypeID_T : Purple
]

patterns = [
  [   # TypeID_I
    [[' ',' ',' ',' '],
     ['*','*','*','*'],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     [' ','*',' ',' '],
     [' ','*',' ',' '],
     [' ','*',' ',' ']],
    [[' ',' ',' ',' '],
     [' ',' ',' ',' '],
     ['*','*','*','*'],
     [' ',' ',' ',' ']],
    [[' ',' ','*',' '],
     [' ',' ','*',' '],
     [' ',' ','*',' '],
     [' ',' ','*',' ']],
  ],

  [   # TypeID_J
    [[' ',' ',' ',' '],
     ['*','*','*',' '],
     [' ',' ','*',' '],
     [' ',' ',' ',' ']],
    [[' ','*','*',' '],
     [' ','*',' ',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
    [['*',' ',' ',' '],
     ['*','*','*',' '],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     [' ','*',' ',' '],
     ['*','*',' ',' '],
     [' ',' ',' ',' ']],
  ],

  [   # TypeID_L
    [[' ',' ',' ',' '],
     ['*','*','*',' '],
     ['*',' ',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     [' ','*',' ',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
    [[' ',' ','*',' '],
     ['*','*','*',' '],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [['*','*',' ',' '],
     [' ','*',' ',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
  ],

  [   # TypeID_O
    [[' ',' ',' ',' '],
     [' ','*','*',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
    [[' ',' ',' ',' '],
     [' ','*','*',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
    [[' ',' ',' ',' '],
     [' ','*','*',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
    [[' ',' ',' ',' '],
     [' ','*','*',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
  ],

  [   # TypeID_S
    [[' ',' ',' ',' '],
     [' ','*','*',' '],
     ['*','*',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     [' ','*','*',' '],
     [' ',' ','*',' '],
     [' ',' ',' ',' ']],
    [[' ','*','*',' '],
     ['*','*',' ',' '],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [['*',' ',' ',' '],
     ['*','*',' ',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
  ],

  [   # TypeID_Z
    [[' ',' ',' ',' '],
     ['*','*',' ',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' ']],
    [[' ',' ','*',' '],
     [' ','*','*',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
    [['*','*',' ',' '],
     [' ','*','*',' '],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     ['*','*',' ',' '],
     ['*',' ',' ',' '],
     [' ',' ',' ',' ']],
  ],

  [   # TypeID_T
    [[' ',' ',' ',' '],
     ['*','*','*',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     [' ','*','*',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     ['*','*','*',' '],
     [' ',' ',' ',' '],
     [' ',' ',' ',' ']],
    [[' ','*',' ',' '],
     ['*','*',' ',' '],
     [' ','*',' ',' '],
     [' ',' ',' ',' ']],
  ],
]

####################################################################################################

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 180

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - Procedural Texture")

  $block_texture = GenBlockTexture()

  SetTargetFPS(60)

  StepX = $block_texture[:width]
  StepY = $block_texture[:height]
  BlockStepX = StepX * 4.2
  base_origin = Vector2.create(StepX * 1, 0)
  pattern_origin = Vector2.create(0.0, StepY * 1.5)

  rotation = 0
  time = 0.0

  until WindowShouldClose()

    dt = GetFrameTime()
    if time > 1.0
      rotation = (rotation + 1) % Rotation_Max
      time = 0.0
    else
      time += dt
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginBlendMode(BLEND_ALPHA)
        TypeID_Max.times do |type|
          pattern_origin[:x] = BlockStepX * type
          pattern = patterns[type][rotation]
          pattern.each_with_index do |row, r|
            row.each_with_index do |block, c|
              x = base_origin[:x] + pattern_origin[:x] + StepX * c
              y = base_origin[:y] + pattern_origin[:y] + StepY * r
              DrawRectangleLines(x, y, StepX - 1, StepY - 1, LIGHTGRAY)
              next if block != '*'
              DrawTexture($block_texture, x, y, colors[type])
            end
          end
        end
      EndBlendMode()
      DrawText("[Texture is generated procedurally]", 410, 150, 20.0, GRAY)
    EndDrawing()
  end

  UnloadRenderTexture($block_texture)
  CloseWindow()

end
