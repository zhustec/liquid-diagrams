# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::SmcatRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with tempfile', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to eq 'Smcat' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(
          :@config, { 'engine' => 'dot', 'color' => :blue }
        )
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--engine dot'
      end

      it 'ignore unsupported configuration' do
        expect(renderer.build_command).not_to match '--color blue'
      end
    end
  end
end
