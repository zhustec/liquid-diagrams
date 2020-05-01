# frozen_string_literal: true

require 'liquid'

require_relative 'liquid_diagrams/version'

require_relative 'liquid_diagrams/errors'
require_relative 'liquid_diagrams/utils'
require_relative 'liquid_diagrams/rendering'

require_relative 'liquid_diagrams/basic_renderer'
require_relative 'liquid_diagrams/basic_block'

module LiquidDiagrams
  # @note All renderers should be define under this module
  module Renderers
    pattern = File.join(__dir__, 'liquid_diagrams/renderers/*_renderer.rb')

    Dir[pattern].sort.each { |renderer| require renderer }
  end

  module Blocks
    Renderers.constants.grep(/Renderer$/).each do |renderer|
      Blocks.const_set(
        "#{renderer.to_s.chomp('Renderer')}Block", Class.new(BasicBlock)
      )
    end
  end

  class << self
    # Return all avaliable diagrams
    #
    # @return [Array<Symbol>]
    def avaliable_diagrams
      @avaliable_diagrams ||=
        Renderers.constants.grep(/Renderer$/).sort.map do |renderer|
          renderer.to_s.chomp('Renderer').to_sym
        end
    end

    # Return all renderers
    #
    # @return [Hash{Symbol => LiquidDiagrams::BasicRenderer}]
    def renderers
      @renderers ||= Hash[avaliable_diagrams.map do |diagram|
        [diagram.to_sym, Renderers.const_get("#{diagram}Renderer")]
      end]
    end

    # Return all blocks
    #
    # @return [Hash{Symbol => LiquidDiagrams::BasicBlock}]
    def blocks
      @blocks ||= Hash[avaliable_diagrams.map do |diagram|
        [diagram.to_sym, Blocks.const_get("#{diagram}Block")]
      end]
    end

    # Register diagrams
    #
    # @param diagrams [Array<String>, Array<Symbol>] diagrams to register
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
      diagram = diagram.to_s.capitalize.to_sym

      raise Errors::DiagramNotFoundError unless blocks.key?(diagram)

      Liquid::Template.register_tag(
        diagram.downcase, Blocks.const_get("#{diagram}Block")
      )
    end
  end
end
