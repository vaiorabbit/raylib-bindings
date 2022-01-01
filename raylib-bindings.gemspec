# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "raylib-bindings"
  gem.version       = "0.0.2"
  gem.authors       = ["vaiorabbit"]
  gem.email         = ["vaiorabbit@gmail.com"]
  gem.summary       = %q{Provides latest raylib API for Ruby}
  gem.homepage      = "https://github.com/vaiorabbit/raylib-bindings"
  gem.require_paths = ["lib"]
  gem.license       = "Zlib"
  gem.description   = <<-DESC
Ruby bindings for SDL2.
  DESC

  gem.required_ruby_version = '>= 3.0.0'

  gem.files = Dir.glob("lib/*") +
              ["README.md", "LICENSE.txt", "ChangeLog"]
end
