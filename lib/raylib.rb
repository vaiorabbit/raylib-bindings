# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# [NOTICE] This is an automatically generated file.

require 'ffi'
require_relative 'raylib_main.rb'
require_relative 'raymath.rb'
require_relative 'rlgl.rb'

module Raylib
  extend FFI::Library

  @@raylib_import_done = false
  def self.load_lib(libpath)

    unless @@raylib_import_done
      # Ref.: Using Multiple and Alternate Libraries
      # https://github.com/ffi/ffi/wiki/Using-Multiple-and-Alternate-Libraries
      begin
        ffi_lib_flags :now, :global
        ffi_lib libpath
        setup_symbols()
      rescue => error
        puts error
      end
    end

  end

  def self.setup_symbols()
    setup_raylib_main_symbols()
    setup_raymath_symbols()
    setup_rlgl_symbols()
  end

end
