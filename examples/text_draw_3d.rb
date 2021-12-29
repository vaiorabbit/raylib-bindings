# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

LETTER_BOUNDRY_SIZE    = 0.25
TEXT_MAX_LAYERS        = 32
LETTER_BOUNDRY_COLOR   = VIOLET

$show_letter_boundry = false
$show_text_boundry = false

# Configuration structure for waving the text
class WaveTextConfig
  attr_accessor :waveRange, :waveSpeed, :waveOffset
  def initialize
    @waveRange = Vector3.new
    @waveSpeed = Vector3.new
    @waveOffset = Vector3.new
  end
end

# Draw a codepoint in 3D space
def DrawTextCodepoint3D(font, codepoint, position, fontSize, backface, tint)
  # Character index position in sprite font
  # NOTE: In case a codepoint is not available in the font, index returned points to '?'
  index = GetGlyphIndex(font, codepoint)
  scale = fontSize/font[:baseSize].to_f

  # Character destination rectangle on screen
  # NOTE: We consider charsPadding on drawing
  glyphInfo = GlyphInfo.new(font[:glyphs] + index * GlyphInfo.size)
  position[:x] += (glyphInfo[:offsetX] - font[:glyphPadding])/font[:baseSize]*scale;
  position[:z] += (glyphInfo[:offsetY] - font[:glyphPadding])/font[:baseSize]*scale;

  # Character source rectangle from font texture atlas
  # NOTE: We consider chars padding when drawing, it could be required for outline/glow shader effects
  font_rec = Rectangle.new(font[:recs] + index * Rectangle.size)
  srcRec = Rectangle.create(font_rec[:x] - font[:glyphPadding], font_rec[:y] - font[:glyphPadding].to_f,
                            font_rec[:width] + 2.0*font[:glyphPadding], font_rec[:height] + 2.0*font[:glyphPadding])

  width = (font_rec[:width] + 2.0*font[:glyphPadding]) / font[:baseSize]*scale
  height = (font_rec[:height] + 2.0*font[:glyphPadding]) / font[:baseSize]*scale

  if font[:texture][:id] > 0
    x = 0.0
    y = 0.0
    z = 0.0

    # normalized texture coordinates of the glyph inside the font texture (0.0f -> 1.0f)
    tx = srcRec[:x]/font[:texture][:width]
    ty = srcRec[:y]/font[:texture][:height]
    tw = (srcRec[:x]+srcRec[:width])/font[:texture][:width]
    th = (srcRec[:y]+srcRec[:height])/font[:texture][:height]

    if $show_letter_boundry
      DrawCubeWiresV(Vector3.create(position[:x] + width/2, position[:y], position[:z] + height/2), Vector3.create(width, LETTER_BOUNDRY_SIZE, height), LETTER_BOUNDRY_COLOR)
    end

    rlCheckRenderBatchLimit(4 + (backface ? 4 : 0))
    rlSetTexture(font[:texture][:id])

    rlPushMatrix()
      rlTranslatef(position[:x], position[:y], position[:z])
      rlBegin(RL_QUADS)
        rlColor4ub(tint[:r], tint[:g], tint[:b], tint[:a])
        # Front Face
        rlNormal3f(0.0, 1.0, 0.0)                                    # Normal Pointing Up
        rlTexCoord2f(tx, ty); rlVertex3f(x,         y, z)            # Top Left Of The Texture and Quad
        rlTexCoord2f(tx, th); rlVertex3f(x,         y, z + height)   # Bottom Left Of The Texture and Quad
        rlTexCoord2f(tw, th); rlVertex3f(x + width, y, z + height)   # Bottom Right Of The Texture and Quad
        rlTexCoord2f(tw, ty); rlVertex3f(x + width, y, z)            # Top Right Of The Texture and Quad

        if backface
          # Back Face
          rlNormal3f(0.0, -1.0, 0.0)                                 # Normal Pointing Down
          rlTexCoord2f(tx, ty); rlVertex3f(x,         y, z)          # Top Right Of The Texture and Quad
          rlTexCoord2f(tw, ty); rlVertex3f(x + width, y, z)          # Top Left Of The Texture and Quad
          rlTexCoord2f(tw, th); rlVertex3f(x + width, y, z + height) # Bottom Left Of The Texture and Quad
          rlTexCoord2f(tx, th); rlVertex3f(x,         y, z + height) # Bottom Right Of The Texture and Quad
        end
      rlEnd()
    rlPopMatrix()
    rlSetTexture(0)
  end
