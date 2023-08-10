# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

# Draw text using font inside rectangle limits
def DrawTextBoxed(font, text, rec, fontSize, spacing, wordWrap, tint)
  DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, 0, 0, WHITE, WHITE)
end

MEASURE_STATE = 0
DRAW_STATE = 1

# Draw text using font inside rectangle limits with support for text selection
def DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint)

  textOffsetY = 0 # Offset between lines (on line break '\n')
  textOffsetX = 0 # Offset X to next character to draw

  scaleFactor = fontSize / font.baseSize.to_f # Character rectangle scaling factor

  # Word/character wrapping mechanism variables
  state = wordWrap ? MEASURE_STATE : DRAW_STATE

  startLine = -1 # Index where to begin drawing (where a line begins)
  endLine = -1   # Index where to stop drawing (where a line ends)
  lastk = -1     # Holds last value of the character position

  idx = -1
  k = -1
  while idx < text.length
    idx += 1
    break if idx >= text.length
    k += 1
    char = text.chars[idx]

    # Get glyph index in font
    index = char != nil ? GetGlyphIndex(font, char.ord) : 0

    # NOTE: Normally we exit the decoding sequence as soon as a bad byte is found (and return 0x3f)
    # but we need to draw all of the bad bytes using the '?' symbol moving one byte
    glyphWidth = 0
    if char != "\n"
      glyphInfo = GlyphInfo.new(font.glyphs + index * GlyphInfo.size)
      glyphWidth = if glyphInfo.advanceX == 0
                     rect = Rectangle.new(font.recs + index * Rectangle.size)
                     glyphWidth = rect.width*scaleFactor
                   else
                     glyphWidth = glyphInfo.advanceX*scaleFactor
                   end
      glyphWidth += spacing if idx + 1 < text.length
    end

    # NOTE: When wordWrap is ON we first measure how much of the text we can draw before going outside of the rec container
    # We store this info in startLine and endLine, then we change states, draw the text between those two variables
    # and change states again and again recursively until the end of the text (or until we get outside of the container).
    # When wordWrap is OFF we don't need the measure state so we go to the drawing state immediately
    # and begin drawing on the next line before we can get outside the container.
    if state == MEASURE_STATE
      # TODO: There are multiple types of spaces in UNICODE, maybe it's a good idea to add support for more
      # Ref: http://jkorpela.fi/chars/spaces.html
      endLine = idx if char == " " || char == "\t" || char == "\n"
      if (textOffsetX + glyphWidth) > rec.width
        endLine = (endLine < 1) ? idx : endLine
        endLine -= 1 if idx == endLine
        endLine = (idx - 1) if (startLine + 1) == endLine
        state = DRAW_STATE
      elsif (idx + 1) == text.length
        endLine = idx
        state = DRAW_STATE
      elsif char == "\n"
        state = DRAW_STATE
      end

      if state == DRAW_STATE
        textOffsetX = 0
        idx = startLine
        glyphWidth = 0
        # Save character position when we switch states
        tmp = lastk
        lastk = k - 1
        k = tmp
      end
    else
      if char == "\n"
        if !wordWrap
          textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
          textOffsetX = 0
        end
      else
        if !wordWrap && ((textOffsetX + glyphWidth) > rec.width)
          textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
          textOffsetX = 0
        end

        # When text overflows rectangle height limit, just stop drawing
        break if (textOffsetY + font.baseSize*scaleFactor) > rec.height

        # Draw selection background
        isGlyphSelected = false
        if (selectStart >= 0) && (k >= selectStart) && (k < (selectStart + selectLength))
          r = Rectangle.create(rec.x + textOffsetX - 1, rec.y + textOffsetY, glyphWidth, font.baseSize.to_f * scaleFactor)
          DrawRectangleRec(r, selectBackTint)
          isGlyphSelected = true
        end
        # Draw current character glyph
        if (char != " ") && (char != "\t")
          v = Vector2.create(rec.x + textOffsetX, rec.y + textOffsetY)
          DrawTextCodepoint(font, char.ord, v, fontSize, isGlyphSelected ? selectTint : tint)
        end
      end

      if wordWrap && (idx == endLine)
        textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
        textOffsetX = 0
        startLine = endLine
        endLine = -1
        glyphWidth = 0
        selectStart += lastk - k
        k = lastk
        state = MEASURE_STATE
      end
    end

    textOffsetX += glyphWidth

  end
