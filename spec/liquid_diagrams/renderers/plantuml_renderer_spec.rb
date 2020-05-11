# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::PlantumlRenderer, :renderers do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    before do
      allow(renderer).to receive(:build_command)
      allow(LiquidDiagrams::Rendering).to receive(
        :render_with_stdin_stdout
      ).and_return('<?xml version="1.0" encoding="UTF-8" standalone="no"?><>')
    end

    it 'render with stdin and stdout' do
      renderer.render

      expect(renderer).to have_received(:build_command)
      expect(LiquidDiagrams::Rendering).to have_received(:render_with_stdin_stdout)
    end

    it 'remove xml heading' do
      expect(renderer.render).to eq '<>'
    end
  end

  describe '#executable' do
    it { expect(renderer.executable).to match '-tsvg -pipe' }
  end
end
