# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class GraphvizRenderer < BasicRenderer
      MAPPERS = {
        'layout' => 'K',
        'graph_attributes' => 'G',
        'node_attributes' => 'N',
        'edge_attributes' => 'E'
      }.freeze

      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze

      def render
        output = render_with_stdin_stdout(build_command, @content)
        output.dup.force_encoding('utf-8').sub(XML_REGEX, '')
      end

      def build_command
        command = +'dot -Tsvg'

        @config.slice(*MAPPERS.keys).each do |opt, attrs|
          command << Utils.join(attrs, with: " -#{MAPPERS[opt]}") do |attr|
            Array(attr).join('=')
          end
        end

        command
      end
    end
  end
end
