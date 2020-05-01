# frozen_string_literal: true

RSpec.describe LiquidDiagrams do
  describe '.renderers' do
    before do
      allow(described_class::Renderers).to receive(:const_get).and_return(Class.new)
      allow(described_class::Renderers).to receive(:constants).and_return(
        %i[FirstRenderer SecondRenderer OtherConstant]
      )
    end

    it 'return and cache renderers' do
      3.times { described_class.renderers }

      expect(described_class.renderers.keys).to eq %w[First Second]
      expect(described_class::Renderers).to have_received(:constants).once
    end
  end

  describe '.blocks' do
    before do
      allow(described_class::Blocks).to receive(:const_get).and_return(Class.new)
      allow(described_class::Blocks).to receive(:constants).and_return(
        %i[FirstBlock SecondBlock OtherConstant]
      )
    end

    it 'return and cache blocks' do
      3.times { described_class.blocks }

      expect(described_class.blocks.keys).to eq %w[First Second]
      expect(described_class::Blocks).to have_received(:constants).once
    end
  end

  describe '.register_diagrams' do
    before { allow(described_class).to receive(:register_diagram) }

    it 'call .register_diagram for every diagrams' do
      described_class.register_diagrams((1..5).to_a)

      expect(described_class).to have_received(:register_diagram).exactly(5).times
    end
  end

  describe '.register_diagram' do
    before do
      allow(described_class).to receive(:blocks).and_return({ 'Test' => Class.new })
    end

    context 'when diagram not found' do
      it 'raise diagram not found error' do
        expect do
          described_class.register_diagrams(:Diagram)
        end.to raise_error LiquidDiagrams::Errors::DiagramNotFoundError
      end
    end

    context 'when diagram is found' do
      let(:block) { Class.new }

      before do
        allow(Liquid::Template).to receive(:register_tag)
        allow(LiquidDiagrams::Blocks).to receive(:const_get).and_return(block)
      end

      it 'register a liquid tag with the diagram block' do
        described_class.register_diagram(:Test)

        expect(LiquidDiagrams::Blocks).to have_received(:const_get).with('TestBlock')
        expect(Liquid::Template).to have_received(:register_tag).with(:test, block)
      end
    end
  end
end
