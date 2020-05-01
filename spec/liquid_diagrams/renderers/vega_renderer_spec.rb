# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::VegaRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to eq 'vg2svg' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(
          :@config, { 'scale' => 10, 'other' => 'value' }
        )
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--scale 10'
      end

      it 'ignore unsupported configuration' do
        expect(renderer.build_command).not_to match '--other'
      end
    end
  end
end
