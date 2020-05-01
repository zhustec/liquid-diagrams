# frozen_string_literal: true

require 'liquid'

require_relative 'liquid_diagrams/version'

require_relative 'liquid_diagrams/errors'
require_relative 'liquid_diagrams/utils'
require_relative 'liquid_diagrams/rendering'

require_relative 'liquid_diagrams/basic_renderer'
require_relative 'liquid_diagrams/basic_block'

module LiquidDiagrams
  module Renderers
    pattern = File.join(__dir__, 'liquid_diagrams/renderers/*_renderer.rb')

    Dir[pattern].sort.each { |renderer| require renderer }
  end

  module Blocks
    Renderers.constants.each do |renderer|
      name = renderer.to_s.chomp('Renderer')

      Blocks.const_set(name, Class.new(BasicBlock))
    end
  end

  class << self
    def renderers
      @renderers ||= Hash[Renderers.constants.grep(/Renderer$/).map do |name|
        [name.to_s.chomp('Renderer'), Renderers.const_get(name)]
      end]
    end

    def blocks
      @blocks ||= Hash[Blocks.constants.grep(/Block$/).map do |name|
        [name.to_s.chomp('Block'), Blocks.const_get(name)]
      end]
    end

    def register_diagrams(*diagrams)
      Array(diagrams).flatten.each { |diagram| register_diagram(diagram) }
    end

    def register_diagram(diagram)
      raise Errors::DiagramNotFoundError unless blocks.key?(diagram.to_s)

      Liquid::Template.register_tag(
        diagram.downcase, Blocks.const_get("#{diagram}Block")
      )
    end
  end
end
