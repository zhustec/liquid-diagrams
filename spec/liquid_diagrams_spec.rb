# frozen_string_literal: true

RSpec.describe LiquidDiagrams do
  describe '.configuration' do
    let(:key) { :liquid_diagrams }

    context 'with no key' do
      it 'default is empty hash' do
        expect(described_class.configuration({})).to eq({})
      end

      it 'allow symbol key' do
        expect(described_class.configuration({ key => 'sym' })).to eq 'sym'
      end

      it 'allow string key' do
        expect(described_class.configuration({ key.to_s => 'str' })).to eq 'str'
      end

      it 'prefer symbol key' do
        expect(
          described_class.configuration({ key => 'sym', key.to_s => 'str' })
        ).to eq 'sym'
      end
    end

    context 'with optional key' do
      it 'default is empty hash' do
        expect(described_class.configuration({}, key: :test)).to eq({})
      end

      it 'allow symbol key' do
        expect(
          described_class.configuration({ key => { k1: :v1 } }, key: :k1)
        ).to eq :v1
      end

      it 'allow string key' do
        expect(
          described_class.configuration({ key => { 'k1' => :v1 } }, key: :k1)
        ).to eq :v1
      end

      it 'prefer symbol key' do
        expect(
          described_class.configuration({ key => { k1: :v1, 'k1' => :v2 } }, key: :k1)
        ).to eq :v1
      end
    end
  end

  describe '.diagrams' do
    before do
      allow(described_class).to receive(:renderers).and_return({})
    end

    it 'return and cache diagrams' do
      3.times { described_class.diagrams }

      expect(described_class).to have_received(:renderers).once
    end
  end

  describe '.renderers' do
    before do
      allow(described_class::Renderers).to receive(:constants).and_return(
        %i[FirstRenderer SecondRenderer OtherConstant]
      )
      allow(described_class::Renderers).to receive(:const_get)
    end

    it 'return and cache renderers' do
      3.times { described_class.renderers }

      expect(described_class.renderers.keys).to eq %i[first second]
      expect(described_class::Renderers).to have_received(:constants).once
    end
  end

  describe '.registered_diagrams' do
    it { expect(described_class.registered_diagrams).to eq({}) }
  end

  describe '.register_diagrams' do
    before { allow(described_class).to receive(:register_diagram).and_return '!' }

    it 'call .register_diagram for every diagrams' do
      described_class.register_diagrams(('a'..'e').to_a)

      expect(described_class).to have_received(:register_diagram).exactly(5).times
    end
  end

  describe '.register_diagram' do
    before do
      allow(described_class).to receive(:diagrams).and_return({ test: Class.new })
    end

    context 'when diagram not found' do
      it 'raise diagram not found error' do
        expect do
          described_class.register_diagrams(:unkown)
        end.to raise_error LiquidDiagrams::Errors::DiagramNotFoundError
      end
    end

    context 'when diagram is found' do
      let(:block) { Class.new }

      before do
        allow(Liquid::Template).to receive(:register_tag)
        allow(described_class::Blocks).to receive(:const_get).and_return(block)
        allow(described_class).to receive(:registered_diagrams).and_return({})

        described_class.register_diagram(:test)
      end

      it 'search diagram block in Blocks module' do
        expect(LiquidDiagrams::Blocks).to have_received(:const_get).with('TestBlock')
      end

      it 'register a liquid tag with the diagram block' do
        expect(Liquid::Template).to have_received(:register_tag).with(:test, block)
      end

      it 'store diagram to .registered_diagrams' do
        expect(described_class).to have_received(:registered_diagrams)
      end
    end
  end
end
