# frozen_string_literal: true

RSpec.shared_examples 'render with stdin and stdout' do |klass|
  let(:renderer) { klass.new 'content' }

  before do
    allow(renderer).to receive(:build_command).and_return 'cmd'
    allow(LiquidDiagrams::Rendering).to receive(
      :render_with_stdin_stdout
    ).and_return 'ok'
  end

  it 'render with stdin and stdout' do
    expect(renderer.render).to eq 'ok'

    expect(LiquidDiagrams::Rendering).to have_received(
      :render_with_stdin_stdout
    ).with('cmd', 'content')
  end
end

RSpec.shared_examples 'render with tempfile' do |klass|
  let(:renderer) { klass.new 'content' }

  before do
    allow(renderer).to receive(:build_command)
    allow(LiquidDiagrams::Rendering).to receive(
      :render_with_tempfile
    ).and_yield('in', 'out').and_return 'ok'
  end

  it 'render with tempfile' do
    expect(renderer.render).to eq 'ok'
    expect(LiquidDiagrams::Rendering).to have_received(:render_with_tempfile)
  end
end
