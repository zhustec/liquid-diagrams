# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render_svg} to implement
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

    # @note Do not override this method, override {#render_svg} instead
    def render(context)
      @context = context
      @content = super.to_s
      @config = read_config

      render_svg
    end

    def render_svg
      self.class.renderer.render(@content, @config)
    rescue Errors::BasicError => error
      handle_error(error)
    end

    def handle_error(error)
      error
    end

    def read_config
      options = LiquidDiagrams.configuration(parse_context, key: block_name)
      inline_options = Utils.parse_inline_options(@markup.strip)

      options.merge(inline_options)
    end
  end
end
