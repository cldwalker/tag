# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)
require File.dirname(__FILE__) + "/lib/tag/version"

Gem::Specification.new do |s|
  s.name        = "tag"
  s.version     = Tag::VERSION
  s.authors     = ["Gabriel Horner"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "http://github.com/cldwalker/tag"
  s.summary =  "tag anything from the commandline"
  s.description = "This project lets you tag anything from the commandline. The `tag` executable provides a consistent way to add, remove and modify tags for tagged items. The goal is to make tagging dead simple and usable by other commandline apps. In making tags a first class nix citizen, perhaps they will see the light of day."
  s.required_rubygems_version = ">= 1.3.6"
  s.executables  = %w(tag)
  s.add_dependency 'thor', '~> 0.14.6'
  s.add_development_dependency 'bahia', '~> 0.1'
  s.files = Dir.glob(%w[{lib,spec}/**/*.rb bin/* [A-Z]*.{txt,rdoc,md} ext/**/*.{rb,c} **/deps.rip]) + %w{Rakefile .gemspec}
  s.extra_rdoc_files = ["README.md", "LICENSE.txt"]
  s.license = 'MIT'
end
