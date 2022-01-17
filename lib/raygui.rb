# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# [NOTICE] This is an automatically generated file.

require 'ffi'

module Raylib
  extend FFI::Library
  # Define/Macro

  RAYGUI_VERSION = "3.0"

  # Enum

  GUI_STATE_NORMAL = 0
  GUI_STATE_FOCUSED = 1
  GUI_STATE_PRESSED = 2
  GUI_STATE_DISABLED = 3
  GUI_TEXT_ALIGN_LEFT = 0
  GUI_TEXT_ALIGN_CENTER = 1
  GUI_TEXT_ALIGN_RIGHT = 2
  DEFAULT = 0
  LABEL = 1
  BUTTON = 2
  TOGGLE = 3
  SLIDER = 4
  PROGRESSBAR = 5
  CHECKBOX = 6
  COMBOBOX = 7
  DROPDOWNBOX = 8
  TEXTBOX = 9
  VALUEBOX = 10
  SPINNER = 11
  LISTVIEW = 12
  COLORPICKER = 13
  SCROLLBAR = 14
  STATUSBAR = 15
  BORDER_COLOR_NORMAL = 0
  BASE_COLOR_NORMAL = 1
  TEXT_COLOR_NORMAL = 2
  BORDER_COLOR_FOCUSED = 3
  BASE_COLOR_FOCUSED = 4
  TEXT_COLOR_FOCUSED = 5
  BORDER_COLOR_PRESSED = 6
  BASE_COLOR_PRESSED = 7
  TEXT_COLOR_PRESSED = 8
  BORDER_COLOR_DISABLED = 9
  BASE_COLOR_DISABLED = 10
  TEXT_COLOR_DISABLED = 11
  BORDER_WIDTH = 12
  TEXT_PADDING = 13
  TEXT_ALIGNMENT = 14
  RESERVED = 15
  TEXT_SIZE = 16
  TEXT_SPACING = 17
  LINE_COLOR = 18
  BACKGROUND_COLOR = 19
  GROUP_PADDING = 16
  SLIDER_WIDTH = 16
  SLIDER_PADDING = 17
  PROGRESS_PADDING = 16
  CHECK_PADDING = 16
  COMBO_BUTTON_WIDTH = 16
  COMBO_BUTTON_PADDING = 17
  ARROW_PADDING = 16
  DROPDOWN_ITEMS_PADDING = 17
  TEXT_INNER_PADDING = 16
  TEXT_LINES_PADDING = 17
  COLOR_SELECTED_FG = 18
  COLOR_SELECTED_BG = 19
  SPIN_BUTTON_WIDTH = 16
  SPIN_BUTTON_PADDING = 17
  ARROWS_SIZE = 16
  ARROWS_VISIBLE = 17
  SCROLL_SLIDER_PADDING = 18
  SCROLL_SLIDER_SIZE = 19
  SCROLL_PADDING = 20
  SCROLL_SPEED = 21
  SCROLLBAR_LEFT_SIDE = 0
  SCROLLBAR_RIGHT_SIDE = 1
  LIST_ITEMS_HEIGHT = 16
  LIST_ITEMS_PADDING = 17
  SCROLLBAR_WIDTH = 18
  SCROLLBAR_SIDE = 19
  COLOR_SELECTOR_SIZE = 16
  HUEBAR_WIDTH = 17
  HUEBAR_PADDING = 18
  HUEBAR_SELECTOR_HEIGHT = 19
  HUEBAR_SELECTOR_OVERFLOW = 20

  # Typedef

  typedef :int, :GuiControlState
  typedef :int, :GuiTextAlignment
  typedef :int, :GuiControl
  typedef :int, :GuiControlProperty
  typedef :int, :GuiDefaultProperty
  typedef :int, :GuiToggleProperty
  typedef :int, :GuiSliderProperty
  typedef :int, :GuiProgressBarProperty
  typedef :int, :GuiCheckBoxProperty
  typedef :int, :GuiComboBoxProperty
  typedef :int, :GuiDropdownBoxProperty
  typedef :int, :GuiTextBoxProperty
  typedef :int, :GuiSpinnerProperty
  typedef :int, :GuiScrollBarProperty
  typedef :int, :GuiScrollBarSide
  typedef :int, :GuiListViewProperty
  typedef :int, :GuiColorPickerProperty

  # Struct

  class GuiStyleProp < FFI::Struct
    layout(
      :controlId, :ushort,
      :propertyId, :ushort,
      :propertyValue, :int,
    )
  end


  # Function

  def self.setup_raygui_symbols()
    symbols = [
      :GuiEnable,
      :GuiDisable,
      :GuiLock,
      :GuiUnlock,
      :GuiIsLocked,
      :GuiFade,
      :GuiSetState,
      :GuiGetState,
      :GuiSetFont,
      :GuiGetFont,
      :GuiSetStyle,
      :GuiGetStyle,
      :GuiWindowBox,
      :GuiGroupBox,
      :GuiLine,
      :GuiPanel,
      :GuiScrollPanel,
      :GuiLabel,
      :GuiButton,
      :GuiLabelButton,
      :GuiToggle,
      :GuiToggleGroup,
      :GuiCheckBox,
      :GuiComboBox,
      :GuiDropdownBox,
      :GuiSpinner,
      :GuiValueBox,
      :GuiTextBox,
      :GuiTextBoxMulti,
      :GuiSlider,
      :GuiSliderBar,
      :GuiProgressBar,
      :GuiStatusBar,
      :GuiDummyRec,
      :GuiScrollBar,
      :GuiGrid,
      :GuiListView,
      :GuiListViewEx,
      :GuiMessageBox,
      :GuiTextInputBox,
      :GuiColorPicker,
      :GuiColorPanel,
      :GuiColorBarAlpha,
      :GuiColorBarHue,
      :GuiLoadStyle,
      :GuiLoadStyleDefault,
      :GuiIconText,
      :GuiDrawIcon,
      :GuiGetIcons,
      :GuiGetIconData,
      :GuiSetIconData,
      :GuiSetIconPixel,
      :GuiClearIconPixel,
      :GuiCheckIconPixel,
    ]
    args = {
      :GuiEnable => [],
      :GuiDisable => [],
      :GuiLock => [],
      :GuiUnlock => [],
      :GuiIsLocked => [],
      :GuiFade => [:float],
      :GuiSetState => [:int],
      :GuiGetState => [],
      :GuiSetFont => [Font.by_value],
      :GuiGetFont => [],
      :GuiSetStyle => [:int, :int, :int],
      :GuiGetStyle => [:int, :int],
      :GuiWindowBox => [Rectangle.by_value, :pointer],
      :GuiGroupBox => [Rectangle.by_value, :pointer],
      :GuiLine => [Rectangle.by_value, :pointer],
      :GuiPanel => [Rectangle.by_value],
      :GuiScrollPanel => [Rectangle.by_value, Rectangle.by_value, :pointer],
      :GuiLabel => [Rectangle.by_value, :pointer],
      :GuiButton => [Rectangle.by_value, :pointer],
      :GuiLabelButton => [Rectangle.by_value, :pointer],
      :GuiToggle => [Rectangle.by_value, :pointer, :bool],
      :GuiToggleGroup => [Rectangle.by_value, :pointer, :int],
      :GuiCheckBox => [Rectangle.by_value, :pointer, :bool],
      :GuiComboBox => [Rectangle.by_value, :pointer, :int],
      :GuiDropdownBox => [Rectangle.by_value, :pointer, :pointer, :bool],
      :GuiSpinner => [Rectangle.by_value, :pointer, :pointer, :int, :int, :bool],
      :GuiValueBox => [Rectangle.by_value, :pointer, :pointer, :int, :int, :bool],
      :GuiTextBox => [Rectangle.by_value, :pointer, :int, :bool],
      :GuiTextBoxMulti => [Rectangle.by_value, :pointer, :int, :bool],
      :GuiSlider => [Rectangle.by_value, :pointer, :pointer, :float, :float, :float],
      :GuiSliderBar => [Rectangle.by_value, :pointer, :pointer, :float, :float, :float],
      :GuiProgressBar => [Rectangle.by_value, :pointer, :pointer, :float, :float, :float],
      :GuiStatusBar => [Rectangle.by_value, :pointer],
      :GuiDummyRec => [Rectangle.by_value, :pointer],
      :GuiScrollBar => [Rectangle.by_value, :int, :int, :int],
      :GuiGrid => [Rectangle.by_value, :float, :int],
      :GuiListView => [Rectangle.by_value, :pointer, :pointer, :int],
      :GuiListViewEx => [Rectangle.by_value, :pointer, :int, :pointer, :pointer, :int],
      :GuiMessageBox => [Rectangle.by_value, :pointer, :pointer, :pointer],
      :GuiTextInputBox => [Rectangle.by_value, :pointer, :pointer, :pointer, :pointer],
      :GuiColorPicker => [Rectangle.by_value, Color.by_value],
      :GuiColorPanel => [Rectangle.by_value, Color.by_value],
      :GuiColorBarAlpha => [Rectangle.by_value, :float],
      :GuiColorBarHue => [Rectangle.by_value, :float],
      :GuiLoadStyle => [:pointer],
      :GuiLoadStyleDefault => [],
      :GuiIconText => [:int, :pointer],
      :GuiDrawIcon => [:int, :int, :int, :int, Color.by_value],
      :GuiGetIcons => [],
      :GuiGetIconData => [:int],
      :GuiSetIconData => [:int, :pointer],
      :GuiSetIconPixel => [:int, :int, :int],
      :GuiClearIconPixel => [:int, :int, :int],
      :GuiCheckIconPixel => [:int, :int, :int],
    }
    retvals = {
      :GuiEnable => :void,
      :GuiDisable => :void,
      :GuiLock => :void,
      :GuiUnlock => :void,
      :GuiIsLocked => :bool,
      :GuiFade => :void,
      :GuiSetState => :void,
      :GuiGetState => :int,
      :GuiSetFont => :void,
      :GuiGetFont => Font.by_value,
      :GuiSetStyle => :void,
      :GuiGetStyle => :int,
      :GuiWindowBox => :bool,
      :GuiGroupBox => :void,
      :GuiLine => :void,
      :GuiPanel => :void,
      :GuiScrollPanel => Rectangle.by_value,
      :GuiLabel => :void,
      :GuiButton => :bool,
      :GuiLabelButton => :bool,
      :GuiToggle => :bool,
      :GuiToggleGroup => :int,
      :GuiCheckBox => :bool,
      :GuiComboBox => :int,
      :GuiDropdownBox => :bool,
      :GuiSpinner => :bool,
      :GuiValueBox => :bool,
      :GuiTextBox => :bool,
      :GuiTextBoxMulti => :bool,
      :GuiSlider => :float,
      :GuiSliderBar => :float,
      :GuiProgressBar => :float,
      :GuiStatusBar => :void,
      :GuiDummyRec => :void,
      :GuiScrollBar => :int,
      :GuiGrid => Vector2.by_value,
      :GuiListView => :int,
      :GuiListViewEx => :int,
      :GuiMessageBox => :int,
      :GuiTextInputBox => :int,
      :GuiColorPicker => Color.by_value,
      :GuiColorPanel => Color.by_value,
      :GuiColorBarAlpha => :float,
      :GuiColorBarHue => :float,
      :GuiLoadStyle => :void,
      :GuiLoadStyleDefault => :void,
      :GuiIconText => :pointer,
      :GuiDrawIcon => :void,
      :GuiGetIcons => :pointer,
      :GuiGetIconData => :pointer,
      :GuiSetIconData => :void,
      :GuiSetIconPixel => :void,
      :GuiClearIconPixel => :void,
      :GuiCheckIconPixel => :bool,
    }
    symbols.each do |sym|
      begin
        attach_function sym, args[sym], retvals[sym]
      rescue FFI::NotFoundError => error
        $stderr.puts("[Warning] Failed to import #{sym} (#{error}).")
      end
    end
  end

end

