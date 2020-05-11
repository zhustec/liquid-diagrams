# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class GraphvizRenderer < BasicRenderer
      CONFIG_MAPPERS = {
        'layout' => 'K',
        'graph_attributes' => 'G',
        'node_attributes' => 'N',
        'edge_attributes' => 'E'
      }.freeze

      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze

      def render
        Rendering.render_with_stdin_stdout(build_command, @content)
                 .encode('utf-8').sub(XML_REGEX, '')
      end

      def executable
        'dot -Tsvg'
      end

      def arguments
        @config.slice(*CONFIG_MAPPERS.keys).map do |opt, attrs|
          Utils.join(attrs, with: " -#{CONFIG_MAPPERS[opt]}") do |attr|
            Array(attr).join('=')
          end
        end.join(' ')
      end
    end
  end
end
