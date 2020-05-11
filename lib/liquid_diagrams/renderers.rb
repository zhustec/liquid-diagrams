# frozen_string_literal: true

module LiquidDiagrams
  # @note All renderers should be defined under this module
  module Renderers
    pattern = File.join(__dir__, 'renderers/*_renderer.rb')

    Dir[pattern].sort.each { |renderer| require renderer }
  end
end
