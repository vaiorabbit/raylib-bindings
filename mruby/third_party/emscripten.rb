MRuby::CrossBuild.new('emscripten') do |conf|
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  # conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox 'metaprog'

  conf.gem File.expand_path('../mrbgems/mruby-raylib', __dir__)

  # conf.cc.defines << 'MRB_64BIT'
  conf.cc.defines << 'MRB_USE_FLOAT32'

  conf.toolchain :emscripten
end
