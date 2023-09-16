# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

require 'ffi'

module Raylib

  def RGuiTabBar(bounds, text, count, active)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiTabBar(bounds, text, count, active_buf)
    return active_buf.get(:int, 0), result
  end

  def RGuiToggle(bounds, text, active)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiToggle(bounds, text, active_buf)
    return active_buf.get(:int, 0), result
  end

  def RGuiToggleGroup(bounds, text, active)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiToggleGroup(bounds, text, active_buf)
    return active_buf.get(:int, 0), result
  end

  def RGuiToggleSlider(bounds, text, active)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiToggleSlider(bounds, text, active_buf)
    return active_buf.get(:int, 0), result
  end

  def RGuiCheckBox(bounds, text, checked)
    checked_buf = FFI::MemoryPointer.new(:bool, 1)
    checked_buf.put(:bool, 0, checked)
    result = GuiCheckBox(bounds, text, checked_buf)
    return checked_buf.get(:bool, 0), result
  end

  def RGuiComboBox(bounds, text, active)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiComboBox(bounds, text, active_buf)
    return active_buf.get(:int, 0), result
  end

  def RGuiDropdownBox(bounds, text, active, editMode)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiDropdownBox(bounds, text, active_buf, editMode)
    return active_buf.get(:int, 0), result
  end

  def RGuiSpinner(bounds, text, value, minValue, maxValue, editMode)
    value_buf = FFI::MemoryPointer.new(:int, 1)
    value_buf.put(:int, 0, value)
    result = GuiSpinner(bounds, text, value_buf, minValue, maxValue, editMode)
    return value_buf.get(:int, 0), result
  end

  def RGuiValueBox(bounds, text, value, minValue, maxValue, editMode)
    value_buf = FFI::MemoryPointer.new(:int, 1)
    value_buf.put(:int, 0, value)
    result = GuiValueBox(bounds, text, value_buf, minValue, maxValue, editMode)
    return value_buf.get(:int, 0), result
  end

  def RGuiSlider(bounds, textLeft, textRight, value, minValue, maxValue)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiSlider(bounds, textLeft, textRight, value_buf, minValue, maxValue)
    return value_buf.read_float, result
  end

  def RGuiSliderBar(bounds, textLeft, textRight, value, minValue, maxValue)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiSliderBar(bounds, textLeft, textRight, value_buf, minValue, maxValue)
    return value_buf.read_float, result
  end

  def RGuiProgressBar(bounds, textLeft, textRight, value, minValue, maxValue)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiProgressBar(bounds, textLeft, textRight, value_buf, minValue, maxValue)
    return value_buf.read_float, result
  end

  def RGuiListView(bounds, text, scrollIndex, active)
    scrollIndex_buf = FFI::MemoryPointer.new(:int, 1)
    scrollIndex_buf.put(:int, 0, scrollIndex)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    result = GuiListView(bounds, text, scrollIndex_buf, active_buf)
    return scrollIndex_buf.get(:int, 0), active_buf.get(:int, 0), result
  end

  def RGuiListViewEx(bounds, text, count, scrollIndex, active, focus)
    scrollIndex_buf = FFI::MemoryPointer.new(:int, 1)
    scrollIndex_buf.put(:int, 0, scrollIndex)
    active_buf = FFI::MemoryPointer.new(:int, 1)
    active_buf.put(:int, 0, active)
    focus_buf = FFI::MemoryPointer.new(:int, 1)
    focus_buf.put(:int, 0, focus)
    result = GuiListViewEx(bounds, text, count, scrollIndex_buf, active_buf, focus_buf)
    return scrollIndex_buf.get(:int, 0), active_buf.get(:int, 0), focus_buf.get(:int, 0), result
  end

  def RGuiColorBarAlpha(bounds, text, alpha)
    alpha_buf = FFI::MemoryPointer.new(:float, 1)
    alpha_buf.put_float(0, alpha)
    result = GuiColorBarAlpha(bounds, text, alpha_buf)
    return alpha_buf.read_float, result
  end

  def RGuiColorBarHue(bounds, text, value)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiColorBarHue(bounds, text, value_buf)
    return value_buf.read_float, result
  end

end
