# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::BasicRenderer do
  let(:renderer) { described_class.new('') }

  describe '.render' do
    before do
      allow(renderer).to receive(:render).and_return 'yay'
      allow(described_class).to receive(:new).and_return(renderer)
    end

    it 'create an instance and render with it' do
      expect(described_class.render('content', { k: :v })).to eq 'yay'
    end
  end

  describe '#render' do
    it 'raise not implemented error' do
      expect { renderer.render }.to raise_error(
        LiquidDiagrams::Errors::NotImplementedError
      )
    end
  end

  describe '#build_command' do
    it 'combine #executable and #arguments' do
      allow(renderer).to receive(:executable).and_return 'cmd'
      allow(renderer).to receive(:arguments).and_return '--flag --opt val'

      expect(renderer.build_command).to eq 'cmd --flag --opt val'
    end
  end

  describe '#executable' do
    it 'provide a default executable' do
      expect(renderer.executable).to eq 'basic'
    end
  end

  describe '#arguments' do
    it 'combine options and flags' do
      allow(LiquidDiagrams::Utils).to receive(:build_flags).and_return '--flag'
      allow(LiquidDiagrams::Utils).to receive(:build_options).and_return '--opt val'

      expect(renderer.arguments).to eq '--flag --opt val'
    end
  end
end
