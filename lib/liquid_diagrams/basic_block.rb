# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render} or {#render!} to implement
  class BasicBlock < ::Liquid::Block
    # Return the renderer class matching the block
    #
    # @return [LiquidDiagrams::BasicRenderer]
    #
    # @raise [NameError] if renderer class not found
    def self.renderer
      @renderer ||= const_get(name.gsub('Block', 'Renderer'))
    end

    # Render with error rescued
    #
    # @overwrite [#render]
    #
    # @param context [Liquid::Context]
    #
    # @return String
    def render(context)
      @content = super.to_s

      render!(context)
    rescue Errors::BasicError => error
      error
    end

    # Render without error rescued
    #
    # @param context [Liquid::Context]
    #
    # @return String
    #
    # @raise [Errors::BasicError]
    def render!(_context)
      self.class.renderer.render(@content)
    end
  end
end
