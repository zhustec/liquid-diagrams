# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::BasicRenderer do
  describe '.render' do
    let(:renderer) { Object.new }

    before do
      allow(renderer).to receive(:render).and_return 'yay'
      allow(described_class).to receive(:new).and_return(renderer)
    end

    it 'create an instance and render with it' do
      expect(described_class.render('content', { k: 'v' })).to eq 'yay'
    end
  end

  describe '#render' do
    let(:renderer) { described_class.new('') }

    it 'raise not implemented error' do
      expect { renderer.render }.to raise_error(
        LiquidDiagrams::Errors::NotImplementedError
      )
    end
  end
end