end

# Draw a 2D text in 3D space
def DrawText3D(font, text, position, fontSize, fontSpacing, lineSpacing, backface, tint)
  length = TextLength(text) # Total length in bytes of the text, scanned by codepoints in loop

  textOffsetY = 0.0 # Offset between lines (on line break '\n')
  textOffsetX = 0.0 # Offset X to next character to draw

  scale = fontSize/font[:baseSize].to_f

  text.each_codepoint do |codepoint|
    index = GetGlyphIndex(font, codepoint)

    if codepoint == "\n".ord
      # NOTE: Fixed line spacing of 1.5 line-height
      # TODO: Support custom line spacing defined by user
      textOffsetY += scale + lineSpacing/font[:baseSize]*scale
      textOffsetX = 0.0
    else
      if (codepoint != ' '.ord) && (codepoint != "\t".ord)
        DrawTextCodepoint3D(font, codepoint, Vector3.create(position[:x] + textOffsetX, position[:y], position[:z] + textOffsetY), fontSize, backface, tint)
      end

      glyphInfo = GlyphInfo.new(font[:glyphs] + index * GlyphInfo.size)
      if glyphInfo[:advanceX] == 0
        font_rec = Rectangle.new(font[:recs] + index * Rectangle.size)
        textOffsetX += (font_rec[:width] + fontSpacing)/font[:baseSize]*scale
      else
        textOffsetX += (glyphInfo[:advanceX] + fontSpacing)/font[:baseSize]*scale
      end
    end
  end
end

# Measure a text in 3D. For some reason `MeasureTextEx()` just doesn't seem to work so i had to use this instead.
def MeasureText3D(font, text, fontSize, fontSpacing, lineSpacing)
  tempLen = 0 # Used to count longer text line num chars
  lenCounter = 0

  tempTextWidth = 0.0 # Used to count longer text line width

  scale = fontSize/font[:baseSize]
  textHeight = scale
  textWidth = 0.0

  text.each_codepoint do |codepoint|
    lenCounter += 1
    index = GetGlyphIndex(font, codepoint)

    if codepoint != "\n".ord
      glyphInfo = GlyphInfo.new(font[:glyphs] + index * GlyphInfo.size)
      if glyphInfo[:advanceX] != 0
        textWidth += (glyphInfo[:advanceX]+fontSpacing)/font[:baseSize]*scale
      else
        font_rec = Rectangle.new(font[:recs] + index * Rectangle.size)
        textWidth += (font_rec[:width] + glyphInfo[:offsetX])/font[:baseSize]*scale
      end
    else
      tempTextWidth = textWidth if tempTextWidth < textWidth
      lenCounter = 0
      textWidth = 0.0
      textHeight += scale + lineSpacing/font[:baseSize]*scale
    end

    tempLen = lenCounter if tempLen < lenCounter
  end

  tempTextWidth = textWidth if tempTextWidth < textWidth

  vec = Vector3.new
  vec[:x] = tempTextWidth + ((tempLen - 1).to_f*fontSpacing/font[:baseSize]*scale) # Adds chars spacing to measure
  vec[:y] = 0.25
  vec[:z] = textHeight

  return vec;
end

