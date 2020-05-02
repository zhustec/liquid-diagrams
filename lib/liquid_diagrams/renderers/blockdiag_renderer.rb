# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    %i[ Blockdiag
        Seqdiag
        Actdiag
        Nwdiag
        Rackdiag
        Packetdiag ].each do |diagram|
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
          Rendering.render_with_tempfile(build_command, @content) do |input, output|
            "#{input} -o #{output}"
          end
        end

        define_method :build_command do
          command = +"#{diagram.downcase} -T svg --nodoctype"

          options = self.class.const_get(:OPTIONS)
          switches = self.class.const_get(:SWITCHES)

          @config.slice(*options).each do |opt, value|
            command << " --#{opt}=#{value}"
          end

          Utils.merge(switches, @config).each do |swc, value|
            command << " --#{swc}" if value
          end

          command
        end
      end

      const_set "#{diagram}Renderer", renderer
    end
  end
end
