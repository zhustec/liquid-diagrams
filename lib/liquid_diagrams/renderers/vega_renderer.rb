# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class VegaRenderer < BasicRenderer
      OPTIONS = %w[
        scale
      ].freeze

      def render
        render_with_stdin_stdout(build_command, @content)
      end

      def build_command
        command = +'vg2svg'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
