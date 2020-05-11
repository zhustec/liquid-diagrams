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
        Rendering.render_with_tempfile(build_command, @content) do |input, output|
          "--input #{input} --output #{output}"
        end
      end

      def executable
        "mmdc --puppeteerConfigFile #{Utils.vendor_path('puppeteer.json')}"
      end
    end
  end
end
