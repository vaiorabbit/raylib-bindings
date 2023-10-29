MRuby::Toolchain.new(:emscripten) do |conf|
  toolchain :clang

  conf.compilers.each do |cc|
    cc.command = "emcc"
    cc.flags.flatten!
    cc.flags.reject! { |v| v =~ /^-g/ }
  end
  conf.archiver.command = "emar"
  conf.cxx.command = "em++"

  conf.linker.command = "emcc"
  conf.linker.libraries.reject! { |v| v == 'm' }

  conf.exts do |v|
    v.executable = '.js'
    v.library = '.a'
    v.object = '.o.bc'
  end
end
