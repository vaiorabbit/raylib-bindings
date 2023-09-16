require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 960
  screenHeight = 560
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - raygui controls")
  SetExitKey(0)

  dropdownBox000Active = 0
  dropDown000EditMode = false

  dropdownBox001Active = 0
  dropDown001EditMode = false

  spinner001Value = 0
  spinnerEditMode = false

  valueBox002Value = 0
  valueBoxEditMode = false

  textBoxText = "Text box"
  textBoxEditMode = false

  forceSquaredChecked = false

  visualStyleActive = 0
  prevVisualStyleActive = 0

  #----------------------------------------------------------------------------------

  exitWindow = false
  showMessageBox = false

  textInput = " " * 256
  textInputFileName = " " * 256
  showTextInputBox = false

  SetTargetFPS(60)

  value_buf = FFI::MemoryPointer.new(:int, 1)

  until exitWindow

    exitWindow = WindowShouldClose()

    showMessageBox = !showMessageBox if IsKeyPressed(KEY_ESCAPE)

    if visualStyleActive != prevVisualStyleActive
      GuiLoadStyleDefault()
      case (visualStyleActive)
      when 0;
      when 1; GuiLoadStyle(RAYGUI_STYLE_PATH + 'jungle/style_jungle.rgs')
      when 2; GuiLoadStyle(RAYGUI_STYLE_PATH + 'lavanda/style_lavanda.rgs')
      when 3; GuiLoadStyle(RAYGUI_STYLE_PATH + 'dark/style_dark.rgs')
      when 4; GuiLoadStyle(RAYGUI_STYLE_PATH + 'bluish/style_bluish.rgs')
      when 5; GuiLoadStyle(RAYGUI_STYLE_PATH + 'cyber/style_cyber.rgs')
      when 6; GuiLoadStyle(RAYGUI_STYLE_PATH + 'terminal/style_terminal.rgs')
      else;
      end
      GuiSetStyle(LABEL, TEXT_ALIGNMENT, TEXT_ALIGN_LEFT)

      prevVisualStyleActive = visualStyleActive;
    end

    # Draw
    # ----------------------------------------------------------------------------------
    BeginDrawing()
      ClearBackground(GetColor(GuiGetStyle(DEFAULT, BACKGROUND_COLOR)))

      GuiLock() if dropDown000EditMode || dropDown001EditMode

      # First GUI column
      forceSquaredChecked, result = RGuiCheckBox(Rectangle.create(25, 108, 15, 15), "FORCE CHECK!", forceSquaredChecked)

      GuiSetStyle(TEXTBOX, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER)

      spinner001Value, result = RGuiSpinner(Rectangle.create(25, 135, 125, 30), nil, spinner001Value, 0, 100, spinnerEditMode)
      spinnerEditMode = !spinnerEditMode if result != 0

      valueBox002Value, result = RGuiValueBox(Rectangle.create(25, 175, 125, 30), nil, valueBox002Value, 0, 100, valueBoxEditMode)
      valueBoxEditMode = !valueBoxEditMode if result != 0

      GuiSetStyle(TEXTBOX, TEXT_ALIGNMENT, TEXT_ALIGN_LEFT)
      textBoxEditMode != textBoxEditMode if GuiTextBox(Rectangle.create(25, 215, 125, 30), textBoxText, 64, textBoxEditMode) != 0

      GuiSetStyle(TEXTBOX, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER)

      showTextInputBox = true if GuiButton(Rectangle.create(25, 255, 125, 30), GuiIconText(ICON_FILE_SAVE, "Save File"))

      GuiGroupBox(Rectangle.create(25, 310, 125, 150), "STATES")
      GuiSetState(STATE_NORMAL)
      GuiButton(Rectangle.create(30, 320, 115, 30), "NORMAL")
      GuiSetState(STATE_FOCUSED)
      GuiButton(Rectangle.create(30, 355, 115, 30), "FOCUSED")
      GuiSetState(STATE_PRESSED)
      GuiButton(Rectangle.create(30, 390, 115, 30), "#15#PRESSED")
      GuiSetState(STATE_DISABLED)
      GuiButton(Rectangle.create(30, 425, 115, 30), "DISABLED")
      GuiSetState(STATE_NORMAL)

      visualStyleActive, result = RGuiComboBox(Rectangle.create(25, 480, 125, 30), "default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal", visualStyleActive)

      GuiUnlock()
      GuiSetStyle(DROPDOWNBOX, TEXT_PADDING, 4)
      GuiSetStyle(DROPDOWNBOX, TEXT_ALIGNMENT, TEXT_ALIGN_LEFT)
      dropdownBox001Active, result = RGuiDropdownBox(Rectangle.create(25, 65, 125, 30), "#01#ONE;#02#TWO;#03#THREE;#04#FOUR", dropdownBox001Active, dropDown001EditMode)
      dropDown001EditMode = !dropDown001EditMode if result != 0
      GuiSetStyle(DROPDOWNBOX, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER)
      GuiSetStyle(DROPDOWNBOX, TEXT_PADDING, 0)
      dropdownBox000Active, result = RGuiDropdownBox(Rectangle.create(25, 25, 125, 30), "ONE;TWO;THREE", dropdownBox000Active, dropDown000EditMode)
      dropDown000EditMode = !dropDown000EditMode if result != 0

      # Second GUI column

      # Third GUI column

      if showMessageBox
        DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
        result = GuiMessageBox(Rectangle.create(GetScreenWidth().to_f/2 - 125, GetScreenHeight().to_f/2 - 50, 250, 100), GuiIconText(ICON_EXIT, "Close Window"), "Do you really want to exit?", "Yes;No")

        if (result == 0) || (result == 2)
          showMessageBox = false
        elsif (result == 1)
          exitWindow = true;
        end
      end

      DrawFPS(10, 10)
    EndDrawing()
  end

  CloseWindow()
end
