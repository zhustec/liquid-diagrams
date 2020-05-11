# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::SvgbobRenderer, :renderers do
  describe '#render' do
    include_examples 'render with stdin and stdout', described_class
  end
end
