# frozen_string_literal: true

require_relative 'lib/liquid_diagrams/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquid-diagrams'
  spec.version       = LiquidDiagrams::VERSION
  spec.authors       = ['zhustec']
  spec.email         = ['zhustec@foxmail.com']

  spec.summary       = 'Liquid plugins for diagrams support.'
  spec.description   = <<~DESC
    A Liquid plugin with support for Blockdiag, Erd, GraphViz, Mermaid,
    Nomnoml, PlantUML, Svgbob, Syntrax, Vega, Vega-Lite and WaveDrom.
  DESC
  spec.homepage      = 'https://github.com/zhustec/liquid-diagrams'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'vendor/**/*', 'LICENSE', 'README.md']
  spec.test_files    = Dir['spec/**/*']

  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'changelog_uri' => 'https://github.com/zhustec/liquid-diagrams/releases',
    'source_code_uri' => 'https://github.com/zhustec/liquid-diagrams',
    'bug_tracker_uri' => 'https://github.com/zhustec/liquid-diagrams/issues'
  }

  spec.post_install_message = "
    __________________________________________________________
    ..........................................................

    Thank you for installing liquid-diagrams.

    But it doesn't mean that you can use all diagrams for now,
    You still need to install some dependencies by your self.

    Please refer to the link below for more details:

    https://github.com/zhustec/liquid-diagrams#prerequisites

    ..........................................................
    __________________________________________________________
  "

  spec.add_dependency 'liquid', '~> 4.0'

  spec.add_development_dependency 'cucumber', '>= 3.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.0'
  spec.add_development_dependency 'rake', '>= 12.0', '< 14.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.82.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.30'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'simplecov-lcov', '~> 0.5'
end
