# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class NomnomlRenderer < BasicRenderer
      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "#{input} #{output}"
        end
      end
    end
  end
end
