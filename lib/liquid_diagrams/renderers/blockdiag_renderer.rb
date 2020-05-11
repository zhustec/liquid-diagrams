# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    %i[Blockdiag Seqdiag Actdiag Nwdiag Rackdiag Packetdiag].each do |diagram|
      renderer = Class.new(BasicRenderer) do
        const_set :FLAGS, %w[
          antialias
        ].freeze

        const_set :OPTIONS, %w[
          config
          font
          fontmap
          size
        ].freeze

        const_set :OPTIONS_SEPARATOR, '='

        def render
          Rendering.render_with_tempfile(build_command, @content) do |input, output|
            "#{input} -o #{output}"
          end
        end

        define_method :executable do
          "#{diagram.downcase} -Tsvg --nodoctype"
        end
      end

      const_set "#{diagram}Renderer", renderer
    end
  end
end
