# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fbcifs/version'

Gem::Specification.new do |spec|
  spec.name          = "fbcifs"
  spec.version       = FbCifs::VERSION
  spec.authors       = ["Piotr Limanowski - m095445"]
  spec.email         = ["Piotr.Limanowski@nordea.com"]
  spec.description   = %q{A CIFS connectivity wrapper gem for filebroker. Mostly the code pulled out of the common.rb from the original ruby filebroker.}
  spec.summary       = %q{A CIFS connectivity wrapper gem for filebroker.}
  spec.homepage      = "http://10.0.26.75/gitbucket/filebroker/fbcifs"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "rake-rspec"
end
