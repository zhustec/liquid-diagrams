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

  describe '#config' do
    it 'merge template options with inline options' do
      allow(block).to receive(:template_options).and_return({ k1: :v1 })
      allow(block).to receive(:inline_options).and_return({ k1: :v2, k2: :v2 })

      expect(block.config).to eq({ k1: :v2, k2: :v2 })
    end
  end

  describe '#template_options' do
    let(:key) { LiquidDiagrams::OPTIONS_KEY }

    it 'accept symbol key' do
      allow(block).to receive(:parse_context).and_return({ key => { test: '1' } })

      expect(block.template_options).to eq '1'
    end

    it 'accept string key' do
      allow(block).to receive(:parse_context).and_return({ key => { 'test' => '2' } })

      expect(block.template_options).to eq '2'
    end
  end

  describe '#inline_options' do
    let(:markup) { 'a1=v1 a2="v2" a3="k3 v3"' }

    let :block do
      TestBlock.parse(
        'test', markup, Liquid::Tokenizer.new('{% endtest %}'),
        Liquid::ParseContext.new
      )
    end

    before do
      allow(LiquidDiagrams::Utils).to receive :parse_inline_options
    end

    it 'call Utils.parse_inline_options' do
      block.inline_options

      expect(LiquidDiagrams::Utils).to have_received(
        :parse_inline_options
      ).with(markup)
    end
  end
end
