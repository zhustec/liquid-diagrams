# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LiquidDiagrams::Rendering do
  describe '.render_with_stdin_stdout' do
    it 'call render_with_command' do
      allow(described_class).to receive(:render_with_command)

      described_class.render_with_stdin_stdout('command', 'content')

      expect(described_class).to have_received(:render_with_command).with(
        'command', :stdout, stdin_data: 'content'
      )
    end
  end

  describe '.render_with_tempfile' do
    let(:input) { Object.new }
    let(:output) { Object.new }

    before do
      allow(described_class).to receive(:render_with_command)

      allow(File).to receive(:write)
      allow(Tempfile).to receive(:new).and_return(input, output)

      allow(input).to receive(:path)
      allow(input).to receive(:close!)
      allow(output).to receive(:path)
      allow(output).to receive(:close!)
    end

    it 'call Tempfile.new twice to create input and output file' do
      described_class.render_with_tempfile('command', 'content') {}

      expect(Tempfile).to have_received(:new).twice
    end

    it 'yield input path and output path' do
      described_class.render_with_tempfile('command', 'content') {}

      expect(input).to have_received(:path).twice
      expect(output).to have_received(:path).twice
    end

    it 'close input and output file after rendering' do
      described_class.render_with_tempfile('command', 'content') {}

      expect(input).to have_received(:close!).once
      expect(output).to have_received(:close!).once
    end

    it 'call render_with_command' do
      described_class.render_with_tempfile('command', 'content') {}

      expect(described_class).to have_received(:render_with_command)
    end
  end

  describe '.render_with_command' do
    it 'call Open3.capture3' do
      status = Object.new

      allow(status).to receive(:success?).and_return(true)
      allow(Open3).to receive(:capture3).and_return(['o', 'e', status])

      described_class.render_with_command('command')

      expect(Open3).to have_received(:capture3)
    end

    context 'when command is not found' do
      it 'raise a command not found error' do
        allow(Open3).to receive(:capture3).and_raise(Errno::ENOENT)

        expect do
          described_class.render_with_command('command')
        end.to raise_error LiquidDiagrams::Errors::CommandNotFoundError
      end
    end

    context 'when rendering failed' do
      before do
        status = Object.new

        allow(status).to receive(:success?).and_return(false)
        allow(Open3).to receive(:capture3).and_return(['o', 'e', status])
      end

      it 'raise a rendering failed error' do
        expect do
          described_class.render_with_command('command')
        end.to raise_error LiquidDiagrams::Errors::RenderingFailedError
      end
    end

    context 'when output is stdout' do
      before do
        status = Object.new

        allow(status).to receive(:success?).and_return(true)
        allow(Open3).to receive(:capture3).and_return(['o', 'e', status])
      end

      it 'read output from stdout' do
        expect(described_class.render_with_command('cmd', :stdout)).to eq 'o'
      end
    end

    context 'when output is a file' do
      before do
        status = Object.new

        allow(status).to receive(:success?).and_return(true)
        allow(Open3).to receive(:capture3).and_return(['o', 'e', status])
        allow(File).to receive(:read)
      end

      it 'read output from the file' do
        described_class.render_with_command('cmd', 'a_file')

        expect(File).to have_received(:read).with('a_file')
      end
    end
  end
end