# Draw a 2D text in 3D space and wave the parts that start with `~~` and end with `~~`.
# This is a modified version of the original code by @Nighten found here https://github.com/NightenDushi/Raylib_DrawTextStyle
def DrawTextWave3D(font, text, position, fontSize, fontSpacing, lineSpacing, backface, config, time, tint)
  textOffsetY = 0.0               # Offset between lines (on line break '\n')
  textOffsetX = 0.0               # Offset X to next character to draw

  scale = fontSize/font[:baseSize].to_f

  wave = false
  k = 0
  text.chars.each_with_index do |letter, i|
    codepoint = letter.ord
    index = GetGlyphIndex(font, codepoint)
    if codepoint == "\n".ord
      # NOTE: Fixed line spacing of 1.5 line-height
      # TODO: Support custom line spacing defined by user
      textOffsetY += scale + lineSpacing/font[:baseSize]*scale
      textOffsetX = 0.0
      k = 0
    elsif codepoint == '~'.ord
      wave = !wave if text[i + 1] == '~'
    else
      if (codepoint != ' '.ord) && (codepoint != "\t".ord)
        pos = Vector3.create(position[:x], position[:y], position[:z])
        if wave
          pos[:x] += Math.sin(time * config.waveSpeed[:x] - k * config.waveOffset[:x]) * config.waveRange[:x]
          pos[:y] += Math.sin(time * config.waveSpeed[:y] - k * config.waveOffset[:y]) * config.waveRange[:y]
          pos[:z] += Math.sin(time * config.waveSpeed[:z] - k * config.waveOffset[:z]) * config.waveRange[:z]
        end
        DrawTextCodepoint3D(font, codepoint, Vector3.create(pos[:x] + textOffsetX, pos[:y], pos[:z] + textOffsetY), fontSize, backface, tint)
      end

      glyphInfo = GlyphInfo.new(font[:glyphs] + index * GlyphInfo.size)
      if glyphInfo[:advanceX] == 0
        font_rec = Rectangle.new(font[:recs] + index * Rectangle.size)
        textOffsetX += (font_rec[:width] + fontSpacing)/font[:baseSize]*scale
      else
        textOffsetX += (glyphInfo[:advanceX] + fontSpacing)/font[:baseSize]*scale
      end
    end
    k += 1
  end
end

# Measure a text in 3D ignoring the `~~` chars.
def MeasureTextWave3D(font, text, fontSize, fontSpacing, lineSpacing)
  tempLen = 0             # Used to count longer text line num chars
  lenCounter = 0

  tempTextWidth = 0.0     # Used to count longer text line width

  scale = fontSize/font[:baseSize]
  textHeight = scale
  textWidth = 0.0

  text.each_codepoint do |codepoint|
    next if codepoint == '~'.ord

    lenCounter += 1
    index = GetGlyphIndex(font, codepoint)

    if codepoint != "\n".ord
      glyphInfo = GlyphInfo.new(font[:glyphs] + index * GlyphInfo.size)
      if glyphInfo[:advanceX] != 0
        textWidth += (glyphInfo[:advanceX]+fontSpacing)/font[:baseSize]*scale
      else
        font_rec = Rectangle.new(font[:recs] + index * Rectangle.size)
        textWidth += (font_rec[:width] + glyphInfo[:offsetX])/font[:baseSize]*scale
      end
    else
      tempTextWidth = textWidth if tempTextWidth < textWidth
      lenCounter = 0
      textWidth = 0.0
      textHeight += scale + lineSpacing/font[:baseSize]*scale
    end

    tempLen = lenCounter if tempLen < lenCounter
  end

  tempTextWidth = textWidth if tempTextWidth < textWidth

  vec = Vector3.new
  vec[:x] = tempTextWidth + ((tempLen - 1).to_f*fontSpacing/font[:baseSize]*scale) # Adds chars spacing to measure
  vec[:y] = 0.25
  vec[:z] = textHeight

  return vec;
end

# Generates a nice color with a random hue
def GenerateRandomColor(s, v)
  # 0.618033988749895 : Golden ratio conjugate
  h = GetRandomValue(0, 360)
  h = (h + h*0.618033988749895).divmod(360.0)[1] # [quotient, remainder]
  return ColorFromHSV(h, s, v);
