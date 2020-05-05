# Liquid Diagrams

[![Gem](https://img.shields.io/gem/v/liquid-diagrams.svg?label=Gem&style=flat-square)](https://rubygems.org/gems/liquid-diagrams)
[![Test](https://img.shields.io/github/workflow/status/zhustec/liquid-diagrams/Test?label=Test&style=flat-square)](https://github.com/zhustec/liquid-diagrams/actions?query=workflow%3ATest)
[![Feature](https://img.shields.io/travis/com/zhustec/liquid-diagrams.svg?label=Feature&style=flat-square)](https://travis-ci.com/zhustec/liquid-diagrams)
[![Lint](https://img.shields.io/github/workflow/status/zhustec/liquid-diagrams/Lint?label=Style&style=flat-square)](https://github.com/zhustec/liquid-diagrams/actions?query=workflow%3ALint)
[![Coverage](https://img.shields.io/coveralls/github/zhustec/liquid-diagrams?label=Coverage&style=flat-square)](https://coveralls.io/github/zhustec/liquid-diagrams)
[![License](https://img.shields.io/github/license/zhustec/liquid-diagrams.svg?label=License&style=flat-square)](https://github.com/zhustec/liquid-diagrams/blob/master/LICENSE)

Liquid Diagrams is a liquid plugins for creating diagrams, it is inspired by [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram). Currently support:

- [**Blockdiag**](http://blockdiag.com/en/)
- [**Bitfield**](https://github.com/wavedrom/bitfield)
- [**Erd**](https://github.com/BurntSushi/erd)
- [**GraphViz**](http://graphviz.org/)
- [**Mermaid**](https://mermaid-js.github.io/mermaid/)
- [**Nomnoml**](http://nomnoml.com/)
- [**PlantUML**](https://plantuml.com/)
- [**Svgbob**](https://ivanceras.github.io/svgbob-editor/)
- [**Syntrax**](https://kevinpt.github.io/syntrax/)
- [**Vega**](https://vega.github.io/vega/)
- [**Vegalite**](https://vega.github.io/vega-lite/)
- [**Wavedrom**](https://wavedrom.com/).

**NOTE:** This project is under development currently.

- [Installation](#installation)
- [Usage](#usage)
  - [Supported diagrams](#supported-diagrams)
  - [Register diagrams](#register-diagrams)
  - [Use diagrams tag](#use-diagrams-tag)
  - [Parse Configurations](#parse-configurations)
- [Prerequisites](#prerequisites)
- [Configurations](#configurations)
  - [Blockdiag](#blockdiag)
  - [Bitfield](#bitfield)
  - [Erd](#erd)
  - [Graphviz](#graphviz)
  - [Mermaid](#mermaid)
  - [Nomnoml](#nomnoml)
  - [PlantUML](#plantuml)
  - [State Machine Cat](#state-machine-cat)
  - [Svgbob](#svgbob)
  - [Syntrax](#syntrax)
  - [Vega](#vega)
  - [Wavedrom](#wavedrom)
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

### Supported diagrams

```ruby
# All supported diagrams
LiquidDiagrams.diagrams
#=> [:actdiag, :blockdiag, :graphviz, :mermaid, ...]
```

### Register diagrams

Diagrams must be registered before use, no diagrams is registered by default.

```ruby
# Registered diagrams
LiquidDiagrams.registered_diagrams
# => {}

# Register one by one
LiquidDiagrams.register_diagram :graphviz

# Register in batch
LiquidDiagrams.register_diagrams :blockdiag, :mermaid

# Registered diagrams
LiquidDiagrams.registered_diagrams
# => {:graphviz => LiquidDiagrams::Blocks::GraphvizBlock, ...}
```

You can register all diagrams with:

```ruby
LiquidDiagrams.register_diagrams(LiquidDiagrams.diagrams)
```

### Use diagrams tag

Now you can use diagrams tag in liquid template:

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

### Parse Configurations

Configurations can be set for each diagrams when parse content:

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

## Prerequisites

You still need to install some dependencies, please refer to [Prerequisites](Prerequisites.md).

## Configurations

### Blockdiag

| Config      | Type          | Default     | Description                             |
| ----------- | ------------- | ----------- | --------------------------------------- |
| `antialias` | `boolean`     | unspecified | Pass diagram image to anti-alias filter |
| `font`      | `string`      | unspecified | use FONT to draw diagram                |
| `fontmap`   | `string`      | unspecified | use FONTMAP file to draw diagram        |
| `size`      | `int` x `int` | unspecified | Size of diagram (ex. 320x240)           |

### Bitfield

| Config       | Type     | Default      | Description      |
| ------------ | -------- | ------------ | ---------------- |
| `fontfamily` | `string` | "sans-serif" | font family      |
| `fontweight` | `string` | "normal"     | font weight      |
| `fontsize`   | `number` | 14           | font size        |
| `lanes`      | `number` | 2            | rectangle lanes  |
| `vspace`     | `number` | 80           | vertical space   |
| `hspace`     | `number` | 640          | horizontal space |
| `bits`       | `number` | 32           | overall bitwidth |

### Erd

| Config       | Type      | Default     | Description                           |
| ------------ | --------- | ----------- | ------------------------------------- |
| `config`     | `string`  | unspecified | Configuration file                    |
| `edge`       | `string`  | unspecified | Select one type of edge               |
| `dot-entity` | `boolean` | unspecified | Use dot tables instead of HTML tables |

Available values:

- `edge`: `compound`, `noedge`, `ortho`, `poly`, `spline`

### Graphviz

| Config             | Type      | Default     | Description                  |
| ------------------ | --------- | ----------- | ---------------------------- |
| `layout`           | `string`  | `dot`       | Set layout engine            |
| `graph_attributes` | see below | unspecified | Set default graph attributes |
| `node_attributes`  | see below | unspecified | Set default node attributes  |
| `edge_attributes`  | see below | unspecified | Set default edge attributes  |

**NOTICE:** attributes can be:

- `String`: eg. `color=red`
- `Array`: eg. `['color=blue', 'fontsize=14]` or `[['color', 'blue'], ['fontsize', '14']]`
- `Hash`: eg. `{ color: 'green', fontsize: '14' }`

### Mermaid

| Config            | Type     | Default | Description        |
| ----------------- | -------- | ------- | ------------------ |
| `width`           | `int`    | 800     | Width of the page  |
| `height`          | `int`    | 600     | Height of the page |
| `backgroundColor` | `string` | white   | Background color   |
| `theme`           | `string` | default | Theme of the chart |

### Nomnoml

Currently no configurations

### PlantUML

Currently no configurations

### State Machine Cat

| Config       | Type     | Default    | Description              |
| ------------ | -------- | ---------- | ------------------------ |
| `input-type` | `string` | `smcat`    | Input type               |
| `engine`     | `string` | `dot`      | Layout engine to use     |
| `direction`  | `string` | `top-down` | Direction of the diagram |

Available values:

- `input-type`: `smcat`, `scxml`, `json`
- `egine`: `dot`, `circo`, `fdp`, `neato`, `osage`, `twopi`
- `direction`: `top-down`, `bottom-top`, `left-right`, `right-left`

### Svgbob

| Config         | Type     | Default | Description                |
| -------------- | -------- | ------- | -------------------------- |
| `font-family`  | `string` | arial   | Font                       |
| `font-size`    | `int`    | 12      | Font size                  |
| `scale`        | `int`    | 1       | Scale the entire svg       |
| `stroke-width` | `int`    | 2       | stroke width for all lines |

### Syntrax

| Config        | Type      | Default     | Description            |
| ------------- | --------- | ----------- | ---------------------- |
| `scale`       | `int`     | 1           | Scale image            |
| `style`       | `string`  | unspecified | Style config file      |
| `transparent` | `boolean` | unspecified | Transparent background |

### Vega

| Config  | Type  | Default | Description |
| ------- | ----- | ------- | ----------- |
| `scale` | `int` | 1       | Scale image |

### Wavedrom

Currently no configurations

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/zhustec/liquid-diagrams.> This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/zhustec/liquid-diagrams/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `liquid-diagrams` project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
