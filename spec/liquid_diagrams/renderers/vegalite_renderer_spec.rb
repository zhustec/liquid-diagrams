# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::VegaliteRenderer, :renderers do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end

  describe '#executable' do
    it { expect(renderer.executable).to eq 'vl2svg' }
  end
end
