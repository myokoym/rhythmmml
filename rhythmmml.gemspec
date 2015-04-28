# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhythmmml/version'

Gem::Specification.new do |spec|
  spec.name          = "rhythmmml"
  spec.version       = Rhythmmml::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.description   = %q{A rhythm game for MML (Music Macro Language) by Gosu.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/myokoym/rhythmmml"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("gosu")
  spec.add_runtime_dependency("mml2wav")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
end
