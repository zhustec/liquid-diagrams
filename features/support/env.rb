# frozen_string_literal: true

require 'bundler/setup'

require 'pry-byebug'

require 'liquid_diagrams'

LiquidDiagrams.register_diagrams(LiquidDiagrams.diagrams)

def render_liquid(content, options = {})
  template = Liquid::Template.parse(content, liquid_diagrams: options)

  template.render
end
