# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'locked_process'


Gem::Specification.new do |s|
  s.name          = 'locked_process'
  s.version       = LockedProcess::VERSION
  s.date          = '2013-04-26'
  s.summary       = "Thread process with that can run once it is unique"
  s.description   = "Trhead process that only executes if no other thread with the same lock file is running"
  s.authors       = ["Marcelo Jacobus"]
  s.email         = 'marcelo.jacobus@gmail.com'

  s.files         = [
    "README.md",
    "lib/locked_process.rb",
  ]

  s.test_files    = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]
  s.homepage      = "https://github.com/mjacobus/locked_process"

  s.add_development_dependency "rspec"
  s.add_development_dependency 'simplecov'
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency 'rb-inotify'
end
