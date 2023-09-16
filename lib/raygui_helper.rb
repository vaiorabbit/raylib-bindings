# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

require 'ffi'

module Raylib

  def RGuiSliderBar(bounds, textLeft, textRight, value, minValue, maxValue)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiSliderBar(bounds, textLeft, textRight, value_buf, minValue, maxValue)
    return value_buf.read_float, result
  end

  def RGuiCheckBox(bounds, text, checked)
    checked_buf = FFI::MemoryPointer.new(:bool, 1)
    checked_buf.put(:bool, 0, checked)
    result = GuiCheckBox(bounds, text, checked_buf)
    return checked_buf.get(:bool, 0), result
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

end
