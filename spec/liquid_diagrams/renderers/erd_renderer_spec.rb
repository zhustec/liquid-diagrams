# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::ErdRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to eq 'erd --fmt=svg' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(
          :@config, { 'edge' => 10, 'color' => :blue }
        )
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--edge=10'
      end

      it 'ignore unsupported configuration' do
        expect(renderer.build_command).not_to match '--color'
      end
    end

    context 'when switch is true' do
      it 'build command' do
        renderer.instance_variable_set(:@config, { 'dot-entity' => true })

        expect(renderer.build_command).to match '--dot-entity'
      end
    end

    context 'when switch is false' do
      it 'build command' do
        renderer.instance_variable_set(:@config, { 'dot-entity' => false })

        expect(renderer.build_command).not_to match '--dot-entity'
      end
    end
  end
end
