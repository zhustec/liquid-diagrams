# frozen_string_literal: true

module LiquidDiagrams
  class BasicBlock < ::Liquid::Block
    def self.renderer
      @renderer ||= const_get(name.gsub('Block', 'Renderer'))
    end

    def render(context)
      render!(context, super.to_s)
    rescue Errors::BasicError => error
      error
    end

    def render!(_context, content)
      self.class.renderer.render(content)
    end
  end
end
