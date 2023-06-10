# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

require 'ffi'

module Raylib

  def RGuiButton(bounds, text)
    result = GuiButton(bounds, text)
    return result == 1
  end

  def RGuiSliderBar(bounds, textLeft, textRight, value, minValue, maxValue)
    value_buf = FFI::MemoryPointer.new(:float, 1)
    value_buf.put_float(0, value)
    result = GuiSliderBar(bounds, textLeft, textRight, value_buf, minValue, maxValue)
    return value_buf.read_float
  end

  def RGuiCheckBox(bounds, text, checked)
    checked_buf = FFI::MemoryPointer.new(:bool, 1)
    checked_buf.put(:bool, 0, checked)
    result = GuiCheckBox(bounds, text, checked_buf)
    return checked_buf.get(:bool, 0)
  end

end
