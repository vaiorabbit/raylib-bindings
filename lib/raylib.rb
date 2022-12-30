# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings

require 'ffi'
require 'fileutils'
require_relative 'raylib_main'
require_relative 'config'
require_relative 'raymath'
require_relative 'rlgl'
require_relative 'raygui'
require_relative 'physac'
require_relative 'raylib_helper'

module Raylib
  extend FFI::Library

  def self.load_lib(libpath, raygui_libpath: nil, physac_libpath: nil)
    lib_paths = [libpath, raygui_libpath, physac_libpath].compact

    ffi_lib_flags :now, :global
    ffi_lib(*lib_paths)
    setup_symbols

    setup_raygui_symbols unless raygui_libpath.nil?
    setup_physac_symbols unless physac_libpath.nil?
  rescue LoadError => e
    warn e
  end

  def self.setup_symbols
    setup_raylib_symbols
    setup_raymath_symbols
    setup_rlgl_symbols
  end

  #
  # Generate sample code
  #
  def self.template
    # Copy template code to user's current directory
    example_path = "#{Gem::Specification.find_by_name('raylib-bindings').full_gem_path}/examples"
    template_code_src = "#{example_path}/template.rb"
    unless File.exist? template_code_src
      warn "[Error] Raylib.template : Template source #{template_code_src} not found"
      return false
    end

    template_code_dst = "#{Dir.getwd}/template.rb"
    if File.exist? template_code_dst
      warn "[Error] Raylib.template : Template destination #{template_code_dst} already exists"
      return false
    end

    warn "[Info] Raylib.template : #{template_code_src} => #{template_code_dst}"
    FileUtils.copy template_code_src, template_code_dst
    warn '[Info] Raylib.template : Done'
  end
end
