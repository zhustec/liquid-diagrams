# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class VegaliteRenderer < BasicRenderer
      OPTIONS = %w[
        scale
      ].freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content)
      end

      def executable
        'vl2svg'
      end
    end
  end
end
