# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class VegaliteRenderer < BasicRenderer
      def render
        content = Rendering.render_with_stdin_stdout(build_command, @content)

        VegaRenderer.render(content)
      end

      def executable
        'vl2vg'
      end
    end
  end
end
