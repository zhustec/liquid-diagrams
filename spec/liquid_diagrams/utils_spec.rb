# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Utils do
  describe '.join' do
    context 'with string input' do
      it 'join the string with prefix' do
        args = described_class.join('path', with: ' -I')

        expect(args).to eq ' -Ipath'
      end
    end

    context 'with array input' do
      it 'join the array with prefix' do
        args = described_class.join(
          %w[path1 path2], with: ' -I'
        )

        expect(args).to eq ' -Ipath1 -Ipath2'
      end
    end

    context 'with hash input' do
      it 'join the hash with prefix' do
        args = described_class.join(
          { color: 'red', size: '10' }, with: ' --'
        ) { |k, v| "#{k} #{v}" }

        expect(args).to eq ' --color red --size 10'
      end
    end
  end

  describe '.merge' do
    it 'merge the hash' do
      hash = described_class.merge({ k1: 1, k2: 2 }, { k1: 11, k3: 13 })

      expect(hash).to eq({ k1: 11, k2: 2 })
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
end
