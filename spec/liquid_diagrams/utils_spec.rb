# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Utils do
  describe '.join' do
    context 'with string input' do
      it 'join the string with prefix' do
        args = described_class.join('path', with: ' -I')

        expect(args).to eq '-Ipath'
      end
    end

    context 'with array input' do
      it 'join the array with prefix' do
        args = described_class.join(
          %w[path1 path2], with: ' -I'
        )

        expect(args).to eq '-Ipath1 -Ipath2'
      end
    end

    context 'with hash input' do
      it 'join the hash with prefix' do
        args = described_class.join(
          { color: 'red', size: '10' }, with: ' --'
        ) { |k, v| "#{k} #{v}" }

        expect(args).to eq '--color red --size 10'
      end
    end
  end

  describe '.build_options' do
    let(:keys) { %i[color size] }
    let(:config) { { color: :red, scale: 5 } }

    it 'build options from config' do
      expect(described_class.build_options(config, keys)).to eq '--color red'
    end
  end

  describe '.build_flags' do
    let(:keys) { %i[bold italic] }
    let(:config) { { bold: true, center: true, italic: false } }

    it 'build flags from config' do
      expect(described_class.build_flags(config, keys)).to eq '--bold'
    end
  end

  describe '.run_jar' do
    it 'run jar in headless mode' do
      command = described_class.run_jar('test.jar')

      expect(command).to match '-Djava.awt.headless=true'
      expect(command).to match '-jar test.jar'
    end
  end

  describe '.vendor_path' do
    context 'with no input' do
      it 'return the vendor directory path' do
        expect(described_class.vendor_path).to end_with 'vendor/'
      end
    end

    context 'with input file name' do
      it 'return the file path under vendor direcotry' do
        expect(described_class.vendor_path('file')).to end_with 'vendor/file'
      end
    end
  end

  describe '.parse_inline_options' do
    it 'parse inline options' do
      input = 'a1=v1 a2="v2" a3="k3 v3"'

      options = described_class.parse_inline_options(input)

      expect(options).to match a_hash_including(
        'a1' => 'v1', 'a2' => 'v2', 'a3' => 'k3 v3'
      )
    end
  end
end
