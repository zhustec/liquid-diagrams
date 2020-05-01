# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    %i[ blockdiag seqdiag actdiag nwdiag
        rackdiag packetdiag ].each do |name|
      renderer = Class.new(BasicRenderer) do
        const_set :OPTIONS, %w[
          config
          font
          fontmap
          size
        ].freeze

        const_set :SWITCHES, {
          'antialias' => false
        }.freeze

        def render
          render_with_tempfile(build_command, @content) do |input, output|
            "#{input} -o #{output}"
          end
        end

        def build_command
          command = +"#{diagram_name} -T svg --nodoctype"

          options = self.class.const_get(:OPTIONS)
          switches = self.class.const_get(:SWITCHES)

          @config.slice(*options).each do |opt, value|
            command << " --#{opt}=#{value}"
          end

          Utils.merge(switches, @config).each do |switch, value|
            command << " --#{switch}" if value
          end

          command
        end

        define_method :diagram_name do
          name
        end
      end

      const_set "#{name.capitalize}Renderer", renderer
    end
  end
end
