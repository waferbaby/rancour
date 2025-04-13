# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(__dir__, 'lib'))

require 'rancour/version'

Gem::Specification.new do |s|
  s.name = 'rancour'
  s.version = Rancour::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Daniel Bogan']
  s.email = ['d+rancour@waferbaby.com']
  s.homepage = 'http://github.com/waferbaby/rancour'
  s.summary = 'A simple Discord wrapper'
  s.description = 'A simple gem for working with Discord.'
  s.license = 'MIT'

  s.required_ruby_version = '> 3.0'

  s.files = Dir['lib/**/*']
  s.require_path = 'lib'

  s.add_runtime_dependency 'ed25519', '~> 1.3'
  s.add_runtime_dependency 'httpx', '~> 1.4'

  s.metadata['rubygems_mfa_required'] = 'true'
end
