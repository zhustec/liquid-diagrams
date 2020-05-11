# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::GraphvizRenderer, :renderers do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end

  describe '#executable' do
    it { expect(renderer.executable).to eq 'dot -Tsvg' }
  end

  describe '#arguments' do
    context 'with string attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'graph_attributes' => 'color=red' }
        )
      end

      it do
        expect(renderer.arguments).to match '-Gcolor=red'
      end
    end

    context 'with array attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'node_attributes' => %w[color=red size=10] }
        )
      end

      it do
        expect(renderer.arguments).to match '-Ncolor=red -Nsize=10'
      end
    end

    context 'with hash attributes' do
      before do
        renderer.instance_variable_set(
          :@config, { 'edge_attributes' => { 'color': 'red', 'size': '10' } }
        )
      end

      it do
        expect(renderer.arguments).to match '-Ecolor=red -Esize=10'
      end
    end
  end
end
