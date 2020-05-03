# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render_with_rescue} or
  #   {#render_without_rescue} to implement
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

    # @note Do not overwite this method, overwrite {#render_with_rescue} or
    #   {#render_without_recue} instead
    def render(context)
      @content = super.to_s
      @context = context

      render_with_rescue
    end

    # Render diagram with error rescued
    #
    # @return [String]
    def render_with_rescue
      render_without_rescue
    rescue Errors::BasicError => error
      handle_error(error)
    end

    # Render diagram without error rescued
    #
    # @return [String]
    #
    # @raise [NameError] @see {.renderer}
    # @raise [Errors::BasicError] if rendering failed
    def render_without_rescue
      self.class.renderer.render(@content, config)
    end

    # Default error handler
    def handle_error(error)
      error
    end

    # Read configurations
    #
    # @return [Hash]
    def config
      template_options.merge(inline_options)
    end

    # Read block options from parse context
    def template_options
      opts = parse_context[OPTIONS_KEY] || parse_context[OPTIONS_KEY.to_s] || {}

      opts.fetch(block_name.to_sym) { opts.fetch(block_name, {}) }
    end

    # Read inline options from markup
    def inline_options
      Utils.parse_inline_options(@markup.strip)
    end
  end
end
