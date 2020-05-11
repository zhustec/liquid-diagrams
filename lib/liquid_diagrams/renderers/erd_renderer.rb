# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class ErdRenderer < BasicRenderer
      FLAGS = %w[
        dot-entity
      ].freeze

      OPTIONS = %w[
        config
        edge
      ].freeze

      OPTIONS_SEPARATOR = '='

      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content).sub(XML_REGEX, '')
      end

      def executable
        'erd --fmt=svg'
      end
    end
  end
end
