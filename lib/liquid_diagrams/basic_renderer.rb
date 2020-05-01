# frozen_string_literal: true

module LiquidDiagrams
  # @abstract Subclass and override {#render} to implement
  class BasicRenderer
    def self.render(content, options = {})
      new(content, options).render
    end

    def initialize(content, options = {})
      @content = content
      @options = options
      @config = @options.delete(:config) || {}
    end

    def render
      raise Errors::NotImplementedError
    end
  end
end
