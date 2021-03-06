# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class WavedromRenderer < BasicRenderer
      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} --svg #{output}"
        end
      end

      def executable
        'wavedrom-cli'
      end
    end
  end
end
