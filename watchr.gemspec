# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "watchr/version"

Gem::Specification.new do |s|
  s.name        = "ruby-watchr"
  s.version     = Watchr::VERSION
  s.authors     = ["Petr Janda"]
  s.email       = ["petrjanda@me.com"]
  s.homepage    = ""
  s.summary     = 'Ruby static code analysis'
  s.description = 'Utility to gather summary of code smells according to multiple analysers.'

  s.rubyforge_project = "watchr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency 'flog'
  s.add_dependency 'flay'
  s.add_dependency 'reek'
  s.add_dependency 'ruby2ruby'
end
