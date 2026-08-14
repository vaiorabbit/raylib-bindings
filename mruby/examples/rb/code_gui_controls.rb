screen_width = 960
screen_height = 560

# The generated mruby bindings take DATA objects for C pointer arguments.
# But there's no FFI available on mruby environment.
# So we use GuiStyleProp, Vector2 ang BoneInfo as small writable int/float/text holders.
# TODO Prepare GuiIntHolder, GuiFloatHolder and GuiTextHolder
class IntHolder
  attr_accessor :buffer

  def initialize(value = 0)
    @buffer = Raylib::GuiStyleProp.new(value, 0, 0)
  end

  def value
    @buffer.controlId
  end

  def value=(v)
    @buffer.controlId = v
  end
end

class FloatHolder
  attr_accessor :buffer

  def initialize(value = 0)
    @buffer = Raylib::Vector2.new(value, 0.0)
  end

  def value
    @buffer.x
  end

  def value=(v)
    @buffer.x = v
  end
end

class TextHolder
  attr_accessor :buffer

  def initialize(value = '')
    # BoneInfo starts with a writable 32-byte name buffer.
    @buffer = Raylib::BoneInfo.new(value, 0)
  end

  def value
    @buffer.name
  end

  def value=(v)
    @buffer.name = v
  end
end

Raylib.InitWindow(screen_width, screen_height, 'Yet Another Ruby-raylib bindings - raygui controls')
Raylib.SetExitKey(0)
Raylib.SetTargetFPS(60)

dropdown_box_000_active = IntHolder.new
dropdown_box_000_edit_mode = 0 # false
dropdown_box_001_active = IntHolder.new
dropdown_box_001_edit_mode = 0 # false
spinner_value = IntHolder.new
spinner_edit_mode = 0 # false
value_box_value = IntHolder.new
value_box_edit_mode = 0 # false

text_box_text = TextHolder.new('Text box')
text_box_edit_mode = 0 # false
text_box_multi_text = TextHolder.new('Lorem ipsum dolor sit amet, consectetur')
text_box_multi_edit_mode = 0 # false

list_view_scroll_index = IntHolder.new
list_view_active = IntHolder.new(-1)
list_view_ex_scroll_index = IntHolder.new
list_view_ex_active = IntHolder.new(2)
list_view_ex_focus = IntHolder.new(-1)

color_picker_value = Raylib::Color.new(230, 41, 55, 255)
slider_value = FloatHolder.new(50.0)
slider_bar_value = FloatHolder.new(60.0)
progress_value = FloatHolder.new(0.1)
force_squared_checked = IntHolder.new
alpha_value = FloatHolder.new(0.5)
visual_style_active = IntHolder.new
previous_visual_style_active = 0
toggle_group_active = IntHolder.new
toggle_slider_active = IntHolder.new
view_scroll = Raylib::Vector2.new

exit_window = false
show_message_box = false
show_text_input_box = false
text_input = TextHolder.new()
text_input_file_name = ''

