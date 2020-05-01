# frozen_string_literal: true

module LiquidDiagrams
  module Errors
    BasicError = Class.new(::StandardError)

    CommandNotFoundError = Class.new(BasicError)
    DiagramNotFoundError = Class.new(BasicError)
    RenderingFailedError = Class.new(BasicError)
    NotImplementedError = Class.new(BasicError)
  end
end
