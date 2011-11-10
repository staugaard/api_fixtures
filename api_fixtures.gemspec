# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'api_fixtures'

Gem::Specification.new do |s|
  s.name        = 'api_fixtures'
  s.version     = ApiFixtures::VERSION
  s.authors     = ['Mick Staugaard']
  s.email       = ['mick@staugaard.com']
  s.homepage    = ''
  s.summary     = 'An easy way to setup JSON API fixtures for your integration tests'

  s.files         = Dir['lib/**/*']
  s.test_files    = Dir['test/**/*']
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_runtime_dependency 'activesupport', '>= 2.3.9', '< 3.1.1'
end
