# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frb-participants/version'

Gem::Specification.new do |spec|
  spec.name          = "frb-participants"
  spec.version       = FrbParticipants::VERSION
  spec.authors       = ["Peter Graham"]
  spec.email         = ["peter@wealthsimple.com"]

  spec.summary       = %q{Rubygem for Federal Reserve Banks' Fedwire & FedACH participants}
  spec.description   = %q{Rubygem for querying Federal Reserve Banks' Fedwire & FedACH participants}
  spec.homepage      = "https://github.com/wealthsimple/frb-participants"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "neatjson"
  spec.add_development_dependency "rest-client"
  spec.add_development_dependency "pry"
end
