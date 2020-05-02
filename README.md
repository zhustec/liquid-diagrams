# Liquid Diagrams

[![Gem](https://img.shields.io/gem/v/liquid-diagrams.svg?label=Gem&style=flat-square)](https://rubygems.org/gems/liquid-diagrams)
[![Test](https://img.shields.io/github/workflow/status/zhustec/liquid-diagrams/Test?label=Test&style=flat-square)](https://github.com/zhustec/liquid-diagrams/actions?query=workflow%3ATest)
[![Linter](https://img.shields.io/github/workflow/status/zhustec/liquid-diagrams/Lint?label=Style&style=flat-square)](https://github.com/zhustec/liquid-diagrams/actions?query=workflow%3ALint)
[![Coverage](https://img.shields.io/coveralls/github/zhustec/liquid-diagrams?label=Coverage&style=flat-square)](https://coveralls.io/github/zhustec/liquid-diagrams)
[![License](https://img.shields.io/github/license/zhustec/liquid-diagrams.svg?label=License&style=flat-square)](https://github.com/zhustec/liquid-diagrams/blob/master/LICENSE)

Liquid Diagrams is a liquid plugins for creating diagrams, it is inspired by [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram). Currently support:

- [**Blockdiag**](http://blockdiag.com/en/)
- [**Erd**](https://github.com/BurntSushi/erd)
- [**GraphViz**](http://graphviz.org/)
- [**Mermaid**](https://mermaid-js.github.io/mermaid/)
- [**Nomnoml**](http://nomnoml.com/)
- [**PlantUML**](https://plantuml.com/)
- [**Svgbob**](https://ivanceras.github.io/svgbob-editor/)
- [**Syntrax**](https://kevinpt.github.io/syntrax/)
- [**Vega**](https://vega.github.io/vega/)
- [**Vega-Lite**](https://vega.github.io/vega-lite/)
- [**WaveDrom**](https://wavedrom.com/).

**NOTE:** This project is under development currently.

- [Installation](#installation)
- [Usage](#usage)
  - [List of diagrams](#list-of-diagrams)
  - [Register diagrams](#register-diagrams)
  - [Use diagrams tag](#use-diagrams-tag)
- [Configurations](#configurations)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid-diagrams'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install liquid-diagrams
```

## Usage

```ruby
# Require `liquid_diagrams` or `liquid-diagrams`

require 'liquid_diagrams'
```

### List of diagrams

```ruby
LiquidDiagrams.diagrams
#=> [:actdiag, :blockdiag, :graphviz, :mermaid, ...]

# Registered diagrams, no diagrams is registered by default
LiquidDiagrams.registered_diagrams
# => {}
```

### Register diagrams

```ruby
# Register one by one
LiquidDiagrams.register_diagram :graphviz
# => LiquidDiagrams::Blocks::GraphvizBlock

# Register in batch
LiquidDiagrams.register_diagrams :blockdiag, :mermaid
# => [Blocks::BlockdiagBlock, Blocks::MermaidBlock]

# Registered diagrams
LiquidDiagrams.registered_diagrams
# => {:graphviz => LiquidDiagrams::Blocks::GraphvizBlock, ...}

# Register all available diagrams
LiquidDiagrams.register_diagrams(LiquidDiagrams.diagrams)
```

### Use diagrams tag

```ruby
content = <<~CONTENT
  {% blockdiag %}
    blockdiag {
      A -> B -> C -> D;
      A -> E -> F -> G;
    }
  {% endblockdiag %}
CONTENT

template = Liquid::Template.parse(content)
template.render
# => "<svg ...>...</svg>"
```

## Dependencies and Configurations

Configurations can be set for each diagrams when parse content, e.g.:

```ruby
content = <<~CONTENT
  {% blockdiag %}
    blockdiag {
      A -> B -> C -> D;
      A -> E -> F -> G;
    }
  {% endblockdiag %}
CONTENT

options = {
  blockdiag: {
    'scale' => 3
  }
  # options for other diagrams
}

template = Liquid::Template.parse(content, liquid_diagrams: options)
template.render
# => "<svg ...>...</svg>"
```

See [Configurations](CONFIGURATIONS.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/zhustec/liquid-diagrams.> This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/zhustec/liquid-diagrams/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `liquid-diagrams` project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
