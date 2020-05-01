# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    class ErdRenderer < BasicRenderer
      OPTIONS = %w[
        config
        edge
      ].freeze

      SWITCHES = {
        'dot-entity' => false
      }.freeze

      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze

      def render
        render_with_stdin_stdout(build_command, @content).sub(XML_REGEX, '')
      end

      def build_command
        command = +'erd --fmt=svg'

        @config.slice(*OPTIONS).each do |opt, value|
          command << " --#{opt}=#{value}"
        end

        Utils.merge(SWITCHES, @config).each do |switch, value|
          command << " --#{switch}" if value
        end

        command
      end
    end
  end
end