end

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT|FLAG_VSYNC_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - draw 2D text in 3D")

  spin = true # Spin the camera?
  multicolor = false # Multicolor mode

  camera = Camera.new
  camera[:position] = Vector3.create(-10.0, 15.0, -10.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  SetCameraMode(camera, CAMERA_ORBITAL)

  cubePosition = Vector3.create(0.0, 1.0, 0.0)
  cubeSize = Vector3.create(2.0, 2.0, 2.0)

  SetTargetFPS(60)

  # Use the default font
  font = GetFontDefault()
  fontSize = 8.0
  fontSpacing = 0.5
  lineSpacing = -1.0

  # Set the text (using markdown!)
  text = "Hello ~~World~~ in 3D!"
  tbox = Vector3.create(0, 0, 0)
  layers = 1
  quads = 0
  layerDistance = 0.01

  wcfg = WaveTextConfig.new
  wcfg.waveSpeed[:x] = wcfg.waveSpeed[:y] = 3.0; wcfg.waveSpeed[:z] = 0.5
  wcfg.waveOffset[:x] = wcfg.waveOffset[:y] = wcfg.waveOffset[:z] = 0.35
  wcfg.waveRange[:x] = wcfg.waveRange[:y] = wcfg.waveRange[:z] = 0.45

  time = 0.0

  # Setup a light and dark color
  light = MAROON
  dark = RED

  # Load the alpha discard shader
  alphaDiscard = LoadShader(nil, RAYLIB_TEXT_PATH + "resources/shaders/glsl330/alpha_discard.fs")

  # Array filled with multiple random colors (when multicolor mode is set)
  multi = Array.new(TEXT_MAX_LAYERS, Color.new)

  until WindowShouldClose()

    # Load a dropped TTF file dynamically (at current fontSize)
    if IsFileDropped()
      count = FFI::MemoryPointer.new :int
      droppedFiles = GetDroppedFiles(count)

      # NOTE: We only support first ttf file dropped
      file_path = droppedFiles.read_pointer.read_string
      if IsFileExtension(file_path, ".ttf")
        UnloadFont(font)
        font = LoadFontEx(file_path, fontSize.to_i, nil, 0)
      elsif IsFileExtension(file_path, ".fnt")
        UnloadFont(font)
        font = LoadFont(file_path)
        fontSize = font[:baseSize]
      end
      ClearDroppedFiles()
    end

    # Handle Events
    $show_letter_boundry = !$show_letter_boundry if IsKeyPressed(KEY_F1)
    $show_text_boundry = !$show_text_boundry if IsKeyPressed(KEY_F2)
    if IsKeyPressed(KEY_F3)
      # Handle camera change
      spin = !spin;
      # we need to reset the camera when changing modes
      camera[:target] = Vector3.create(0.0, 0.0, 0.0)
      camera[:up] = Vector3.create(0.0, 1.0, 0.0)
      camera[:fovy] = 45.0
      camera[:projection] = CAMERA_PERSPECTIVE
      if spin
        camera[:position] = Vector3.create(-10.0, 15.0, -10.0)
        SetCameraMode(camera, CAMERA_ORBITAL)
      else
        camera[:position] = Vector3.create(-10.0, 10.0, -10.0)
        SetCameraMode(camera, CAMERA_FREE)
      end
    end

    # Handle clicking the cube
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
      ray = GetMouseRay(GetMousePosition(), camera)

      # Check collision between ray and box
      collision = GetRayCollisionBox(ray, BoundingBox.create(cubePosition[:x] - cubeSize[:x]/2, cubePosition[:y] - cubeSize[:y]/2, cubePosition[:z] - cubeSize[:z]/2,
                                                             cubePosition[:x] + cubeSize[:x]/2, cubePosition[:y] + cubeSize[:y]/2, cubePosition[:z] + cubeSize[:z]/2))

      if collision[:hit]
        # Generate new random colors
        light = GenerateRandomColor(0.5, 0.78)
        dark = GenerateRandomColor(0.4, 0.58)
      end
    end

    # Handle text layers changes
    if IsKeyPressed(KEY_HOME)
      layers -= 1 if layers > 1
    elsif IsKeyPressed(KEY_END)
      layers += 1 if layers < TEXT_MAX_LAYERS
    end

    # Handle text changes
    if IsKeyPressed(KEY_LEFT) then fontSize -= 0.5
    elsif IsKeyPressed(KEY_RIGHT) then fontSize += 0.5
    elsif IsKeyPressed(KEY_UP) then fontSpacing -= 0.1
    elsif IsKeyPressed(KEY_DOWN) then fontSpacing += 0.1
    elsif IsKeyPressed(KEY_PAGE_UP) then lineSpacing -= 0.1
    elsif IsKeyPressed(KEY_PAGE_DOWN) then lineSpacing += 0.1
    elsif IsKeyDown(KEY_INSERT) then layerDistance -= 0.001
    elsif IsKeyDown(KEY_DELETE) then layerDistance += 0.001
    elsif IsKeyPressed(KEY_TAB)
      multicolor = !multicolor # Enable /disable multicolor mode
      if multicolor
        # Fill color array with random colors
        TEXT_MAX_LAYERS.times do |i|
          multi[i] = GenerateRandomColor(0.5, 0.8)
          multi[i][:a] = GetRandomValue(0, 255)
        end
      end
    end

    # Handle text input
    ch = GetCharPressed()
    if IsKeyPressed(KEY_BACKSPACE)
      # Remove last char
      text.chop!
    elsif IsKeyPressed(KEY_ENTER)
      # handle newline
      text << "\n"
    else
      # append only printable chars
      text << ch if ch != 0
    end

    # Measure 3D text so we can center it
    tbox = MeasureTextWave3D(font, text, fontSize, fontSpacing, lineSpacing)

    UpdateCamera(camera)
    quads = 0
    time += GetFrameTime()

    BeginDrawing()
      ClearBackground(RAYWHITE)

      BeginMode3D(camera)
        DrawCubeV(cubePosition, cubeSize, dark);
        DrawCubeWires(cubePosition, 2.1, 2.1, 2.1, light)

        DrawGrid(10, 2.0)

        # Use a shader to handle the depth buffer issue with transparent textures
        # NOTE: more info at https://bedroomcoders.co.uk/raylib-billboards-advanced-use/
        BeginShaderMode(alphaDiscard)
          # Draw the 3D text above the red cube
          rlPushMatrix();
            rlRotatef(90.0, 1.0, 0.0, 0.0)
            rlRotatef(90.0, 0.0, 0.0, -1.0)

            layers.times do |i|
              clr = if multicolor then multi[i] else light end
              DrawTextWave3D(font, text, Vector3.create(-tbox[:x]/2.0, layerDistance*i, -4.5), fontSize, fontSpacing, lineSpacing, true, wcfg, time, clr)
            end

            # Draw the text boundry if set
            if $show_text_boundry
              DrawCubeWiresV(Vector3.create(0.0, 0.0, -4.5 + tbox[:z]/2), tbox, dark)
            end
          rlPopMatrix()

          # Don't draw the letter boundries for the 3D text below
          slb = $show_letter_boundry
          $show_letter_boundry = false

          # Draw 3D options (use default font)
          #-------------------------------------------------------------------------
          rlPushMatrix()
            rlRotatef(180.0, 0.0, 1.0, 0.0)
            opt = TextFormat("< SIZE: %2.1f >", :float, fontSize).read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos = Vector3.create(-m[:x]/2.0, 0.01, 2.0)
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, BLUE)
            pos[:z] += 0.5 + m[:z]

            opt = TextFormat("< SPACING: %2.1f >", :float, fontSpacing).read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos[:x] = -m[:x]/2.0
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, BLUE)
            pos[:z] += 0.5 + m[:z]

            opt = TextFormat("< LINE: %2.1f >", :float, lineSpacing).read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos[:x] = -m[:x]/2.0
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, BLUE)
            pos[:z] += 1.0 + m[:z]

            opt = TextFormat("< LBOX: %3s >", :string, slb ? "ON" : "OFF").read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos[:x] = -m[:x]/2.0
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, RED)
            pos[:z] += 0.5 + m[:z]

            opt = TextFormat("< TBOX: %3s >", :string, $show_text_boundry ? "ON" : "OFF").read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos[:x] = -m[:x]/2.0
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, RED)
            pos[:z] += 0.5 + m[:z]

            opt = TextFormat("< LAYER DISTANCE: %.3f >", :float, layerDistance).read_string
            quads += TextLength(opt)
            m = MeasureText3D(GetFontDefault(), opt, 8.0, 1.0, 0.0)
            pos[:x] = -m[:x]/2.0
            DrawText3D(GetFontDefault(), opt, pos, 8.0, 1.0, 0.0, false, DARKPURPLE)
          rlPopMatrix()
          #-------------------------------------------------------------------------

          # Draw 3D info text (use default font)
          #-------------------------------------------------------------------------
          opt = "All the text displayed here is in 3D"
          quads += 36
          m = MeasureText3D(GetFontDefault(), opt, 10.0, 0.5, 0.0)
          pos = Vector3.create(-m[:x]/2.0, 0.01, 2.0)
          DrawText3D(GetFontDefault(), opt, pos, 10.0, 0.5, 0.0, false, DARKBLUE)
          pos[:z] += 1.5 + m[:z]

          opt = "press [Left]/[Right] to change the font size"
          quads += 44
          m = MeasureText3D(GetFontDefault(), opt, 6.0, 0.5, 0.0)
          pos[:x] = -m[:x]/2.0
          DrawText3D(GetFontDefault(), opt, pos, 6.0, 0.5, 0.0, false, DARKBLUE)
          pos[:z] += 0.5 + m[:z]

          opt = "press [Up]/[Down] to change the font spacing"
          quads += 44
          m = MeasureText3D(GetFontDefault(), opt, 6.0, 0.5, 0.0)
          pos[:x] = -m[:x]/2.0
          DrawText3D(GetFontDefault(), opt, pos, 6.0, 0.5, 0.0, false, DARKBLUE)
          pos[:z] += 0.5 + m[:z]

          opt = "press [PgUp]/[PgDown] to change the line spacing"
          quads += 48
          m = MeasureText3D(GetFontDefault(), opt, 6.0, 0.5, 0.0)
          pos[:x] = -m[:x]/2.0
          DrawText3D(GetFontDefault(), opt, pos, 6.0, 0.5, 0.0, false, DARKBLUE)
          pos[:z] += 0.5 + m[:z]

          opt = "press [F1] to toggle the letter boundry"
          quads += 39
          m = MeasureText3D(GetFontDefault(), opt, 6.0, 0.5, 0.0)
          pos[:x] = -m[:x]/2.0
          DrawText3D(GetFontDefault(), opt, pos, 6.0, 0.5, 0.0, false, DARKBLUE)
          pos[:z] += 0.5 + m[:z]

          opt = "press [F2] to toggle the text boundry"
          quads += 37
          m = MeasureText3D(GetFontDefault(), opt, 6.0, 0.5, 0.0)
          pos[:x] = -m[:x]/2.0
          DrawText3D(GetFontDefault(), opt, pos, 6.0, 0.5, 0.0, false, DARKBLUE)
          #-------------------------------------------------------------------------

          $show_letter_boundry = slb
        EndShaderMode()

      EndMode3D()

      DrawText("Drag & drop a font file to change the font!\nType something, see what happens!\n\nPress [F3] to toggle the camera", 10, 35, 10, BLACK)

      DrawFPS(10, 10)
    EndDrawing()
  end

  UnloadFont(font)
  CloseWindow()

end
