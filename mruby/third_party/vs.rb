MRuby::Build.new do |conf|
  # Load default core GEMs
  conf.gembox 'default'

  conf.gem File.expand_path('../mrbgems/mruby-raylib', __dir__)

  # conf.cc.defines << 'MRB_64BIT'
  conf.cc.defines << 'MRB_USE_FLOAT32'

  # Configure the toolchain to use Visual Studio
  conf.toolchain :visualcpp
end
