require File.expand_path('lib/roman/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'roman'
  s.version     = Roman::VERSION
  s.homepage    = 'https://gitlab.fit.cvut.cz/ancinpet/ruby/tree/master/hw/6'
  s.license     = 'MIT'
  s.author      = 'Petr Ančinec'
  s.email       = 'ancinpet@fit.cvut.cz'

  s.summary     = 'Tool for converting numbers into roman and arabic representation.'

  s.files       = Dir['bin/*', 'spec/*', 'lib/**/*', '*.gemspec', 'LICENSE*', 'README*']
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }
  s.has_rdoc    = 'yard'

  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'thor', '~> 0.20.0'

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'yard', '~> 0.9'
end
