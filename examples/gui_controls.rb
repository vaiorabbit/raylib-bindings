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

  textBoxText = FFI::MemoryPointer.new(:char, 64)
  textBoxText.write_string("Text box")
  textBoxEditMode = false

  textBoxMultiText = FFI::MemoryPointer.new(:char, 1024)
  textBoxMultiText.write_string("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  textBoxMultiEditMode = false

  listViewScrollIndex = 0
  listViewActive = -1

  listViewExScrollIndex = 0
  listViewExActive = 2
  listViewExFocus = -1
  listViewExList = ["This", "is", "a", "list view", "with", "disable", "elements", "amazing!"].pack("p*")

  colorPickerValue = Color.new.copy(RED)

  sliderValue = 50.0
  sliderBarValue = 60
  progressValue = 0.1

  forceSquaredChecked = false

  alphaValue = 0.5

  visualStyleActive = 0
  prevVisualStyleActive = 0

  toggleGroupActive = 0
  toggleSliderActive = 0

  viewScroll = Vector2.new

  #----------------------------------------------------------------------------------

  exitWindow = false
  showMessageBox = false

  textInput = FFI::MemoryPointer.new(:char, 256)
  textInputFileName = FFI::MemoryPointer.new(:char, 256)
  showTextInputBox = false

  alpha = 1.0

  SetTargetFPS(60)

  value_buf = FFI::MemoryPointer.new(:int, 1)

  until exitWindow

    exitWindow = WindowShouldClose()

    showMessageBox = !showMessageBox if IsKeyPressed(KEY_ESCAPE)

    showTextInputBox = true if (IsKeyDown(KEY_LEFT_CONTROL) || IsKeyDown(KEY_LEFT_SUPER)) && IsKeyPressed(KEY_S)

=begin
    alpha -= 0.002
    alpha = 0.0 if alpha < 0.0
    alpha = 1.0 if IsKeyPressed(KEY_SPACE)
    GuiSetAlpha(alpha)
=end

    if IsKeyPressed(KEY_LEFT)
      progressValue -= 0.1
    elsif IsKeyPressed(KEY_RIGHT)
      progressValue += 0.1
    end
    progressValue.clamp(0.0, 1.0)

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
      result = GuiTextBox(Rectangle.create(25, 215, 125, 30), textBoxText, textBoxText.size, textBoxEditMode)
      textBoxEditMode = !textBoxEditMode if result != 0

      GuiSetStyle(BUTTON, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER);

      showTextInputBox = true if GuiButton(Rectangle.create(25, 255, 125, 30), GuiIconText(ICON_FILE_SAVE, "Save File")) != 0

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

      listViewScrollIndex, listViewActive, result = RGuiListView(Rectangle.create(165, 25, 140, 124), "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey", listViewScrollIndex, listViewActive)
      listViewExScrollIndex, listViewExActive, listViewExFocus, result = RGuiListViewEx(Rectangle.create(165, 162, 140, 184), listViewExList, 8, listViewExScrollIndex, listViewExActive, listViewExFocus)

      toggleGroupActive, result = RGuiToggleGroup(Rectangle.create(165, 360, 140, 24), "#1#ONE\n#3#TWO\n#8#THREE\n#23#", toggleGroupActive)
      GuiSetStyle(SLIDER, SLIDER_PADDING, 2)
      toggleSliderActive, result = RGuiToggleSlider(Rectangle.create(165, 480, 140, 30), "ON;OFF", toggleSliderActive)
      GuiSetStyle(SLIDER, SLIDER_PADDING, 0)

      # Third GUI column
      GuiPanel(Rectangle.create(320, 25, 225, 140), "Panel Info")
      GuiColorPicker(Rectangle.create(320, 185, 196, 192), nil, colorPickerValue)

      sliderValue, result = RGuiSlider(Rectangle.create(355, 400, 165, 20), "TEST", TextFormat("%2.2f", :float, sliderValue), sliderValue, -50, 100)
      sliderBarValue, result = RGuiSliderBar(Rectangle.create(320, 430, 200, 20), nil, TextFormat("%i", :int, sliderBarValue.to_i), sliderBarValue, 0, 100)

      progressValue, result =  RGuiProgressBar(Rectangle.create(320, 460, 200, 20), nil, TextFormat("%i%%", :int, (progressValue*100).to_i), progressValue, 0.0, 1.0)
      GuiEnable()

      view = Rectangle.new
      GuiScrollPanel(Rectangle.create(560, 25, 102, 354), nil, Rectangle.create(560, 25, 300, 1200), viewScroll, view)

      mouseCell = Vector2.new
      GuiGrid(Rectangle.create(560, 25 + 180 + 195, 100, 120), nil, 20, 3, mouseCell)

      alphaValue, result = RGuiColorBarAlpha(Rectangle.create(320, 490, 200, 30), nil, alphaValue)

      GuiSetStyle(DEFAULT, TEXT_ALIGNMENT_VERTICAL, TEXT_ALIGN_TOP)
      GuiSetStyle(DEFAULT, TEXT_WRAP_MODE, TEXT_WRAP_WORD)
      result = GuiTextBox(Rectangle.create(678, 25, 258, 492), textBoxMultiText, textBoxMultiText.size, textBoxMultiEditMode)
      textBoxMultiEditMode = !textBoxMultiEditMode if result != 0

      GuiSetStyle(DEFAULT, TEXT_WRAP_MODE, TEXT_WRAP_NONE)
      GuiSetStyle(DEFAULT, TEXT_ALIGNMENT_VERTICAL, TEXT_ALIGN_MIDDLE)

      GuiSetStyle(DEFAULT, TEXT_ALIGNMENT, TEXT_ALIGN_LEFT)
      GuiStatusBar(Rectangle.create(0, GetScreenHeight().to_f - 20, GetScreenWidth().to_f, 20), "This is a status bar")
      GuiSetStyle(DEFAULT, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER)

      if showMessageBox
        DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
        result = GuiMessageBox(Rectangle.create(GetScreenWidth().to_f/2 - 125, GetScreenHeight().to_f/2 - 50, 250, 100), GuiIconText(ICON_EXIT, "Close Window"), "Do you really want to exit?", "Yes;No")

        if (result == 0) || (result == 2)
          showMessageBox = false
        elsif (result == 1)
          exitWindow = true
        end
      end

      if showTextInputBox
        DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
        result = GuiTextInputBox(Rectangle.create(GetScreenWidth().to_f/2 - 120, GetScreenHeight().to_f/2 - 60, 240, 140), GuiIconText(ICON_FILE_SAVE, "Save file as..."), "Introduce output file name:", "Ok;Cancel", textInput, 255, nil)

        if result == 1
          textInputFileName.write_string(textInput.read_string)
        end
        if (result == 0) || (result == 1) || (result == 2)
          showTextInputBox = false
          textInput.clear
        end
      end

      DrawFPS(10, 10)
    EndDrawing()
  end

  CloseWindow()
end
