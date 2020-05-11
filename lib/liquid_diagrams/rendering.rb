# frozen_string_literal: true

require 'open3'
require 'tempfile'
require 'tmpdir'

module LiquidDiagrams
  module Rendering
    module_function

    def render_with_stdin_stdout(command, content)
      options = yield command if block_given?
      command = "#{command} #{options}".strip

      render_with_command(command, :stdout, stdin_data: content)
    end

    def render_with_tempfile(command, content)
      input = Tempfile.new('input')
      output = Tempfile.new(%w[output .svg])

      File.write(input.path, content)

      options = yield input.path, output.path
      command = "#{command} #{options}".strip

      render_with_command(command, output.path)
    ensure
      input.close!
      output.close!
    end

    def render_with_command(command, output = :stdout, **options)
      begin
        stdout, stderr, status = Open3.capture3(command, **options)
      rescue Errno::ENOENT
        raise Errors::CommandNotFoundError, command.split(' ')[0]
      end

      unless status.success?
        msg = "#{command}: #{stderr.empty? ? stdout : stderr}"

        raise Errors::RenderingFailedError, msg
      end

      output == :stdout ? stdout : File.read(output)
    end
  end
end
