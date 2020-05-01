# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class PlantumlRenderer < BasicRenderer
      XML_REGEX = /^<\?xml([^>]|\n)*>\n?/.freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content).sub(XML_REGEX, '')
      end

      def build_command
        jar = Utils.vendor_path('Plantuml.1.2020.1.jar')

        options = +Utils.run_jar(jar)
        options << ' -tsvg -pipe'
      end
    end
  end
end
