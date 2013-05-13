# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_pup/version'

Gem::Specification.new do |gem|
  gem.name          = "time_pup"
  gem.version       = TimePup::VERSION
  gem.authors       = ["Sachin Ranchod"]
  gem.email         = ["sachin.ranchod@gmail.com"]
  gem.description   = %q{A simple natural language date time parser extracted from hound.cc. Perfect for parsing the local part of an email address}
  gem.summary       = %q{Parses time from now (1day2h), weekdays (mon9am), actual dates (15sep2013), actual time (1030) and more.  See hound.cc/how-to for examples. }
  gem.homepage      = "http://www.hound.cc"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "debugger"
  gem.add_dependency "activesupport", "~> 3.2"
  gem.add_dependency "tzinfo"
end
