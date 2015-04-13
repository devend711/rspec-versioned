# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/versioned/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-versioned"
  spec.version       = Rspec::Versioned::VERSION
  spec.authors       = ["devend711"]
  spec.email         = ["devend711@gmail.com"]
  spec.summary       = "Run tests over whatever API versions you want"
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/devend711/rspec-versioned"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "rspec"
  spec.add_runtime_dependency "versioned_blocks"
  spec.add_runtime_dependency "rspec-core"
  spec.add_runtime_dependency 'pry', '>= 0', '>= 0'
end
