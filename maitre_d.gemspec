# -*- encoding: utf-8 -*-
root = File.expand_path('../', __FILE__)
lib = "#{root}/lib"

$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "maitre_d"
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "Winton Welsh" ]
  s.email       = [ "mail@wintoni.us" ]
  s.homepage    = "http://github.com/winton/maitre_d"
  s.summary     = %q{A reservation API for deploy environments}
  s.description = %q{A reservation API for deploy environments.}

  s.executables = `cd #{root} && git ls-files bin/*`.split("\n").collect { |f| File.basename(f) }
  s.files = `cd #{root} && git ls-files`.split("\n")
  s.require_paths = %w(lib)
  s.test_files = `cd #{root} && git ls-files -- {features,test,spec}/*`.split("\n")
end