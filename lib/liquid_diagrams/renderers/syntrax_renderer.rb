# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class SyntraxRenderer < BasicRenderer
      OPTIONS = %w[
        scale
        style
      ].freeze

      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} --output #{output}"
        end
      end
    end
  end
end
