# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::BitfieldRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with tempfile', described_class
  end

  describe '#build_command' do
    context 'when config is empty' do
      it { expect(renderer.build_command).to match 'bitfield' }
    end

    context 'when config is not empty' do
      before do
        renderer.instance_variable_set(:@config, { 'fontsize' => 10 })
      end

      it 'build command with config' do
        expect(renderer.build_command).to match '--fontsize 10'
      end
    end
  end
end
