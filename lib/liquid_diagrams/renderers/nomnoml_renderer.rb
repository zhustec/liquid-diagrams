# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class NomnomlRenderer < BasicRenderer
      def render
        render_with_tempfile(build_command, @content) do |input, output|
          "#{input} #{output}"
        end
      end

      def build_command
        'nomnoml'
      end
    end
  end
end
