require 'ffi'

module Raylib

  extend FFI::Library

  @@raylib_import_done = false

  class Color < FFI::Struct
    layout(
      :r, :uchar,
      :g, :uchar,
      :b, :uchar,
      :a, :uchar
    )
  end

  class Vector2 < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
    )
  end

  def self.load_lib(libpath = './raylib.dylib', output_error = false)
    ffi_lib_flags :now, :global
    ffi_lib libpath
    import_symbols(output_error) unless @@raylib_import_done
  end

  def self.import_symbols(output_error = false)
    symbols = [
      :InitWindow,
      :SetTargetFPS,
      :WindowShouldClose,
      :BeginDrawing,
      :ClearBackground,
      :DrawText,
      :EndDrawing,
      :CloseWindow,

      :DrawLineV,
    ]
    args = {
      :InitWindow => [:int, :int, :pointer],
      :SetTargetFPS => [:int],
      :WindowShouldClose => [],
      :BeginDrawing => [],
      :ClearBackground => [Color.by_value],
      :DrawText => [:pointer, :int, :int, :int, Color.by_value],
      :EndDrawing => [],
      :CloseWindow => [],

      :DrawLineV => [Vector2.by_value, Vector2.by_value, Color.by_value],
    }
    retvals = {
      :InitWindow => :void,
      :SetTargetFPS => :void,
      :WindowShouldClose => :bool,
      :BeginDrawing => :void,
      :ClearBackground => :void,
      :DrawText => :void,
      :EndDrawing => :void,
      :CloseWindow => :void,

      :DrawLineV => :void,
    }

    symbols.each do |sym|
      begin
        attach_function sym, args[sym], retvals[sym]
      rescue FFI::NotFoundError => error
        $stderr.puts("[Warning] Failed to import #{s}.\n") if output_error
      end
    end
  end

end
