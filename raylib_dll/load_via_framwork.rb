require 'ffi'
module LoadLibTest
  extend FFI::Library

  def self.load_lib(libpath)
    ffi_lib_flags :now, :global
    pp ffi_lib(libpath)
  rescue LoadError => e
    warn e
  end
end

LoadLibTest.load_lib('./build_arm64/raylib/raylib.framework/raylib')
