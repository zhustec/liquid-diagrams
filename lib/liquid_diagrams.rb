# frozen_string_literal: true

require 'liquid'

require_relative 'liquid_diagrams/version'

require_relative 'liquid_diagrams/errors'
require_relative 'liquid_diagrams/utils'
require_relative 'liquid_diagrams/rendering'

require_relative 'liquid_diagrams/basic_renderer'
require_relative 'liquid_diagrams/basic_block'

require_relative 'liquid_diagrams/renderers'
require_relative 'liquid_diagrams/blocks'

module LiquidDiagrams
  OPTIONS_KEY = :liquid_diagrams

  class << self
    # Return configuration of diagram
    def configuration(options, key: nil, default: {})
      config = options[OPTIONS_KEY.to_sym] || options[OPTIONS_KEY.to_s] || {}

      key ? (config[key.to_sym] || config[key.to_s] || default) : config
    end

    # Return all diagrams defined in {Renderers}
    #
    # @return [Array<Symbol>]
    def diagrams
      @diagrams ||= renderers.keys
    end

    # Return all avaliable renderers under {Renderers}
    #
    # @return [Hash{Symbol => BasicRenderer}]
    def renderers
      @renderers ||= Hash[
        Renderers.constants.grep(/Renderer$/).sort.map do |renderer|
          [
            renderer.to_s.chomp('Renderer').downcase.to_sym,
            Renderers.const_get(renderer)
          ]
        end
      ]
    end

    # Return all registered diagrams block
    #
    # Use {.register_diagrams} and {.register_diagram} to register a diagram
    #
    # @return [Hash{Symbol => BasicBlock}]
    def registered_diagrams
      @registered_diagrams ||= {}
    end

    # Register diagrams
    #
    # @param diagrams [Array<String, Symbol>] diagrams to register
    #
    # @return [Array<Liquid::Block>] the registered liquid blocks
    def register_diagrams(*diagrams)
      Array(diagrams).flatten.map { |diagram| register_diagram(diagram) }
    end

    # Register a diagram block
    #
    # @param diagram [#to_s] diagram name to register
    #
    # @return [Liquid::Block] the registered liquid block
    def register_diagram(diagram)
      diagram = diagram.to_s.downcase.to_sym

      raise Errors::DiagramNotFoundError unless diagrams.include?(diagram)

      block = Blocks.const_get("#{diagram.capitalize}Block")

      registered_diagrams.merge!(diagram => block)
      Liquid::Template.register_tag(diagram, block)
    end
  end
end
