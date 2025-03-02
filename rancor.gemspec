# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('./lib')

require 'rancor/version'

Gem::Specification.new do |s|
  s.name = 'rancor'
  s.version = Rancor::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Daniel Bogan']
  s.email = ['d+rancor@waferbaby.com']
  s.homepage = 'http://github.com/waferbaby/rancor'
  s.summary = 'A simple Discord wrapper'
  s.description = 'A simple gem for working with Discord.'
  s.license = 'MIT'

  s.required_ruby_version = '> 3.0'

  s.files = Dir['lib/**/*']
  s.require_path = 'lib'

  s.add_runtime_dependency 'httpx', '~> 1.4'

  s.metadata['rubygems_mfa_required'] = 'true'
end
