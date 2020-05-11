# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class BitfieldRenderer < BasicRenderer
      FLAGS = %w[
        compact
        hflip
        vflip
      ].freeze

      OPTIONS = %w[
        bits
        lanes
        hspace
        vspace
        fontsize
        fontfamily
        fontweight
      ].freeze

      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} > #{output}"
        end
      end
    end
  end
end
