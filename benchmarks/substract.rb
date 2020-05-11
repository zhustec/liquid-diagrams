# frozen_string_literal: true

require 'benchmark/ips'

Benchmark.ips do |x|
  str = 'LiquidDiagrams::Renderers::BasicRenderer'

  x.report 'split.last.sub' do
    str.split('::').last.sub(/Renderer$/, '').downcase
  end

  x.report 'regexp' do
    str.match(/::(\w+)Renderer$/).captures[0].downcase
  end

  x.compare!
end
