# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class MermaidRenderer < BasicRenderer
      OPTIONS = %w[
        theme
        width
        height
        backgroundColor
        configFile
        cssFile
        scale
      ].freeze

      def render
        render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} --output #{output}"
        end
      end

      def build_command
        command = +'mmdc --puppeteerConfigFile '
        command << Utils.vendor_path('mermaid_puppeteer_config.json')

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt} #{value}"
        end

        command
      end
    end
  end
end