end

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - draw text inside a rectangle")

  text = "Text cannot escape\tthis container\t...word wrap also works when active so here's a long text for testing.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod te  mpor incididunt ut labore et dolore magna aliqua. Nec ullamcorper sit amet risus nullam eget felis eget."
  # text = IO.readlines('./jpfont/jpfont.txt').join # For Japanese text # For Japanese text

  resizing = false
  wordWrap = true

  container = Rectangle.create(25.0, 25.0, screenWidth - 50.0, screenHeight - 250.0)
  resizer = Rectangle.create(container.x + container.width - 17, container.y + container.height - 17, 14, 14)

  # Minimum width and heigh for the container rectangle
  minWidth = 60
  minHeight = 60
  maxWidth = screenWidth - 50.0
  maxHeight = screenHeight - 160.0

  lastMouse = Vector2.create(0.0, 0.0) # Stores last mouse coordinates
  borderColor = MAROON                 # Container border color
  font = GetFontDefault()
  # font = LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", 16, nil, 65535) # For Japanese text
  # SetTextureFilter(font.texture, TEXTURE_FILTER_POINT)             # For Japanese text

  SetTargetFPS(60)

  until WindowShouldClose()

    wordWrap = !wordWrap if IsKeyPressed(KEY_SPACE)

    mouse = GetMousePosition()

    # Check if the mouse is inside the container and toggle border color
    if CheckCollisionPointRec(mouse, container)
      borderColor = Fade(MAROON, 0.4)
    elsif !resizing
      borderColor = MAROON
    end

    # Container resizing logic
    if resizing
      resizing = false if IsMouseButtonReleased(MOUSE_BUTTON_LEFT)

      width = container.width + (mouse.x - lastMouse.x)
      container.width = (width > minWidth) ? ((width < maxWidth) ? width : maxWidth) : minWidth

      height = container.height + (mouse.y - lastMouse.y)
      container.height = (height > minHeight) ? ((height < maxHeight) ? height : maxHeight) : minHeight
    else
      # Check if we're resizing
      resizing = (IsMouseButtonDown(MOUSE_BUTTON_LEFT) && CheckCollisionPointRec(mouse, resizer))
    end

    # Move resizer rectangle properly
    resizer.x = container.x + container.width - 17
    resizer.y = container.y + container.height - 17

    lastMouse = mouse # Update mouse

    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawRectangleLinesEx(container, 3, borderColor) # Draw container border

      # Draw text in container (add some padding)
      DrawTextBoxed(font, text, Rectangle.create(container.x + 4, container.y + 4, container.width - 4, container.height - 4), 20.0, 2.0, wordWrap, GRAY)

      DrawRectangleRec(resizer, borderColor) # Draw the resize box

      # Draw bottom info
      DrawRectangle(0, screenHeight - 54, screenWidth, 54, GRAY)
      DrawRectangleRec(Rectangle.create(382.0, screenHeight - 34.0, 12.0, 12.0), MAROON)

      DrawText("Word Wrap: ", 313, screenHeight-115, 20, BLACK)
      if wordWrap
        DrawText("ON", 447, screenHeight - 115, 20, RED)
      else
        DrawText("OFF", 447, screenHeight - 115, 20, BLACK)
      end

      DrawText("Press [SPACE] to toggle word wrap", 218, screenHeight - 86, 20, GRAY)

      DrawText("Click hold & drag the    to resize the container", 155, screenHeight - 38, 20, RAYWHITE)
    EndDrawing()
  end

  CloseWindow()

end
