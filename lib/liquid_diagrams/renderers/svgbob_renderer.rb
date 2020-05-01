# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class SvgbobRenderer < BasicRenderer
      OPTIONS = %w[
        font-family
        font-size
        scale
        stroke-width
      ].freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content)
      end

      def build_command
        command = +'svgbob'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
