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
    it 'call #render_with_rescue' do
      allow(block).to receive(:render_with_rescue).and_return 'success'

      expect(block.render(Liquid::Context.new)).to eq 'success'
    end
  end

  describe '#render_with_rescue' do
    it 'call #render_without_rescue' do
      allow(block).to receive(:render_without_rescue).and_return 'success'

      expect(block.render(Liquid::Context.new)).to eq 'success'
    end

    it 'rescue and handle the error' do
      allow(block).to receive(:render_without_rescue).and_raise(
        LiquidDiagrams::Errors::BasicError.new
      )
      allow(block).to receive(:handle_error).and_return 'ok'

      expect(block.render(Liquid::Context.new)).to eq 'ok'
    end
  end

  describe '#render_without_rescue' do
    it 'render with renderer' do
      allow(TestRenderer).to receive(:render).and_return 'success'

      expect(block.render(Liquid::Context.new)).to eq 'success'
    end
  end
end
