# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "raylib-bindings"
  spec.version       = "0.2.0"
  spec.authors       = ["vaiorabbit"]
  spec.email         = ["vaiorabbit@gmail.com"]
  spec.summary       = %q{Provides latest raylib API for Ruby}
  spec.homepage      = "https://github.com/vaiorabbit/raylib-bindings"
  spec.require_paths = ["lib"]
  spec.license       = "Zlib"
  spec.description   = <<-DESC
Ruby bindings for Raylib ( https://github.com/raysan5/raylib ).
  DESC

  spec.required_ruby_version = '>= 3.0.0'

  spec.add_runtime_dependency 'ffi', '~> 1.15'
  spec.add_runtime_dependency 'opengl-bindings2', '~> 2'

  spec.files = Dir.glob("lib/*") +
               ["README.md", "LICENSE.txt", "ChangeLog"] +
               ["examples/template.rb"]
end
