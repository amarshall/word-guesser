# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "word_guesser/version"

Gem::Specification.new do |s|
  s.name        = "word_guesser"
  s.version     = WordGuesser::VERSION
  s.authors     = ["Andrew Marshall"]
  s.email       = ["andrew@johnandrewmarshall.com"]
  s.homepage    = "http://johnandrewmarshall.com/projects/word_guesser"
  s.summary     = %q{A word guesser}
  s.description = %q{A simple app to guess possible words given known letters}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
