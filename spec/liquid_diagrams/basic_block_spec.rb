# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::BasicBlock do
  let(:block) do
    TestBlock.parse(
      'test', '', Liquid::Tokenizer.new('{% endtest %}'),
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
    it 'call #render!' do
      allow(block).to receive(:render!).and_return 'success'

      expect(block.render(Liquid::Context.new)).to eq 'success'
    end

    context 'when rendering failed' do
      let(:error) { LiquidDiagrams::Errors::BasicError.new }

      it 'rescue and return the error' do
        allow(block).to receive(:render!).and_raise(error)

        expect(block.render(Liquid::Context.new)).to eq error
      end
    end
  end

  describe '#render!' do
    it 'render with renderer' do
      allow(TestRenderer).to receive(:render).and_return 'success'

      expect(block.render!(Liquid::Context.new, '')).to eq 'success'
    end
  end
end
