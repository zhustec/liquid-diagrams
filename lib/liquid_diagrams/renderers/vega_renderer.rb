# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class VegaRenderer < BasicRenderer
      OPTIONS = %w[
        scale
      ].freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content)
      end

      def executable
        'vg2svg'
      end
    end
  end
end
