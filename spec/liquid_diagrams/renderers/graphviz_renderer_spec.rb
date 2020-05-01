# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::GraphvizRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to eq 'dot -Tsvg' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(:@config, { 'layout' => 'dot' })
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '-Kdot'
      end
    end

    context 'with string attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'graph_attributes' => 'color=red' }
        )
      end

      it 'build command' do
        expect(renderer.build_command).to match ' -Gcolor=red'
      end
    end

    context 'with array attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'node_attributes' => %w[color=red size=10] }
        )
      end

      it 'build command' do
        expect(renderer.build_command).to match ' -Ncolor=red -Nsize=10'
      end
    end

    context 'with hash attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'edge_attributes' => { 'color': 'red', 'size': '10' } }
        )
      end

      it 'build command' do
        expect(renderer.build_command).to match ' -Ecolor=red -Esize=10'
      end
    end
  end
end
