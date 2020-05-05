# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class BitfieldRenderer < BasicRenderer
      OPTIONS = %w[
        vspace
        hspace
        lanes
        bits
        fontsize
        fontfamily
        fontweight
      ].freeze

      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} > #{output}"
        end
      end

      def build_command
        command = +'bitfield'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
