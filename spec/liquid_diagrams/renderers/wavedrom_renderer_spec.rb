# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::WavedromRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with tempfile', described_class
  end

  describe '#build_command' do
    it { expect(renderer.build_command).to eq 'wavedrom-cli' }
  end
end
