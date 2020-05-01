# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class SyntraxRenderer < BasicRenderer
      OPTIONS = %w[
        scale
        style
      ].freeze

      def render
        render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} --output #{output}"
        end
      end

      def build_command
        command = +'syntrax'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
