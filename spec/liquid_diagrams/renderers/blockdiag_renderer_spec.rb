# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::BlockdiagRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with tempfile', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to eq 'blockdiag -T svg --nodoctype' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(:@config, { 'size' => 10 })
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--size=10'
      end
    end

    context 'when switch is true' do
      it 'build command' do
        renderer.instance_variable_set(:@config, { 'antialias' => true })

        expect(renderer.build_command).to match '--antialias'
      end
    end

    context 'when switch is false' do
      it 'build command' do
        renderer.instance_variable_set(:@config, { 'antialias' => false })

        expect(renderer.build_command).not_to match '--antialias'
      end
    end
  end
end
