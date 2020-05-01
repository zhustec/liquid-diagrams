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
        render_with_tempfile(build_command, @content) do |input, output|
          "#{input} --output-to #{output}"
        end.sub(XML_REGEX, '')
      end

      def build_command
        command = +'Smcat'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
