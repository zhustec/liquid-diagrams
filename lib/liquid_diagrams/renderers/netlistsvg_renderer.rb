# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class NetlistsvgRenderer < BasicRenderer
      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "#{input} -o #{output}"
        end
      end
    end
  end
end
