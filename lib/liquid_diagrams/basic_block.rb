# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render} or {#render!} to implement
  class BasicBlock < ::Liquid::Block
    # Return the renderer class matching the block
    #
    # @return [BasicRenderer]
    #
    # @raise [NameError] if renderer class not found
    def self.renderer
      @renderer ||= Renderers.const_get(
        name.split('::').last.gsub(/Block$/, 'Renderer')
      )
    end

    # Render with error rescued
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
    #
    # rubocop:disable Lint/UnusedMethodArgument
    def render!(context)
      self.class.renderer.render(@content, config)
    end
    # rubocop:enable Lint/UnusedMethodArgument

    def config
      config = (parse_context[:config] || {})
      config.fetch(name.split('::').last.chomp('Block').downcase, {})
    end
  end
end
