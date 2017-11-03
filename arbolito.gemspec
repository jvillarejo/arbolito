# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arbolito/version'

Gem::Specification.new do |s|
  s.name          = "arbolito"
  s.version       = Arbolito::VERSION
  s.authors       = ["jvillarejo"]
  s.email         = ["contact@jonvillage.com"]

  s.summary       = "A currency conversion api for the minimalist developer"
  s.description   = s.summary
  s.homepage      = "https://github.com/jvillarejo/arbolito.git"
  s.license       = "MIT"
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.3"
  s.add_development_dependency "pry", "~> 0.10"
end
