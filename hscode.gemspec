# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hscode/version'

Gem::Specification.new do |spec|
  spec.name          = 'hscode'
  spec.version       = Hscode::VERSION
  spec.authors       = ['Herbert Kagumba']
  spec.email         = ['habukagumba@gmail.com']

  spec.summary       = %q{A HTTP status code lookup command line tool.}
  spec.description   = %q{Quickly look up any status code without leaving your terminal.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'guard', '~> 2.14'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'

  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'rubocop', '~> 0.42'
  spec.add_development_dependency 'brakeman', '~> 3.3'
  spec.add_development_dependency 'rubycritic', '~> 2.9'
end
