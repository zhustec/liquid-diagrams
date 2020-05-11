# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class SmcatRenderer < BasicRenderer
      OPTIONS = %w[
        direction
        engine
        input-type
      ].freeze

      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze

      def render
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "#{input} --output-to #{output}"
        end.sub(XML_REGEX, '')
      end
    end
  end
end
