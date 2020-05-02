# frozen_string_literal: true

module LiquidDiagrams
  module Renderers
    %i[Vega Vegalite].each do |diagram|
      renderer = Class.new(BasicRenderer) do
        const_set :OPTIONS, %w[
          scale
        ].freeze

        define_method :render do
          if diagram.downcase == 'vegalite'
            @content = Rendering.render_with_stdin_stdout('vl2vg', @content)
          end

          Rendering.render_with_stdin_stdout(build_command, @content)
        end

        def build_command
          command = +'vg2svg'

          @config.slice(*self.class.const_get(:OPTIONS)).each do |opt, value|
            command << " --#{opt} #{value}"
          end

          command
        end
      end

      const_set("#{diagram}Renderer", renderer)
    end
  end
end
