# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::MermaidRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with tempfile', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to match 'mmdc --puppeteerConfigFile' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(:@config, { 'scale' => 10, 'color' => :blue })
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--scale 10'
      end

      it 'ignore unsupported configuration' do
        expect(renderer.build_command).not_to match '--color blue'
      end
    end
  end
end
