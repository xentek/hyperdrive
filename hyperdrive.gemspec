# encoding: utf-8
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)
require 'hyperdrive/version'

Gem::Specification.new do |gem|
  gem.name          = "hyperdrive"
  gem.version       = Hyperdrive::VERSION
  gem.authors       = ['StyleSeek Engineering']
  gem.email         = ['engineering@styleseek.com']
  gem.summary       = %q{Hypermedia State Machine}
  gem.description   = %q{Ruby DSL for defining self-documenting, HATEOAS™ complaint, Hypermedia API endpoints.}
  gem.homepage      = "https://github.com/styleseek/hyperdrive"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = ['hyperdrive', 'console']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'linguistics'
  gem.add_dependency 'thor'
end
