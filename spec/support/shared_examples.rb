# frozen_string_literal: true

RSpec.shared_examples 'render with stdin and stdout' do |kclass|
  let(:renderer) { kclass.new 'content' }

  before do
    allow(renderer).to receive(:build_command).and_return 'cmd'
    allow(LiquidDiagrams::Rendering).to receive(
      :render_with_stdin_stdout
    ).and_return 'ok'
  end

  it 'call build_command' do
    renderer.render

    expect(renderer).to have_received(:build_command)
  end

  it 'render with tempfile' do
    expect(renderer.render).to eq 'ok'

    expect(LiquidDiagrams::Rendering).to have_received(
      :render_with_stdin_stdout
    ).with('cmd', renderer.instance_variable_get(:@content))
  end
end

RSpec.shared_examples 'render with tempfile' do |kclass|
  let(:renderer) { kclass.new 'content' }

  before do
    allow(renderer).to receive(:build_command)
    allow(LiquidDiagrams::Rendering).to receive(
      :render_with_tempfile
    ).and_yield('in', 'out')

    renderer.render
  end

  it 'call build_command' do
    expect(renderer).to have_received(:build_command)
  end

  it 'render with tempfile' do
    expect(LiquidDiagrams::Rendering).to have_received(:render_with_tempfile)
  end
end
