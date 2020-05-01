# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::PlantumlRenderer do
  subject(:renderer) { described_class.new('content') }

  describe '#render' do
    before do
      allow(renderer).to receive(:build_command)
      allow(renderer).to receive(:render_with_stdin_stdout).and_return(
        +'<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg></svg>'
      )
    end

    it 'call build_command' do
      renderer.render

      expect(renderer).to have_received(:build_command)
    end

    it 'render with stdin and stdout' do
      renderer.render

      expect(renderer).to have_received(:render_with_stdin_stdout)
    end

    it 'remove xml heading' do
      expect(renderer.render).to eq '<svg></svg>'
    end
  end

  describe '#build_command' do
    it do
      command = renderer.build_command

      expect(command).to match 'Plantuml'
      expect(command).to match '-tsvg -pipe'
    end
  end
end