until exit_window
  exit_window = Raylib.WindowShouldClose
  show_message_box = !show_message_box if Raylib.IsKeyPressed(Raylib::KEY_ESCAPE)
  show_text_input_box = true if (Raylib.IsKeyDown(Raylib::KEY_LEFT_CONTROL) || Raylib.IsKeyDown(Raylib::KEY_LEFT_SUPER)) && Raylib.IsKeyPressed(Raylib::KEY_S)

  if Raylib.IsKeyPressed(Raylib::KEY_LEFT)
    progress_value.value -= 0.1
  elsif Raylib.IsKeyPressed(Raylib::KEY_RIGHT)
    progress_value.value += 0.1
  end
  progress_value.value = 0.0 if progress_value.value < 0.0
  progress_value.value = 1.0 if progress_value.value > 1.0

  if visual_style_active.value != previous_visual_style_active
    Raylib.GuiLoadStyleDefault()
    # Style files are not bundled with the mruby examples, so keep the
    # selector available while using the default style.
    Raylib.GuiSetStyle(Raylib::LABEL, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_LEFT)
    previous_visual_style_active = visual_style_active.value
  end

  Raylib.BeginDrawing
  Raylib.ClearBackground(Raylib.GetColor(Raylib.GuiGetStyle(Raylib::DEFAULT, Raylib::BACKGROUND_COLOR)))

  Raylib.GuiLock if (dropdown_box_000_edit_mode != 0 || dropdown_box_001_edit_mode != 0)

  Raylib.GuiCheckBox(Raylib::Rectangle.new(25, 108, 15, 15), 'FORCE CHECK!', force_squared_checked.buffer)
  Raylib.GuiSetStyle(Raylib::TEXTBOX, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_CENTER)

  result = Raylib.GuiSpinner(Raylib::Rectangle.new(25, 135, 125, 30), '', spinner_value.buffer, 0, 100, spinner_edit_mode)

  spinner_edit_mode = (spinner_edit_mode != 0 ? 0 : 1) if result != 0
  result = Raylib.GuiValueBox(Raylib::Rectangle.new(25, 175, 125, 30), '', value_box_value.buffer, 0, 100, value_box_edit_mode)
  value_box_edit_mode = (value_box_edit_mode != 0 ? 0 : 1) if result != 0

  Raylib.GuiSetStyle(Raylib::TEXTBOX, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_LEFT)
  result = Raylib.GuiTextBox(Raylib::Rectangle.new(25, 215, 125, 30), text_box_text.buffer, 32, text_box_edit_mode)
  text_box_edit_mode = (text_box_edit_mode != 0 ? 0 : 1) if result != 0

  Raylib.GuiSetStyle(Raylib::BUTTON, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_CENTER)
  # TODO vanila mruby cannot treat char* from GuiIconText as string.
  # show_text_input_box = true if Raylib.GuiButton(Raylib::Rectangle.new(25, 255, 125, 30), Raylib.GuiIconText(Raylib::ICON_FILE_SAVE, 'Save File')) != 0
  show_text_input_box = true if Raylib.GuiButton(Raylib::Rectangle.new(25, 255, 125, 30), 'Save File') != 0


  Raylib.GuiGroupBox(Raylib::Rectangle.new(25, 310, 125, 150), 'STATES')
  Raylib.GuiSetState(Raylib::STATE_NORMAL)
  Raylib.GuiButton(Raylib::Rectangle.new(30, 320, 115, 30), 'NORMAL')
  Raylib.GuiSetState(Raylib::STATE_FOCUSED)
  Raylib.GuiButton(Raylib::Rectangle.new(30, 355, 115, 30), 'FOCUSED')
  Raylib.GuiSetState(Raylib::STATE_PRESSED)
  Raylib.GuiButton(Raylib::Rectangle.new(30, 390, 115, 30), '#15#PRESSED')
  Raylib.GuiSetState(Raylib::STATE_DISABLED)
  Raylib.GuiButton(Raylib::Rectangle.new(30, 425, 115, 30), 'DISABLED')
  Raylib.GuiSetState(Raylib::STATE_NORMAL)

  Raylib.GuiComboBox(Raylib::Rectangle.new(25, 480, 125, 30), 'default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal', visual_style_active.buffer)

  Raylib.GuiUnlock
  Raylib.GuiSetStyle(Raylib::DROPDOWNBOX, Raylib::TEXT_PADDING, 4)
  Raylib.GuiSetStyle(Raylib::DROPDOWNBOX, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_LEFT)
  result = Raylib.GuiDropdownBox(Raylib::Rectangle.new(25, 65, 125, 30), '#01#ONE;#02#TWO;#03#THREE;#04#FOUR', dropdown_box_001_active.buffer, dropdown_box_001_edit_mode)
  dropdown_box_001_edit_mode = (dropdown_box_001_edit_mode != 0 ? 0 : 1) if result != 0
  Raylib.GuiSetStyle(Raylib::DROPDOWNBOX, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_CENTER)
  Raylib.GuiSetStyle(Raylib::DROPDOWNBOX, Raylib::TEXT_PADDING, 0)
  result = Raylib.GuiDropdownBox(Raylib::Rectangle.new(25, 25, 125, 30), 'ONE;TWO;THREE', dropdown_box_000_active.buffer, dropdown_box_000_edit_mode)
  dropdown_box_000_edit_mode = (dropdown_box_000_edit_mode != 0 ? 0 : 1) if result != 0

  Raylib.GuiListView(Raylib::Rectangle.new(165, 25, 140, 124), 'Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey', list_view_scroll_index.buffer, list_view_active.buffer)
  Raylib.GuiListView(Raylib::Rectangle.new(165, 162, 140, 184), 'This;is;a;list view;with;disable;elements;amazing!', list_view_ex_scroll_index.buffer, list_view_ex_active.buffer)
  Raylib.GuiToggleGroup(Raylib::Rectangle.new(165, 360, 140, 24), "#1#ONE\n#3#TWO\n#8#THREE\n#23#", toggle_group_active.buffer)
  Raylib.GuiSetStyle(Raylib::SLIDER, Raylib::SLIDER_PADDING, 2)
  Raylib.GuiToggleSlider(Raylib::Rectangle.new(165, 480, 140, 30), 'ON;OFF', toggle_slider_active.buffer)
  Raylib.GuiSetStyle(Raylib::SLIDER, Raylib::SLIDER_PADDING, 0)

  Raylib.GuiPanel(Raylib::Rectangle.new(320, 25, 225, 140), 'Panel Info')
  Raylib.GuiColorPicker(Raylib::Rectangle.new(320, 185, 196, 192), '', color_picker_value)
  Raylib.GuiSlider(Raylib::Rectangle.new(355, 400, 165, 20), 'TEST', 'value', slider_value.buffer, -50.0, 100.0)
  Raylib.GuiSliderBar(Raylib::Rectangle.new(320, 430, 200, 20), '', 'value', slider_bar_value.buffer, 0.0, 100.0)
  Raylib.GuiProgressBar(Raylib::Rectangle.new(320, 460, 200, 20), '', 'progress', progress_value.buffer, 0.0, 1.0)
  Raylib.GuiEnable

  view = Raylib::Rectangle.new
  Raylib.GuiScrollPanel(Raylib::Rectangle.new(560, 25, 102, 354), '', Raylib::Rectangle.new(560, 25, 300, 1200), view_scroll, view)
  Raylib.GuiGrid(Raylib::Rectangle.new(560, 400, 100, 120), '', 20.0, 3, Raylib::Vector2.new)
  Raylib.GuiColorBarAlpha(Raylib::Rectangle.new(320, 490, 200, 30), '', alpha_value.buffer)

  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_ALIGNMENT_VERTICAL, Raylib::TEXT_ALIGN_TOP)
  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_WRAP_MODE, Raylib::TEXT_WRAP_WORD)
  result = Raylib.GuiTextBox(Raylib::Rectangle.new(678, 25, 258, 492), text_box_multi_text.buffer, 32, text_box_multi_edit_mode)
  text_box_multi_edit_mode = (text_box_multi_edit_mode != 0 ? 0 : 1) if result != 0
  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_WRAP_MODE, Raylib::TEXT_WRAP_NONE)
  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_ALIGNMENT_VERTICAL, Raylib::TEXT_ALIGN_MIDDLE)

  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_LEFT)
  Raylib.GuiStatusBar(Raylib::Rectangle.new(0, Raylib.GetScreenHeight - 20, Raylib.GetScreenWidth, 20), 'This is a status bar')
  Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_ALIGNMENT, Raylib::TEXT_ALIGN_CENTER)

  if show_message_box
    Raylib.DrawRectangle(0, 0, Raylib.GetScreenWidth, Raylib.GetScreenHeight, Raylib.Fade(Raylib::Color.new(245, 245, 245, 255), 0.8))
    button_active = IntHolder.new
    button_active.value = -1
    # TODO vanila mruby cannot treat char* from GuiIconText as string.
    # result = Raylib.GuiMessageBox(Raylib::Rectangle.new(Raylib.GetScreenWidth * 0.5 - 125, Raylib.GetScreenHeight * 0.5 - 50, 250, 100), Raylib.GuiIconText(Raylib::ICON_EXIT, 'Close Window'), 'Do you really want to exit?', 'Yes;No', button_active.buffer)
    result = Raylib.GuiMessageBox(Raylib::Rectangle.new(Raylib.GetScreenWidth * 0.5 - 125, Raylib.GetScreenHeight * 0.5 - 50, 250, 100), 'Close Window', 'Do you really want to exit?', 'Yes;No', button_active.buffer)
    show_message_box = false if (button_active.value == 0 || button_active.value == 2)
    exit_window = true if button_active.value == 1
  end

  if show_text_input_box
    Raylib.DrawRectangle(0, 0, Raylib.GetScreenWidth, Raylib.GetScreenHeight, Raylib.Fade(Raylib::Color.new(245, 245, 245, 255), 0.8))
    button_active = IntHolder.new()
    button_active.value = -1
    # Fixme Current raygui mruby bindings cannot handle nil passed via arguments (cause runtime crash)
    secret_view_active = IntHolder.new(0)
    # TODO vanila mruby cannot treat char* from GuiIconText as string.
    #result = Raylib.GuiTextInputBox(Raylib::Rectangle.new(Raylib.GetScreenWidth * 0.5 - 120, Raylib.GetScreenHeight * 0.5 - 60, 240, 140), Raylib.GuiIconText(Raylib::ICON_FILE_SAVE, 'Save file as...'), 'Introduce output file name:', text_input.buffer, 32, 'Ok;Cancel', button_active.buffer, secret_view_active.buffer)
    result = Raylib.GuiTextInputBox(Raylib::Rectangle.new(Raylib.GetScreenWidth * 0.5 - 120, Raylib.GetScreenHeight * 0.5 - 60, 240, 140), 'Save file as...', 'Introduce output file name:', text_input.buffer, 32, 'Ok;Cancel', button_active.buffer, secret_view_active.buffer)
    text_input_file_name = text_input.value if button_active.value == 1
    if button_active.value == 0 || button_active.value == 1 || button_active.value == 2
      show_text_input_box = false
      text_input.value = ''
    end
  end

  Raylib.DrawFPS(10, 10)
  Raylib.EndDrawing
end

Raylib.CloseWindow
