# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'api_fixtures/version'

Gem::Specification.new do |s|
  s.name        = 'api_fixtures'
  s.version     = ApiFixtures::VERSION
  s.authors     = ['Mick Staugaard']
  s.email       = ['mick@staugaard.com']
  s.homepage    = ''
  s.summary     = 'An easy way to setup JSON API fixtures for your integration tests'
  s.license     = 'Apache License Version 2.0'

  s.files         = Dir['lib/**/*']
  s.test_files    = Dir['test/**/*']
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'

  s.add_runtime_dependency 'activesupport', '>= 2.3.9'
end
