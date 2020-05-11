# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Renderers::NetlistsvgRenderer, :renderers do
  describe '#render' do
    include_examples 'render with tempfile', described_class
  end
end
