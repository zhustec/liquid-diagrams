# frozen_string_literal: true

module LiquidDiagrams
  # @note All blocks are automaticly define under this module if not defined
  module Blocks
    Renderers.constants.grep(/Renderer$/).each do |renderer|
      block_name = "#{renderer.to_s.chomp('Renderer')}Block"

      next if Blocks.const_defined?(block_name)

      Blocks.const_set(block_name, Class.new(BasicBlock))
    end
  end
end
