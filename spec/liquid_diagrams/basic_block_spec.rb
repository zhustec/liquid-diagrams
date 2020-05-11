# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::BasicBlock do
  let(:block) do
    TestBlock.parse(
      'test', 'markup', Liquid::Tokenizer.new('{% endtest %}'),
      Liquid::ParseContext.new
    )
  end

  before do
    stub_const('TestBlock', Class.new(described_class))
    stub_const('TestRenderer', Class.new)
  end

  describe '.renderer' do
    it 'return the renderer matching the block' do
      expect(TestBlock.renderer).to be TestRenderer
    end
  end

  describe '#render' do
    it 'call #render_svg to render' do
      allow(block).to receive(:read_config)
      allow(block).to receive(:render_svg).and_return 'svg ok!'

      expect(block.render(Liquid::Context.new)).to eq 'svg ok!'
      expect(block).to have_received(:read_config)
    end
  end

  describe '#render_svg' do
    it 'call handle error if error rescued' do
      error = LiquidDiagrams::Errors::BasicError.new

      allow(TestRenderer).to receive(:render).and_raise(error)
      allow(block).to receive(:handle_error)

      block.render_svg

      expect(block).to have_received(:handle_error).with(error)
    end
  end

  describe '#handle_error' do
    it 'simply return the error' do
      expect(block.handle_error('some error')).to eq 'some error'
    end
  end

  describe '#read_config' do
    before do
      allow(LiquidDiagrams).to receive(
        :configuration
      ).and_return({ k1: :v1, k2: :v2 })
      allow(LiquidDiagrams::Utils).to receive(
        :parse_inline_options
      ).and_return({ k1: :v3 })
    end

    it 'merge options with inline options' do
      expect(block.read_config).to eq({ k1: :v3, k2: :v2 })
    end
  end
end
