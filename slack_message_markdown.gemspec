# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_message_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_message_markdown'
  spec.version       = SlackMessageMarkdown::VERSION
  spec.authors       = ['Ru/MuckRu']
  spec.email         = ['ru_shalm@hazimu.com']
  spec.summary       = %q{convert slack message to HTML.}
  spec.description   = %q{convert slack message to HTML.}
  spec.homepage      = 'https://github.com/rutan/slack_message_markdown'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'html-pipeline', '~> 1.11.0'
  spec.add_dependency 'escape_utils', '~> 1.0.1'
  spec.add_dependency 'kramdown', '~> 1.5.0'
  spec.add_dependency 'gemoji', '~> 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
