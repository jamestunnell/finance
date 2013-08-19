# -*- encoding: utf-8 -*-

require File.expand_path('../lib/finance/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "finance"
  gem.version       = Finance::VERSION
  gem.summary       = %q{Keep track of project/activity finance, including budgeting and accounting.}
  gem.description   = %q{Plan and keep track of project/activity finance, including budgeting and accounting.}
  gem.license       = "MIT"
  gem.authors       = ["James Tunnell"]
  gem.email         = "jamestunnell@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/finance"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'scheduling'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'pry'
end
