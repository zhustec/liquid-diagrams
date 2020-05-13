# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render} to implement.
  class BasicRenderer
    include Rendering

    # Configuration key for argument with boolean value.
    FLAGS = [].freeze

    # Prefix for {FLAGS}
    FLAGS_PREFIX = '--'

    # Configuration key for argument with key-value pairs.
    OPTIONS = [].freeze

    # Separator for key and value of {OPTIONS}.
    OPTIONS_SEPARATOR = ' '

    # Prefix for {OPTIONS}
    OPTIONS_PREFIX = '--'

    def self.render(content, options = {})
      new(content, options).render
    end

    def initialize(content, options = {})
      @content = content
      @config = options
    end

    # Default render method with {Errors::NotImplementedError} raised
    #
    # @important You should overrite this method in your own renderer class
    def render
      raise Errors::NotImplementedError
    end

    def build_command
      "#{executable} #{arguments}".strip
    end

    def executable
      self.class.name.split('::').last.sub(/Renderer$/, '').downcase
    end

    def arguments
      flags = Utils.build_flags(
        @config, self.class.const_get(:FLAGS),
        prefix: self.class.const_get(:FLAGS_PREFIX)
      )
      options = Utils.build_options(
        @config, self.class.const_get(:OPTIONS),
        prefix: self.class.const_get(:OPTIONS_PREFIX),
        sep: self.class.const_get(:OPTIONS_SEPARATOR)
      )

      "#{flags} #{options}".strip
    end
  end
end
