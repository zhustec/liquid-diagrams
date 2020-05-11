# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class PlantumlRenderer < BasicRenderer
      XML_REGEX = /^<\?xml([^>]|\n)*>\n?/.freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content)
                 .sub(XML_REGEX, '')
      end

      def executable
        jar_path = Utils.vendor_path('plantuml.1.2020.1.jar')

        "#{Utils.run_jar(jar_path)} -tsvg -pipe"
      end
    end
  end
end
