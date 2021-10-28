require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 720
  screenHeight = 540

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - Bitmap font")
  SetTargetFPS(60)

  font = LoadFont("font/VP16Font_XNA.png")
  FS = font[:baseSize].to_f # Font Size

  colBG = Color.from_u8(0x00, 0x20, 0x60, 0xff)
  colHeader = Color.from_u8(0xff, 0x00, 0x00, 0xff)

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(colBG)

    DrawTextEx(font, "         1UP      HI-SCORE      2UP", Vector2.create(0, FS * 0), FS, 0, colHeader)
    DrawTextEx(font, "        23450    1234567890    12340", Vector2.create(0, FS * 1), FS, 0, WHITE)

    DrawTextEx(font, "Alphabets", Vector2.create(0, FS * 3), FS, 0, colHeader)
    DrawTextEx(font, "A QUICK BROWN FOX JUMPS OVER THE LAZY DOG.", Vector2.create(0, FS * 4), FS, 0, WHITE)
    DrawTextEx(font, "a quick brown fox jumps over the lazy dog.", Vector2.create(0, FS * 5), FS, 0, WHITE)

    DrawTextEx(font, "Source Code", Vector2.create(0, FS * 7), FS, 0, colHeader)

    DrawTextEx(font, "int main(int argc, char** argv)\n"        , Vector2.create(0, FS * 8), FS, 0, WHITE)
    DrawTextEx(font, "{\n"                                      , Vector2.create(0, FS * 9), FS, 0, WHITE)
    DrawTextEx(font, "    Application app(argc, argv);\n"       , Vector2.create(0, FS * 10), FS, 0, WHITE)
    DrawTextEx(font, "    int32_t status = app.Initialize();\n" , Vector2.create(0, FS * 11), FS, 0, WHITE)
    DrawTextEx(font, "    if (status == 0) {\n"                 , Vector2.create(0, FS * 12), FS, 0, WHITE)
    DrawTextEx(font, "        app.Main();\n"                    , Vector2.create(0, FS * 13), FS, 0, WHITE)
    DrawTextEx(font, "        app.Finalize();\n"                , Vector2.create(0, FS * 14), FS, 0, WHITE)
    DrawTextEx(font, "    }\n"                                  , Vector2.create(0, FS * 15), FS, 0, WHITE)
    DrawTextEx(font, "    return status;\n"                     , Vector2.create(0, FS * 16), FS, 0, WHITE)
    DrawTextEx(font, "}  "                                      , Vector2.create(0, FS * 17), FS, 0, WHITE)

=begin
    We cannot change spacing height between lines now (2021-10-29).
    DrawTextEx(font,
               "int main(int argc, char** argv)\n" \
               "{\n" \
               "    Application app(argc, argv);\n" \
               "    int32_t status = app.Initialize();\n" \
               "    if (status == 0) {\n" \
               "        app.Main();\n" \
               "        app.Finalize();\n" \
               "    }\n" \
               "    return status;\n" \
               "}\n",
               Vector2.create(0, FS * 8), FS, 0, WHITE)
=end

    DrawTextEx(font, "All Characters in VP16Font.bmp", Vector2.create(0, FS * 19), FS, 0, colHeader)
    DrawTextEx(font, " !\"#$%&'()*+,-./\n" , Vector2.create(0, FS * 20), FS, 0, WHITE)
    DrawTextEx(font, "0123456789:<=>?\n"   , Vector2.create(0, FS * 21), FS, 0, WHITE)
    DrawTextEx(font, "@ABCDEFGHIJKLMNO\n"  , Vector2.create(0, FS * 22), FS, 0, WHITE)
    DrawTextEx(font, "PQRSTUVWXYZ[\\]^_\n" , Vector2.create(0, FS * 23), FS, 0, WHITE)
    DrawTextEx(font, "`abcdefghijklmno\n"  , Vector2.create(0, FS * 24), FS, 0, WHITE)
    DrawTextEx(font, "pqrstuvwxyz{|}~ "    , Vector2.create(0, FS * 25), FS, 0, WHITE)

    DrawTextEx(font, "License", Vector2.create(0, FS * 27), FS, 0, colHeader)
    DrawTextEx(font, "Sample code and VP16Font are available\n"       , Vector2.create(0, FS * 28), FS, 0, WHITE)
    DrawTextEx(font, "under the zlib/libpng license. See, \n"         , Vector2.create(0, FS * 29), FS, 0, WHITE)
    DrawTextEx(font, "  http://github.com/vaiorabbit/SDLBitmapFont\n" , Vector2.create(0, FS * 30), FS, 0, WHITE)
    DrawTextEx(font, "for details."                                   , Vector2.create(0, FS * 31), FS, 0, WHITE)

    msgExit = "<Press [ESC] to exit>"
    msgLength = FS * msgExit.length
    xRightAdjust = screenWidth - msgLength
    DrawTextEx(font, msgExit, Vector2.create(xRightAdjust, FS * 32), FS, 0, YELLOW)

    EndDrawing()
  end

  UnloadFont(font)
  CloseWindow()
end
