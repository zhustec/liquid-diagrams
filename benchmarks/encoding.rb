# frozen_string_literal: true

require 'benchmark/ips'

Benchmark.ips do |x|
  str = 'LiquidDiagrams::Renderers::BasicRenderer'

  x.report 'dup.force_encoding' do
    str.dup.force_encoding('utf-8')
  end

  x.report 'encode' do
    str.encode('utf-8')
  end

  x.compare!
end
