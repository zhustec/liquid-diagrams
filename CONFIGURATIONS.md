
# Setup and Configurations

## Blockdiag

### Setup

```bash
pip3 install blockdiag seqdiag actiag nwdiag
```

Then you can use these tags: `blockdiag`, `seqdiag`, `actdiag`, `nwdiag`, `rackdiag` and `packetdiag`.

### Configurations

| Config      | Type          | Default     | Description                             |
| ----------- | ------------- | ----------- | --------------------------------------- |
| `antialias` | `boolean`     | unspecified | Pass diagram image to anti-alias filter |
| `font`      | `string`      | unspecified | use FONT to draw diagram                |
| `fontmap`   | `string`      | unspecified | use FONTMAP file to draw diagram        |
| `size`      | `int` x `int` | unspecified | Size of diagram (ex. 320x240)           |

## Erd

### Setup

```bash
sudo apt install graphviz cabal-install
cabal update && cabal install erd
```

### Configurations

| Config       | Type      | Default     | Description                           |
| ------------ | --------- | ----------- | ------------------------------------- |
| `config`     | `string`  | unspecified | Configuration file                    |
| `edge`       | `string`  | unspecified | Select one type of edge               |
| `dot-entity` | `boolean` | unspecified | Use dot tables instead of HTML tables |

Available values:

* `edge`: `compound`, `noedge`, `ortho`, `poly`, `spline`

## Graphviz

### Setup

```bash
sudo apt install graphviz
```

### Configurations

| Config             | Type      | Default     | Description                  |
| ------------------ | --------- | ----------- | ---------------------------- |
| `layout`           | `string`  | `dot`       | Set layout engine            |
| `graph_attributes` | see below | unspecified | Set default graph attributes |
| `node_attributes`  | see below | unspecified | Set default node attributes  |
| `edge_attributes`  | see below | unspecified | Set default edge attributes  |

**NOTICE:** attributes can be:

* `String`: eg. `color=red`
* `Array`: eg. `['color=blue', 'fontsize=14]` or `[['color', 'blue'], ['fontsize', '14']]`
* `Hash`: eg. `{ color: 'green', fontsize: '14' }`

## Mermaid

### Setup

```bash
npm install -g mermaid.cli
```

**Notice:** You may need to install some missing libraries, follow the output of `mmdc`.

### Configurations

| Config            | Type     | Default | Description        |
| ----------------- | -------- | ------- | ------------------ |
| `width`           | `int`    | 800     | Width of the page  |
| `height`          | `int`    | 600     | Height of the page |
| `backgroundColor` | `string` | white   | Background color   |
| `theme`           | `string` | default | Theme of the chart |

## Nomnoml

### Setup

```bash
npm install -g nomnoml
```

## PlantUML

### Setup

```bash
sudo apt install default-jre
```

## State Machine Cat

### Setup

```bash
npm install -g state-machine-cat
```

## Configuration

| Config       | Type     | Default    | Description              |
| ------------ | -------- | ---------- | ------------------------ |
| `input-type` | `string` | `smcat`    | Input type               |
| `engine`     | `string` | `dot`      | Layout engine to use     |
| `direction`  | `string` | `top-down` | Direction of the diagram |

Available values:

* `input-type`: `smcat`, `scxml`, `json`  
* `egine`: `dot`, `circo`, `fdp`, `neato`, `osage`, `twopi`
* `direction`: `top-down`, `bottom-top`, `left-right`, `right-left`

## Svgbob

### Setup

```bash
sudo apt install cargo && cargo install svgbob_cli
```

## Configuration

| Config         | Type     | Default | Description                |
| -------------- | -------- | ------- | -------------------------- |
| `font-family`  | `string` | arial   | Font                       |
| `font-size`    | `int`    | 12      | Font size                  |
| `scale`        | `int`    | 1       | Scale the entire svg       |
| `stroke-width` | `int`    | 2       | stroke width for all lines |

## Syntrax

### Setup

```bash
sudo apt install libpango1.0-dev python3-cairo python3-gi python3-gi-cairo

pip3 install syntrax
```

### Configurations

| Config        | Type      | Default     | Description            |
| ------------- | --------- | ----------- | ---------------------- |
| `scale`       | `int`     | 1           | Scale image            |
| `style`       | `string`  | unspecified | Style config file      |
| `transparent` | `boolean` | unspecified | Transparent background |

## Vega

### Setup

```bash
npm install -g vega-cli vega-lite
```

### Configurations

| Config  | Type  | Default | Description |
| ------- | ----- | ------- | ----------- |
| `scale` | `int` | 1       | Scale image |

## Wavedrom

### Setup

```bash
npm install -g wavedrom-cli
```
