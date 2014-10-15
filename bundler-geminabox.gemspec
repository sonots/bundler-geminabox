# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundler/geminabox/version'

Gem::Specification.new do |spec|
  spec.name          = "bundler-geminabox"
  spec.version       = Bundler::Geminabox::VERSION
  spec.authors       = ["Naotoshi Seo"]
  spec.email         = ["sonots@gmail.com"]
  spec.summary       = %q{Release gems to internal rubygems such as geminabox}
  spec.description   = %q{Release gems to internal rubygems such as geminabox, and disable `rake release`}
  spec.homepage      = "https://github.com/sonots/bundler-geminabox"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
